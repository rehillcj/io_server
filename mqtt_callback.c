/*
 * Copyright (C) 2021 Parnart, Inc.
 * Arlington, Virginia USA
 *(703) 528-3280 http://www.parnart.com
 *
 * All rights reserved.
 *
*/

/*----------------------------------------------------------------*/
/* message_callback.c							  */
/*----------------------------------------------------------------*/

#include <errno.h>
#include <libpq-fe.h>
#include <mosquitto.h>
#include <ncurses.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h> //threads
#include <string.h>
#include <time.h>

#include "arduino.h"

	
void message_callback(struct mosquitto *mosq, void *obj, const struct mosquitto_message *message) {
	char msg[128];
	char topic[32];
	char tbuff[1024];
	char address[12];
	char printbuff[SIZE_PRINTBUFF];
	bool topic_test;
	int unit;

	PGconn *conn = NULL;
	PGresult *res1 = NULL;
	PGresult *res2 = NULL;
	pthread_mutex_t *pmut_sql = NULL;

	s_data_t *data;


	memset(msg, 0, sizeof(msg));
	memset(topic, 0, sizeof(topic));
	memset(address, 0, sizeof(address));

	data = obj;
	conn = data->conn;
	pmut_sql = &data->mut_sql;
	//printf("db: %s\n", data->db_name);

	//printf ("topic: %s  length: %i    message: %s\n", message->topic, message->payloadlen, (char *) message->payload);
	//printf ("Got message topic: %s\t%i:%x\n", message->topic, message->payloadlen, (unsigned char *) (message->payload + 1));
	sprintf(msg, "%s", (char *) message->payload);
	sprintf(topic, "%s", message->topic);
	
	
	address[0] = message->topic[8];
	address[1] = message->topic[9];
	address[2] = message->topic[10];
	address[3] = message->topic[11];
	address[4] = message->topic[12];
	address[5] = message->topic[13];
	address[6] = message->topic[14];
	address[7] = 0;

	memset(tbuff, 0, sizeof(tbuff));
	sprintf(tbuff, "select id, name from unit where address = '%s';", address);
	pthread_mutex_lock(pmut_sql);
	res2 = PQexec(conn, tbuff);
	pthread_mutex_unlock(pmut_sql);
	
	unit = atoi(PQgetvalue(res2, 0, 0));

  	mosquitto_topic_matches_sub("arduino/+/out/i2c", message->topic, &topic_test);
  	if (topic_test) {
		float tarray[3];
		char *token;
		int i;
				
		token = strtok(msg, ":");
		i = 0;
		while (token != NULL) {
			tarray[i] = atof(token) / 100.0;
			token = strtok(NULL, ":");
			i++;
		}

		memset(printbuff, 0, SIZE_PRINTBUFF);
		sprintf(printbuff, "unit %02d I2C i00:%0.1f  i01:%0.1f  i02:%0.2f (%s)", unit, tarray[0], tarray[1], tarray[2], PQgetvalue(res2, 0, 1));
		do_print(data, printbuff, GREEN);
		
		memset(tbuff, 0, sizeof(tbuff));
		sprintf(tbuff, "update status_sensor set i00='%0.2f', i01='%0.2f', i02='%0.2f' where unit='%i';", tarray[0], tarray[1], tarray[2], unit);
		pthread_mutex_lock(pmut_sql);
		res1 = PQexec(conn, tbuff);
		pthread_mutex_unlock(pmut_sql);
		PQclear(res1);

	} else {
		mosquitto_topic_matches_sub("arduino/+/out/ain", message->topic, &topic_test);
		if (topic_test) {
			int tarray[16];
			int test = 0;
			char *token;
			int i;
			
			for (int i = 0; i < 16; i++)
				tarray[i] = 0;

			token = strtok(msg, ":");
			i = 0;
			while (token != NULL) {
				tarray[i] = atoi(token);
				token = strtok(NULL, ":");
				i++;
			}

			test = 0;
			for (int i = 0; i < 16; i++)
				if (tarray[i])
					test = 1;
			
			if (test) {
		        	memset(printbuff, 0, SIZE_PRINTBUFF);
        			sprintf(printbuff, "unit %02d ANA a00:%i  a01:%i  a02:%i  a03:%i  a04:%i  a05:%i  a06:%i  a07:%i  a08:%i  a09:%i  a10:%i  a11:%i  a12:%i  a13:%i  a14:%i  a15:%i (%s)", unit, tarray[0], tarray[1], tarray[2], tarray[3], tarray[4], tarray[5], tarray[6], tarray[7], tarray[8], tarray[9], tarray[10], tarray[11], tarray[12], tarray[13], tarray[14], tarray[15], PQgetvalue(res2, 0, 1));
        			do_print(data, printbuff, YELLOW);

				memset(tbuff, 0, sizeof(tbuff));
				sprintf(tbuff, "update status_sensor set \
a00='%i', a01='%i', a02='%i', a03='%i', a04='%i', a05='%i', a06='%i', a07='%i', \
a08='%i', a09='%i', a10='%i', a11='%i', a12='%i', a13='%i', a14='%i', a15='%i' \
where unit='%i';", \
tarray[0], tarray[1], tarray[2], tarray[3], tarray[4], tarray[5], tarray[6], tarray[7], \
tarray[8], tarray[9], tarray[10], tarray[11], tarray[12], tarray[13], tarray[14], tarray[15], unit);
				pthread_mutex_lock(pmut_sql);
				res1 = PQexec(conn, tbuff);
				pthread_mutex_unlock(pmut_sql);
				PQclear(res1);
			}
			
		} else {
			mosquitto_topic_matches_sub("arduino/+/out/dio", message->topic, &topic_test);
			if (topic_test) {
				char tarray[55];
				
				memset(tarray, 0, sizeof(tarray));
				memset(tarray, '0', 54);
				tarray[54] = '\0';
				for (int i = 0; i < strlen(msg); i++)
					tarray[i] = msg[i];
				
				//printf("012345678901234567890123456789012345678901234567890123\n");
				//printf("%s\n", tarray);
					
		        	memset(printbuff, 0, SIZE_PRINTBUFF);
	        		sprintf(printbuff, "unit %02d DIO %s (%s)", unit, tarray, PQgetvalue(res2, 0, 1));
        			do_print(data, printbuff, MAGENTA);
        			
        			memset(tbuff, 0, sizeof(tbuff));
				sprintf(tbuff, "update status_dio set \
d00='%c', d01='%c', d02='%c', d03='%c', d04='%c', d05='%c', d06='%c', d07='%c', \
d08='%c', d09='%c', d10='%c', d11='%c', d12='%c', d13='%c', d14='%c', d15='%c', \
d16='%c', d17='%c', d18='%c', d19='%c', d20='%c', d21='%c', d22='%c', d23='%c', \
d24='%c', d25='%c', d26='%c', d27='%c', d28='%c', d29='%c', d30='%c', d31='%c', \
d32='%c', d33='%c', d34='%c', d35='%c', d36='%c', d37='%c', d38='%c', d39='%c', \
d40='%c', d41='%c', d42='%c', d43='%c', d44='%c', d45='%c', d46='%c', d47='%c', \
d48='%c', d49='%c', d50='%c', d51='%c', d52='%c', d53='%c' where unit='%i';", \
(tarray[0] == '0' ? 't' : 'f'), (tarray[1] == '0' ? 't' : 'f'), (tarray[2] == '0' ? 't' : 'f'), (tarray[3] == '0' ? 't' : 'f'), (tarray[4] == '0' ? 't' : 'f'), (tarray[5] == '0' ? 't' : 'f'), (tarray[6] == '0' ? 't' : 'f'), (tarray[7] == '0' ? 't' : 'f'), \
(tarray[8] == '0' ? 't' : 'f'), (tarray[9] == '0' ? 't' : 'f'), (tarray[10] == '0' ? 't' : 'f'), (tarray[11] == '0' ? 't' : 'f'), (tarray[12] == '0' ? 't' : 'f'), (tarray[13] == '0' ? 't' : 'f'), (tarray[14] == '0' ? 't' : 'f'), (tarray[15] == '0' ? 't' : 'f'), \
(tarray[16] == '0' ? 't' : 'f'), (tarray[17] == '0' ? 't' : 'f'), (tarray[18] == '0' ? 't' : 'f'), (tarray[19] == '0' ? 't' : 'f'), (tarray[20] == '0' ? 't' : 'f'), (tarray[21] == '0' ? 't' : 'f'), (tarray[22] == '0' ? 't' : 'f'), (tarray[23] == '0' ? 't' : 'f'), \
(tarray[24] == '0' ? 't' : 'f'), (tarray[25] == '0' ? 't' : 'f'), (tarray[26] == '0' ? 't' : 'f'), (tarray[27] == '0' ? 't' : 'f'), (tarray[28] == '0' ? 't' : 'f'), (tarray[29] == '0' ? 't' : 'f'), (tarray[30] == '0' ? 't' : 'f'), (tarray[31] == '0' ? 't' : 'f'), \
(tarray[32] == '0' ? 't' : 'f'), (tarray[33] == '0' ? 't' : 'f'), (tarray[34] == '0' ? 't' : 'f'), (tarray[35] == '0' ? 't' : 'f'), (tarray[36] == '0' ? 't' : 'f'), (tarray[37] == '0' ? 't' : 'f'), (tarray[38] == '0' ? 't' : 'f'), (tarray[39] == '0' ? 't' : 'f'), \
(tarray[40] == '0' ? 't' : 'f'), (tarray[41] == '0' ? 't' : 'f'), (tarray[42] == '0' ? 't' : 'f'), (tarray[43] == '0' ? 't' : 'f'), (tarray[44] == '0' ? 't' : 'f'), (tarray[45] == '0' ? 't' : 'f'), (tarray[46] == '0' ? 't' : 'f'), (tarray[47] == '0' ? 't' : 'f'), \
(tarray[48] == '0' ? 't' : 'f'), (tarray[49] == '0' ? 't' : 'f'), (tarray[50] == '0' ? 't' : 'f'), (tarray[51] == '0' ? 't' : 'f'), (tarray[52] == '0' ? 't' : 'f'), (tarray[53] == '0' ? 't' : 'f'), unit);
				pthread_mutex_lock(pmut_sql);
				res1 = PQexec(conn, tbuff);
				pthread_mutex_unlock(pmut_sql);
				PQclear(res1);

			} else {
				mosquitto_topic_matches_sub("arduino/+/out/config", message->topic, &topic_test);
				if (topic_test) {
					char pubtopic[32];
					char pubmsg[128];

					//memset(address, 0, sizeof(address));
					//sprintf(address, "%c%c%c%c%c%c%c", msg[0], msg[1], msg[2], msg[3], msg[4], msg[5], msg[6]);
					memset(printbuff, 0, SIZE_PRINTBUFF);
					sprintf(printbuff, "unit %02d online (%s)", unit, PQgetvalue(res2, 0, 1));
					do_print(data, printbuff, WHITE);

					memset(tbuff, 0, sizeof(tbuff));
					sprintf(tbuff, "update unit set online = 't', online_offline = now() where id = '%i';", unit);
					pthread_mutex_lock(pmut_sql);
					res1 = PQexec(conn, tbuff);
					pthread_mutex_unlock(pmut_sql);
					PQclear(res1);

					memset(tbuff, 0, sizeof(tbuff));
					sprintf(tbuff, "select ain_active, dio_mode, dio_init from unit where id = '%i';", unit);
					pthread_mutex_lock(pmut_sql);
					res1 = PQexec(conn, tbuff);
					pthread_mutex_unlock(pmut_sql);

					memset(pubtopic, 0, sizeof(pubtopic));
					sprintf(pubtopic, "arduino/%s/in/config", address);

					memset(pubmsg, 0, sizeof(pubmsg));
					sprintf(pubmsg, "%s:%s:%s", PQgetvalue(res1, 0, 0), PQgetvalue(res1, 0, 1), PQgetvalue(res1, 0, 2));					

					mosquitto_publish(mosq, NULL, pubtopic, strlen(pubmsg), pubmsg, 0, false);
					//mosquitto_publish(mosq, NULL, topic, strlen("001000:2222111122:0000100000"), "001000:2222111122:0000100000", 0, false);

					PQclear(res1);
				} else {
					mosquitto_topic_matches_sub("arduino/+/out/offline", message->topic, &topic_test);
					if (topic_test) {

						memset(printbuff, 0, SIZE_PRINTBUFF);
						sprintf(printbuff, "unit %02d offline (%s)", unit, PQgetvalue(res2, 0, 1));
						do_print(data, printbuff, WHITE);

						memset(tbuff, 0, sizeof(tbuff));
						sprintf(tbuff, "update unit set online = 'f', online_offline = now() where id = '%i';", unit);
						pthread_mutex_lock(pmut_sql);
						res1 = PQexec(conn, tbuff);
						pthread_mutex_unlock(pmut_sql);
						PQclear(res1);

					}
				}
					
			}
		}
	}
	PQclear(res2);

}
