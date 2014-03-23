#include <stdio.h>
#include <stdlib.h>

int main(void) {
    system("xbacklight -set 110 -time 4000 -steps 100 &");
    return 0;
}
