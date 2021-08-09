/*
 * Copyright (C) 2021 Parnart, Inc.
 * Arlington, Virginia USA
 * (703) 528-3280 http://www.parnart.com
 *
 * All rights reserved.
 *
*/

/*----------------------------------------------------------------*/
/* main.c							  */
/*----------------------------------------------------------------*/

#include <errno.h>
#include <fcntl.h>
#include <libpq-fe.h>
#include <mosquitto.h>
#include <ncurses.h>
#include <pthread.h> //threads
#include <signal.h>  //signal handler
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <syslog.h>
#include <time.h>
#include <unistd.h>  //getopt
#include <sys/io.h> //iopl & nice
#include <sys/resource.h>
#include <sys/stat.h>

#include "arduino.h"

int main(int argc, char *argv[]){

	int i, j, k, opt, nice, socksql;
	s_data_t data;
	struct tm pltime;
	struct timeval timeout;
	time_t now;
	char timestring[22], tbuff[1024], printbuff[SIZE_PRINTBUFF], tmp_path[SIZE_PATHBUFF];
	char dio[3], request[2], unit[3], topic[64], pub[5];
	char *pid_path = data.pid_path;
	char *app_path = data.app_path;
	char *app_name = data.app_name;
	char *init_path = data.init_path;
	char *db_host = data.db_host;
	char *db_user = data.db_user;
	char *db_name = data.db_name;
	char *mqtt_host = data.mqtt_host;
	char *mqtt_user = data.mqtt_user;
	char *mqtt_password = data.mqtt_password;
	char *mqtt_subscribe_topic = data.mqtt_subscribe_topic;
	char *mqtt_port = data.mqtt_port;
			
	struct mosquitto *mosq = NULL;

	fd_set fd_sql;

	struct sigaction sa, sa_old;
	struct stat statbuf;
	mode_t modes;
	
	pthread_t process_monitor, keyboard_handler, loop;
	pthread_mutex_t *pmut_sql;
	
	PGresult *res1;
	PGnotify *notify;
	
	pid_t pid;
	uid_t uid;
	FILE *fd;
	unsigned char daemonize;

	//process command line arguments
	memset(app_path, 0, SIZE_PATHBUFF);
	sprintf(app_path, argv[0]);
	for (i = 0, j = 0; i <= strlen(app_path) - 1; i++)
		if (app_path[i] == 0x2F)
			j = i;
	memset(app_name, 0, SIZE_PATHBUFF);
	for (i = (j == 0) ? 0 : (j + 1), k = 0; i <= (strlen(app_path) - 1); i++, k++)
		app_name[k] = app_path[i];
	app_name[k] = 0;
	
	memset(init_path, 0, SIZE_PATHBUFF);
	sprintf(init_path, "/usr/local/etc/%s.conf", app_name);
	
	
	data.verbose = FALSE;
	data.curses = FALSE;
	data.print = TRUE;
	data.quit = FALSE;
	data.code = 0;
	nice = 0;
	daemonize = 1;

	while((opt = getopt(argc, argv, "dn:vf:ch")) != -1){	//process command line overrides of defaults
		switch(opt){
			case 'd':
				daemonize = 0;
				break;
			case 'n':
				nice = atoi(optarg);
			case 'v':
				daemonize = 0;
				data.verbose = TRUE;
				break;
			case 'f':
				memset(init_path, 0, SIZE_PATHBUFF);
				sprintf(init_path, "%s", optarg);
				break;
			case 'c':
				data.curses = TRUE;
				data.verbose = TRUE;
				daemonize = 0;
				break;
			case 'h':
				printf("%s\n", argv[0]);
				printf("\tthis program must be run as user 'controller'\n");
				printf("\t-n <nice> : nice value (-15)\n");
				printf("\t-d        : run in foreground\n");
				printf("\t-f <file> : start with configuration file <file>\n");
				printf("\t-v        : run in verbose mode (implies -d)\n");
				printf("\t-c        : run in curses mode (implies -d -v)\n");
				printf("\t-h        : print this message\n\n");
				printf("Arduino MQTT-enabled receiver, version 0.10\n");
				printf("Copyright 2021 Parnart, Inc.\n\n");
				exit(-1);
				break;
			case '?':
				printf("try -h for option list\n");
				exit(-1);
				break;
		}
	}

	time(&now);
	localtime_r(&now, &pltime);
	strftime(timestring, 21, "20%y/%m/%d %H:%M:%S", &pltime);

	if (data.curses) {
		initscr();
		start_color();
		init_pair(WHITE, COLOR_WHITE, COLOR_BLACK);
		init_pair(RED, COLOR_RED, COLOR_BLACK);
		init_pair(GREEN, COLOR_GREEN, COLOR_BLACK);
		init_pair(YELLOW, COLOR_YELLOW, COLOR_BLACK);
		init_pair(MAGENTA, COLOR_MAGENTA, COLOR_BLACK);
		init_pair(CYAN, COLOR_CYAN, COLOR_BLACK);
		init_pair(BLUE, COLOR_BLUE, COLOR_BLACK);
		init_pair(BLACK, COLOR_BLACK, COLOR_WHITE);
		getmaxyx(stdscr, data.winheight, data.winwidth);
		data.w_main = newwin(data.winheight - 6, data.winwidth - 2, 1, 1);
		wattron(data.w_main, COLOR_PAIR(WHITE));
		data.winrow_main = 0;
		data.wincol_main = 2;
		scrollok(data.w_main, TRUE);
		//wmove(data.w_main, 0, 0); // was 1, 2
		wrefresh(data.w_main);
		
		data.w_banner = newwin(4, data.winwidth - 2, (data.winheight - 4), 1);
		scrollok(data.w_banner, FALSE);
		wattron(data.w_banner, COLOR_PAIR(WHITE));
		wattron(data.w_banner, A_BOLD);
		wmove(data.w_banner, 1, 3);
		wprintw(data.w_banner, "arduino mqtt processor started %s", timestring);
		wmove(data.w_banner, 1, (data.winwidth - 33));
		wprintw(data.w_banner, "copyright 2021, Conrad Rehill");
		wmove(data.w_banner, 2, 3);
		wprintw(data.w_banner, "type 'q' to quit, 'p' to suspend screen output");
		wrefresh(data.w_banner);
		
	}

	pthread_mutex_init(&data.mut_sql, NULL);
	pmut_sql = &data.mut_sql;

	memset(printbuff, 0, SIZE_PRINTBUFF);
	sprintf(printbuff, "%s application start", timestring);
	do_print(&data, printbuff, RED);


	memset(&statbuf, 0, sizeof(statbuf));
	stat(init_path, &statbuf);
	modes = statbuf.st_mode;
	if (S_ISREG(modes)){

		memset(db_host, 0, SIZE_DB_ARG);
		parse_init(init_path, db_host, "DATABASE_HOST");
		memset(printbuff, 0, SIZE_PRINTBUFF);
		if (strlen(db_host) < 1) {
			memset(db_host, 0, SIZE_DB_ARG);
			sprintf(db_host, "127.0.0.1");
			sprintf(printbuff, "config file entry 'database_host' not defined. default to '%s'.", db_host);
		} else	sprintf(printbuff, "database host: %s", db_host);
		do_print(&data, printbuff, CYAN);

		memset(db_user, 0, SIZE_DB_ARG);
		parse_init(init_path, db_user, "DATABASE_USER");
		memset(printbuff, 0, SIZE_PRINTBUFF);
		if (strlen(db_user) < 1) {
			memset(db_user, 0, SIZE_DB_ARG);
			sprintf(db_user, "controller");
			sprintf(printbuff, "config file entry 'database_user' not defined. default to '%s'.", db_user);
		} else	sprintf(printbuff, "database user: %s", db_user);	
		do_print(&data, printbuff, CYAN);

		memset(db_name, 0, SIZE_DB_ARG);
		parse_init(init_path, db_name, "DATABASE_NAME");
		memset(printbuff, 0, SIZE_PRINTBUFF);
		if (strlen(db_name) < 1) {
			memset(db_name, 0, SIZE_DB_ARG);
			sprintf(db_name, "arduino_mqtt");
			sprintf(printbuff, "config file entry 'database_name' not defined. default to '%s'.", db_name);
		} else	sprintf(printbuff, "database name: %s", db_name);
		do_print(&data, printbuff, CYAN);

		memset(mqtt_user, 0, SIZE_DB_ARG);
		parse_init(init_path, mqtt_user, "MQTT_USER");
		memset(printbuff, 0, SIZE_PRINTBUFF);
		if (strlen(mqtt_user) < 1) {
			memset(mqtt_user, 0, SIZE_DB_ARG);
			sprintf(mqtt_user, "admin");
			sprintf(printbuff, "config file entry 'mqtt_user' not defined. default to '%s'.", mqtt_user);
		} else	sprintf(printbuff, "mqtt user: %s", mqtt_user);
		do_print(&data, printbuff, CYAN);

		memset(mqtt_password, 0, SIZE_DB_ARG);
		parse_init(init_path, mqtt_password, "MQTT_PASSWORD");
		memset(printbuff, 0, SIZE_PRINTBUFF);
		if (strlen(mqtt_password) < 1) {
			memset(mqtt_password, 0, SIZE_DB_ARG);
			sprintf(mqtt_password, "admin");
			sprintf(printbuff, "config file entry 'mqtt_password' not defined. default to '%s'.", mqtt_password);
		} else	sprintf(printbuff, "mqtt password: %s", mqtt_password);
		do_print(&data, printbuff, CYAN);

		memset(mqtt_subscribe_topic, 0, SIZE_DB_ARG);
		parse_init(init_path, mqtt_subscribe_topic, "MQTT_SUBSCRIBE_TOPIC");
		memset(printbuff, 0, SIZE_PRINTBUFF);
		if (strlen(mqtt_subscribe_topic) < 1) {
			memset(mqtt_subscribe_topic, 0, SIZE_DB_ARG);
			sprintf(mqtt_subscribe_topic, "arduino/+/out/#");
			sprintf(printbuff, "config file entry 'mqtt_subscribe_topic' not defined. default to '%s'.", mqtt_subscribe_topic);
		} else	sprintf(printbuff, "mqtt subscribe topic: %s", mqtt_subscribe_topic);
		do_print(&data, printbuff, CYAN);

		memset(mqtt_host, 0, SIZE_DB_ARG);
		parse_init(init_path, mqtt_host, "MQTT_HOST");
		memset(printbuff, 0, SIZE_PRINTBUFF);
		if (strlen(mqtt_host) < 1) {
			memset(mqtt_host, 0, SIZE_DB_ARG);
			sprintf(mqtt_host, "127.0.0.1");
			sprintf(printbuff, "config file entry 'mqtt_host' not defined. default to '%s'.", mqtt_host);
		} else	sprintf(printbuff, "mqtt host: %s", mqtt_host);
		do_print(&data, printbuff, CYAN);

		memset(mqtt_port, 0, SIZE_DB_ARG);
		parse_init(init_path, mqtt_port, "MQTT_PORT");
		memset(printbuff, 0, SIZE_PRINTBUFF);
		if (strlen(mqtt_port) < 1) {
			memset(mqtt_port, 0, SIZE_DB_ARG);
			sprintf(mqtt_port, "1883");
			sprintf(printbuff, "config file entry 'mqtt_port' not defined. default to '%s'.", mqtt_port);
		} else	sprintf(printbuff, "mqtt port: %s", mqtt_port);
		do_print(&data, printbuff, CYAN);
	} else {
		data.code = 2;
		memset(printbuff, 0, SIZE_PRINTBUFF);
		sprintf(printbuff, "config file not readable. exiting with error code %i.", data.code);
		do_print(&data, printbuff, CYAN);
		curses_shutdown(&data, 3);
		exit(data.code);
	}

	memset(tbuff, 0, sizeof(tbuff));
	sprintf(tbuff, "host=%s user=%s dbname=%s", db_host, db_user, db_name);
	data.conn = PQconnectdb(tbuff);
	memset(printbuff, 0, SIZE_PRINTBUFF);
	if (PQstatus(data.conn) != CONNECTION_OK) {
		data.code = 4;
		sprintf(printbuff, "connection to database failed: %s. exiting with error code %i", PQerrorMessage(data.conn), data.code);
		do_print(&data, printbuff, RED);
		PQfinish(data.conn);
		curses_shutdown(&data, 3);
		exit(data.code);
	} else {
		sprintf(printbuff, "database connection established: %s, fd: %i", tbuff, PQsocket(data.conn));
		do_print(&data, printbuff, RED);
	}

        res1 = PQexec(data.conn, "insert into log (description) values ('application start')");
        PQclear(res1);

	//daemonize application
	if (daemonize){
		if ((pid = fork()) < 0)
			return(-1);
		else if (pid != 0)
			exit(0);
		setsid();
		chdir("/");
		umask(0);
	}

	pid = getpid();
	iopl(3);
	setpriority(PRIO_PROCESS, pid, nice);
	//set up signal handler for Ctrl-C & broken pipe (socket failure)
	sa.sa_handler = handler;
	//sigfillset(&sa.sa_mask);
	sigemptyset(&sa.sa_mask);
	sigaddset(&sa.sa_mask, SIGINT);
	sigaddset(&sa.sa_mask, SIGPIPE);
	sigaddset(&sa.sa_mask, SIGCHLD);
	sa.sa_flags = 0;
	sigaction(SIGINT, &sa, &sa_old);
	sigaction(SIGPIPE, &sa, &sa_old);

	uid = getuid();
	if (uid == 0)
		sprintf(pid_path, "/var/run/%s.pid", data.app_name);
	else	sprintf(pid_path, "/var/run/user/%i/%s.pid", uid, data.app_name);
	sprintf(tmp_path, "/tmp/%i", pid);
	unlink(tmp_path);
	unlink(pid_path);
	fd = fopen(tmp_path, "w");
	fprintf(fd, "%s\n", app_name);
	fclose(fd);

	fd = fopen(pid_path, "w");
	fprintf(fd, "main: %i\n", pid);
	fclose(fd);

        mosquitto_lib_init();
        
        mosq = mosquitto_new(NULL, true, &data);
        data.mosq = mosq;
        memset(printbuff, 0, SIZE_PRINTBUFF);
        if (!mosq) {
        	data.code = 8;
        	sprintf(printbuff, "cannot initialize mosquitto library. exiting with error code %i.", data.code);
		do_print(&data, printbuff, BLUE);
		curses_shutdown(&data, 3);
		exit(data.code);
	} else {
		sprintf(printbuff, "mqtt library intialized.");
		do_print(&data, printbuff, BLUE);
	}

	mosquitto_username_pw_set (mosq, mqtt_user, mqtt_password);
        memset(printbuff, 0, SIZE_PRINTBUFF);
	if (mosquitto_connect(mosq, mqtt_host, atoi(mqtt_port), 5)) {
		data.code = 8;
        	sprintf(printbuff, "cannot connect to mqtt broker at host %s:%s with user/password: %s/%s. exiting with error code %i.", mqtt_host, mqtt_port, mqtt_user, mqtt_password, data.code);
		do_print(&data, printbuff, BLUE);
		curses_shutdown(&data, 3);
		exit(data.code);
        } else {
		sprintf(printbuff, "connected to mqtt broker at host %s:%s with user/password: %s/%s.", mqtt_host, mqtt_port, mqtt_user, mqtt_password);
		do_print(&data, printbuff, BLUE);
	}	

        memset(printbuff, 0, SIZE_PRINTBUFF);
	if (mosquitto_subscribe(mosq, NULL, mqtt_subscribe_topic, 0)) {	
		data.code = 8;
        	sprintf(printbuff, "cannot subscribe to mqtt topic: %s. exiting with error code %i.", mqtt_subscribe_topic, data.code);
        	do_print(&data, printbuff, BLUE);
        	curses_shutdown(&data, 3);
		exit(data.code);
	} else {
		sprintf(printbuff, "subscribed to mqtt topic: %s.", mqtt_subscribe_topic);
		do_print(&data, printbuff, BLUE);
	}	
		
	mosquitto_message_callback_set (mosq, message_callback);

	sleep(1);
	memset(tbuff, 0, sizeof(tbuff));
	sprintf(tbuff, "update unit set online = 'f';");
	pthread_mutex_lock(pmut_sql);
	res1 = PQexec(data.conn, tbuff);
	pthread_mutex_unlock(pmut_sql);
	PQclear(res1);
	memset(tbuff, 0, sizeof(tbuff));
	sprintf(tbuff, "select address from unit order by address");
	pthread_mutex_lock(pmut_sql);
	res1 = PQexec(data.conn, tbuff);
	pthread_mutex_unlock(pmut_sql);
	for (int i = 0; i < PQntuples(res1); i++) {
		memset(topic, 0, sizeof(topic));
		sprintf(topic, "arduino/%s/in/register", PQgetvalue(res1, i, 0));
		mosquitto_publish(mosq, NULL, topic, strlen("register"), "register", 0, false);
		timeout.tv_sec = (long) 0;
		timeout.tv_usec = (long) 250000;
		select(0, (fd_set *) 0, (fd_set *) 0, (fd_set *) 0, &timeout);

	}
	PQclear(res1);


	pthread_create(&loop, NULL, (void *) t_loop, &data);
	pthread_create(&process_monitor, NULL, (void *) t_process_monitor, &data);
	if (data.verbose)
		pthread_create(&keyboard_handler, NULL, (void *) t_keyboard_handler, &data);

	mosquitto_loop_start(mosq);


	pthread_mutex_lock(pmut_sql);
	res1 = PQexec(data.conn, "LISTEN req_dio_arduino_mqtt");
	if (PQresultStatus(res1) != PGRES_COMMAND_OK) {
		memset(printbuff, 0, SIZE_PRINTBUFF);
		sprintf(printbuff, "LISTEN command failed: %s", PQerrorMessage(data.conn));
		do_print(&data, printbuff, RED);
	}
	PQclear(res1);
	pthread_mutex_unlock(pmut_sql);
	socksql = PQsocket(data.conn);

	while (data.quit == FALSE){
				
		FD_ZERO(&fd_sql);
		FD_SET(socksql, &fd_sql);
		if (select(socksql + 1, &fd_sql, NULL, NULL, NULL) < 0) {
			memset(printbuff, 0, SIZE_PRINTBUFF);
			sprintf(printbuff, "database select failure: %s.  exiting.", strerror(errno));
			do_print(&data, printbuff, RED);
			PQfinish(data.conn);
			exit(1);
		}
		pthread_mutex_lock(pmut_sql);
		PQconsumeInput(data.conn);
		pthread_mutex_unlock(pmut_sql);
		
		
		
		memset(unit, 0, sizeof(unit));
		memset(request, 0, sizeof(request));
		memset(dio, 0, sizeof(dio));
		while (((notify = PQnotifies(data.conn)) != NULL) && (data.quit == FALSE)) {
			memset(printbuff, 0, SIZE_PRINTBUFF);
			sprintf(printbuff, "ASYNC NOTIFY of '%s' received from backend PID %d: %s", notify->relname, notify->be_pid, notify->extra);
			do_print(&data, printbuff, RED);

			if (strlen(notify->extra) < 1)
				continue;
			
			unit[0] = notify->extra[0];
			unit[1] = notify->extra[1];

			
			dio[0] = notify->extra[3];
			dio[1] = notify->extra[4];
			//dio = atoi(tbuff);
			
			if ((notify->extra[6] == 't') || (notify->extra[6] == 'T'))
				request[0] = 'f'; 
			else	request[0] = 't';

			PQfreemem(notify);

			memset(tbuff, 0, sizeof(tbuff));
			sprintf(tbuff, "select d%s from status_dio where unit = '%s';", dio, unit);
			pthread_mutex_lock(pmut_sql);
			res1 = PQexec(data.conn, tbuff);
			pthread_mutex_unlock(pmut_sql);


			memset(printbuff, 0, SIZE_PRINTBUFF);
			sprintf(printbuff, "%s REQUEST d%s %s, CURRENTLY %s", unit, dio, request, PQgetvalue(res1, 0, 0));
			do_print(&data, printbuff, RED);
			PQclear(res1);
			
				
			memset(tbuff, 0, sizeof(tbuff));
			sprintf(tbuff, "select address from unit where id = '%s'", unit);
			pthread_mutex_lock(pmut_sql);
			res1 = PQexec(data.conn, tbuff);
			pthread_mutex_unlock(pmut_sql);
						
			memset(topic, 0, sizeof(topic));
			sprintf(topic, "arduino/%s/in/set", PQgetvalue(res1, 0, 0));
			PQclear(res1);
			
			memset(pub, 0, sizeof(pub));
			sprintf(pub, "%s:%c", dio, request[0]);
			mosquitto_publish(mosq, NULL, topic, strlen(pub), pub, 0, false);

		}
		//mosquitto_loop_forever(mosq, 250, 1);		

		//timeout.tv_sec = (long) 0;
		//timeout.tv_usec = (long) 250000;
		//select(0, (fd_set *) 0, (fd_set *) 0, (fd_set *) 0, &timeout);
	
	}
	mosquitto_disconnect(mosq);
	mosquitto_loop_stop(mosq, false);

	mosquitto_destroy(mosq);
	mosquitto_lib_cleanup();

	pthread_join(process_monitor, NULL);
	pthread_join(loop, NULL);
	if (data.verbose)
		pthread_join(keyboard_handler, NULL);

        res1 = PQexec(data.conn, "insert into log (description) values ('application exit')");
        PQclear(res1);

	PQfinish(data.conn);

	memset(printbuff, 0, SIZE_PRINTBUFF);
	sprintf(printbuff, "exiting normally with code %i.", data.code);
	do_print(&data, printbuff, BLACK);
	curses_shutdown(&data, 1);
	exit(data.code);

}
	
