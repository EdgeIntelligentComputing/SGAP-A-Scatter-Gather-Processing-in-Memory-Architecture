#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define BITWIDTH 8
#define MAXSIZE 13

int k;

//结果是6位的，返回值为结果与12位结果之比
double exact_mul(int a,int b){
	int c,num,exact_c;
	double precision;
	if(a==0||b==0){
		return 1;
	}
	c=a*b;
	num=pow(2,BITWIDTH);
	exact_c=c/num * num;
	precision=(double)exact_c/c;
	return precision;
}

double app_mul(double x,double y){
	
	double z=x*y;
	double med;
	int num=pow(2,BITWIDTH);
	
	printf("%lf %lf\n",x,y);
	
	//MED
	int n=1;
	double cn=0.5+1.0/(pow(2,2*n+2));
	med=1.5*(x-1)+1.5*(y-1)+cn;
	
	double sum;
	//get the highest bit   n=1
	//if(BITWIDTH==7){
		sum=0;
		
		int x1=floor(x*2)-2;
		int y1=floor(y*2)-2;
		if(x1==1){
			sum=sum+(y-(int)(y*2)/2.0)/2.0;
		}
		if(y1==1){
			sum=sum+(x-(int)(x*2)/2.0)/2.0;
		}
	//}
	med+=sum;
	
//	int eqres=abs(ed*num);
//	double exact=(double)(c/num)/num;
///  *2   -   /2   /2
	double res=abs(med-z)/z;
	printf("%lf %lf %lf\n",med,z,res);
	
	//printf("%2d %2d %2d %d %d %d %lf\n",a,b,m,sum,sum/num*num,c,ed);
	return res;
}

int main(){
	int num=pow(2,BITWIDTH);
	double ex_precision,ex_sum=0;
	double app_precision=0,app_sum=0;
	double avg=0;
	
//	double a = app_mul(1.609375,1.453125);
//	printf("%lf\n",a);
	
//PAM
    	for(int i=0;i<num;i++){
		    for(int j=0;j<num;j++){
			    app_precision = app_mul((double)(num+i)/num,(double)(num+j)/num);
			    app_sum+=app_precision;
			    //printf("%d %d m:%d %lf %lf\n",i,j,m,app_sum[m],app_precision[m]);
		    }
	    }
	    avg=app_sum/num/num;
    printf("%lf %lf\n",app_sum,avg);

	
	
}
