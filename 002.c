#include <stdio.h>

int main() {
    int a = 1;
    int b = 2;
    int last;
    int sum = 0;

    while (b < 4000000) {
        if (b % 2 == 0)
            sum += b;
        
        last = a;
        a = b;
        b = last + a;
    }
        
    printf("%d\n", sum);

    return 0;
}
