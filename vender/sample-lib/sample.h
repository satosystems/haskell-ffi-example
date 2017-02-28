int add(int x, int y);
void asyncAdd(int x, int y, void (*callback)(int));
void asyncTask(void (*callback)(void));

