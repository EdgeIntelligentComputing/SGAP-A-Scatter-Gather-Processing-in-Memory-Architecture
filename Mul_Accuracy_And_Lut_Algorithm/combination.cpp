#include <stdio.h>
#define MAXIN 10
int a[MAXIN]={0};
int counts=0;
void comb(int n, int m)
{
    if (m<=0)
    {
        for (int j=1;j<=counts;j++)
                printf("%d ",a[j]);
            printf("\n");
        return;
    }
    for (int i=n;i>=m;i--)
    {
        a[m]=i;
        comb(i-1,m-1);
    }
}
int main()
{
    int n, m;
    scanf("%d%d", &n, &m);
    counts=m;
    comb(n, m);
    return 0;
}
