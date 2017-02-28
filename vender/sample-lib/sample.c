#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

#include "sample.h"

static void *async_add_thread(void *p) {
	int *arg = (int *) p;
	sleep(1);
	arg[0] += arg[1];
	return NULL;
}

static void *async_task_thread(void *p) {
	void (*callback)(void) = (void (*)(void)) p;
	sleep(1);
	callback();
	return NULL;
}

int add(int x, int y) {
	return x + y;
}

void asyncAdd(int x, int y, void (*callback)(int)) {
	int arg[2] = { x, y };
	pthread_t pthread;

	pthread_create(&pthread, NULL, async_add_thread, arg);
	pthread_join(pthread, NULL);
	callback(arg[0]);
}

void asyncTask(void (*callback)(void)) {
	pthread_t pthread;

	pthread_create(&pthread, NULL, async_task_thread, callback);
	pthread_join(pthread, NULL);
}

