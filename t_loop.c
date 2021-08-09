/*
 * Copyright (C) 2021 Parnart, Inc.
 * Arlington, Virginia USA
 *(703) 528-3280 http://www.parnart.com
 *
 * All rights reserved.
 *
*/

/*----------------------------------------------------------------*/
/* t_loop.c						  */
/*----------------------------------------------------------------*/

#include <libpq-fe.h>
#include <mosquitto.h>
#include <ncurses.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#include "arduino.h"

void t_loop(s_data_t *data)
{
	int i, looper;
	char topic[32], printbuff[SIZE_PRINTBUFF];
	struct timeval timeout;
	char prepared_dio_age[] = "select status_dio.unit, unit.address, unit.name, extract(epoch from (now() - status_dio.updated)) from status_dio, unit where unit.id = status_dio.unit and unit.online = 't' and unit.dio_mode <> 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';";
	char prepared_sensor_age[] = "select status_sensor.unit, unit.address, unit.name, extract(epoch from (now() - status_sensor.updated)) from status_sensor, unit where unit.id = status_sensor.unit and unit.online = 't';";
	pid_t pid;
	FILE *pidfd;
	
	pthread_mutex_t *pmut_sql = &data->mut_sql;
		
	PGconn *conn = data->conn;
	PGresult *res1;

	
	pid = getpid();
	pidfd = fopen(data->pid_path, "a");
	fprintf(pidfd, "t_loop: %i\n", pid);
	fclose(pidfd);

	pthread_mutex_lock(pmut_sql);
	res1 = PQprepare(conn, "prepared_dio_age", prepared_dio_age , 0, NULL);
	pthread_mutex_unlock(pmut_sql);
	PQclear(res1);

	pthread_mutex_lock(pmut_sql);
	res1 = PQprepare(conn, "prepared_sensor_age", prepared_sensor_age, 0, NULL);
	pthread_mutex_unlock(pmut_sql);
	PQclear(res1);

	sleep(10);
	looper = 10;
	while(data->quit == FALSE) {
		if (looper == 10) {

			pthread_mutex_lock(pmut_sql);
			//res1 = PQexec(conn, "select address, extract(epoch from (now() - updated)) from status_dio;");
			res1 = PQexecPrepared(conn, "prepared_dio_age", 0, NULL, NULL, NULL, 0);
			pthread_mutex_unlock(pmut_sql);
			for (i = 0; i < PQntuples(res1); i++) {
				if (atof(PQgetvalue(res1, i, 3)) > 30.0) {

					memset(printbuff, 0, SIZE_PRINTBUFF);
					sprintf(printbuff, "unit %02d DIO polling (%s)", atoi(PQgetvalue(res1, i, 0)), PQgetvalue(res1, i, 2));
					do_print(data, printbuff, RED);

					memset(topic, 0, sizeof(topic));
					sprintf(topic, "arduino/%s/in/dio", PQgetvalue(res1, i, 1));
					mosquitto_publish(data->mosq, NULL, topic, 3, "dio", 0, false);
				}
				timeout.tv_sec = (long) 0;
				timeout.tv_usec = (long) 200087;
				select(0, (fd_set *) 0, (fd_set *) 0, (fd_set *) 0, &timeout);
			
			}	
			PQclear(res1);

			sleep(2);

			pthread_mutex_lock(pmut_sql);
			//res1 = PQexec(conn, "select address, extract(epoch from (now() - updated)) from status_sensor;");
			res1 = PQexecPrepared(conn, "prepared_sensor_age", 0, NULL, NULL, NULL, 0);
			pthread_mutex_unlock(pmut_sql);
			for (i = 0; i < PQntuples(res1); i++) {
				if (atof(PQgetvalue(res1, i, 3)) > 45.0) {

					memset(printbuff, 0, SIZE_PRINTBUFF);
					sprintf(printbuff, "unit %02d ANA/I2C polling (%s)", atoi(PQgetvalue(res1, i, 0)), PQgetvalue(res1, i, 2));
					do_print(data, printbuff, BLUE);

					memset(topic, 0, sizeof(topic));
					sprintf(topic, "arduino/%s/in/ain", PQgetvalue(res1, i, 1));
					mosquitto_publish(data->mosq, NULL, topic, 3, "ain", 0, false);
					sleep(1);
					memset(topic, 0, sizeof(topic));
					sprintf(topic, "arduino/%s/in/i2c", PQgetvalue(res1, i, 1));
					mosquitto_publish(data->mosq, NULL, topic, 3, "i2c", 0, false);
					
				}
				timeout.tv_sec = (long) 0;
				timeout.tv_usec = (long) 200087;
				select(0, (fd_set *) 0, (fd_set *) 0, (fd_set *) 0, &timeout);
			
			}	
			PQclear(res1);

			looper = 1;
		}
		//memset(printbuff, 0, SIZE_PRINTBUFF);
		//sprintf(printbuff, "\npolling loop complete...\n");
		//do_print(data, printbuff, RED);

		timeout.tv_sec = (long) 1;
		timeout.tv_usec = (long) 0;
		select(0, (fd_set *) 0, (fd_set *) 0, (fd_set *) 0, &timeout);
		looper++;
	}
}
