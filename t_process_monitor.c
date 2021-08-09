/*
 * Copyright (C) 2003 Parnart, Inc.
 * Arlington, Virginia USA
 *(703) 528-3280 http://www.parnart.com
 *
 * All rights reserved.
 *
*/

/*----------------------------------------------------------------*/
/* t_process_monitor.c						  */
/*----------------------------------------------------------------*/

#include <libpq-fe.h>
#include <ncurses.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>

#include "arduino.h"

/*int make_connection(int *);*/

void t_process_monitor(s_data_t *data)
{
	char tbuff[128];
	struct timeval timeout;
	struct stat statbuf;
	mode_t modes;
	pid_t pid;
	FILE *pidfd;
	PGconn *conn = NULL;
	PGresult *res1 = NULL;
	
	pthread_mutex_t *pmut_sql;

	conn = data->conn;
	//pthread_mutex_t *pmut_write = &data->mut_write;

	pid = getpid();
	pidfd = fopen(data->pid_path, "a");
	fprintf(pidfd, "t_monitor: %i\n", pid);
	fclose(pidfd);

	pmut_sql = &data->mut_sql;

	while(data->quit == FALSE){

		//application cleanup procedure
		memset(&statbuf, 0, sizeof(statbuf));
		stat(data->pid_path, &statbuf);
		modes = statbuf.st_mode;
		if(!S_ISREG(modes)){
			data->quit = TRUE;
			memset(tbuff, 0, sizeof(tbuff));
			sprintf(tbuff, "select pg_notify('req_arduino_mqtt', '');");
			pthread_mutex_lock(pmut_sql);
			res1 = PQexec(conn, tbuff);
			pthread_mutex_unlock(pmut_sql);
			PQclear(res1);
			//continue;						
		}
		if (data->curses)
			getmaxyx(data->w_main, data->winheight, data->winwidth);


		timeout.tv_sec = (long) 0;
		timeout.tv_usec = (long) 510000;
		select(0, (fd_set *) 0, (fd_set *) 0, (fd_set *) 0, &timeout);
	}

	unlink(data->pid_path);
}

/*int make_connection(int *sockfd){

	struct sockaddr_in address;
	int len;

	*sockfd = socket(AF_INET, SOCK_STREAM, 0);
	address.sin_family = AF_INET;
	address.sin_addr.s_addr = inet_addr("127.0.0.1");
	address.sin_port = htons(5432);
	len = sizeof(address);
	connect(*sockfd, (struct sockaddr *) &address, len);

	return(1);

}*/
