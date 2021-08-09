/*
 * Copyright (C) 2018 Conrad Rehill (703) 528-3280
 * All rights reserved.
 *
 * This software may be freely copied, modified, and redistributed
 * provided that this copyright notice is preserved on all copies.
 *
 * There is no warranty or other guarantee of fitness of this software
 * for any purpose.  It is provided solely "as is".
 *
*/

/*----------------------------------------------------------------*/
/* arduino.h							  */
/*----------------------------------------------------------------*/

#define UNSET			0x00
#define PORT_LISTENER		49717
#define PORT_HTTP		80
#define MAX_CONNECTIONS		100

#define WHITE			1
#define RED			2
#define	GREEN			3
#define YELLOW			4
#define MAGENTA			5
#define CYAN			6
#define BLUE			7
#define BLACK			8

#define SIZE_PATHBUFF		512
#define SIZE_PRINTBUFF		2048
#define SIZE_DB_ARG		128
#define SIZE_MQTT_ARG		128

typedef	 struct s_data {
	char verbose;
	char curses;
	char print;
	char quit;
	char code;

	char app_path[SIZE_PATHBUFF];
	char app_name[SIZE_PATHBUFF];
	char init_path[SIZE_PATHBUFF];
	char pid_path[SIZE_PATHBUFF];
	char db_name[SIZE_DB_ARG];
	char db_user[SIZE_DB_ARG];
	char db_host[SIZE_DB_ARG];
	char mqtt_host[SIZE_MQTT_ARG];
	char mqtt_user[SIZE_MQTT_ARG];
	char mqtt_password[SIZE_MQTT_ARG];
	char mqtt_subscribe_topic[SIZE_MQTT_ARG];
	char mqtt_port[SIZE_MQTT_ARG];
	
	PGconn *conn;
	
	struct mosquitto *mosq;
	
	pthread_mutex_t mut_sql;
	pthread_mutex_t mut_print;
	
	WINDOW *w_main, *w_banner;
	int winwidth;
	int winheight;
	int winrow_main;
	int wincol_main;

	} s_data_t;

void parse_init(char *, char *, char *);
void t_process_monitor(s_data_t *);
void t_loop(s_data_t *);
void handler(int);
void do_print(s_data_t *, char *, int);
void curses_shutdown(s_data_t *, int);
void message_callback (struct mosquitto *, void *, const struct mosquitto_message *);

void t_keyboard_handler(s_data_t *);
unsigned char kb_getc_w(void);
unsigned char kb_getc(void);
void set_tty_raw(void);
void set_tty_cooked(void);

//int make_connection(int *);
