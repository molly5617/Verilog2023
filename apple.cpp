#include <stdio.h>
int main()
{
    int num;
    scanf("%d", &num);
    while (num--)
    {
        /* code */ int a, b;
        int now = 1;
        int sum = 0;
        scanf("%d", &a);
        scanf("%d", &b);
        if (a % 2 == 0)
            a++;
        if (b % 2 == 0)
            b--;
        sum = (a + b) * ((b - a + 2) / 2) / 2;
        printf("Case %d: %d", now, sum);
        now++;
    }
}