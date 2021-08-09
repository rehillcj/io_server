#include <stdio.h>
#include <syslog.h>
#include <unistd.h>

void log_message(char *test){

	int logmask;

	openlog("logmask", LOG_PID|LOG_CONS, LOG_USER);
	syslog(LOG_INFO, "informative message, pid = %d", getpid());
	syslog(LOG_DEBUG, "debug message, should appear");
	logmask = setlogmask(LOG_UPTO(LOG_NOTICE));
	syslog(LOG_DEBUG, "debug message, should not appear");
	closelog();

	printf("log_message done\n");
}
