#include <stdio.h>
#include <stdlib.h>

#include "sample.h"

static void asyncAddCallback(int a) {
	printf("asyncAdd: a = %d\n", a);
}

static void asyncTaskCallback() {
	printf("asyncTask: callback!\n");
}

int main(int argc, char *argv[]) {
	int a = add(1, 2);
	printf("add: a = %d\n", a);
	asyncAdd(3, 4, asyncAddCallback);
	asyncTask(asyncTaskCallback);

	return EXIT_SUCCESS;
}

