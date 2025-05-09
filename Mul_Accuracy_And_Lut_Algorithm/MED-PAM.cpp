#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define BITWIDTH 10
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
		//printf("1: %lf\n",sum);
		//printf("1: x1:%d y1:%d %lf\n",x1,y1,sum);
		
//		int x2=(int)floor(x*4)%2;
//		int y2=(int)floor(y*4)%2;
//		if(x2==1){
//			sum=sum+(y-(int)(y*4)/4.0)/4.0;
//		}
//		if(y2==1){
//			sum=sum+(x-(int)(x*4)/4.0)/4.0;
//		}
//		//printf("2: %lf\n",sum);
//		printf("2: x2:%d y2:%d %lf\n",x2,y2,sum);
		
//		int x3=(int)floor(x*8)%2;
//		int y3=(int)floor(y*8)%2;
//		if(x3==1){
//			sum=sum+(y-(int)(y*8)/8.0)/8.0;
//		}
//		if(y3==1){
//			sum=sum+(x-(int)(x*8)/8.0)/8.0;
//		}
//		//printf("3: %lf\n",sum);
//		printf("3: x3:%d y3:%d %lf\n",x3,y3,sum);
//		
//		int x4=(int)floor(x*16)%2;
//		int y4=(int)floor(y*16)%2;
//		if(x4==1){
//			sum=sum+(y-(int)(y*16)/16.0)/16.0;
//		}
//		if(y4==1){
//			sum=sum+(x-(int)(x*16)/16.0)/16.0;
//		}
		//printf("4: %lf\n",sum);
//		printf("4: x4:%d y4:%d %lf\n",x4,y4,sum);
		

//	}
	med+=sum;
	
//	int eqres=abs(ed*num);
//	double exact=(double)(c/num)/num;
///  /20   /40   /80   /160
	double res=abs(med-z)/160;
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

	
	
//exact computing
//	for(int i=0;i<num;i++){
//		for(int j=0;j<num;j++){
//			ex_precision = exact_mul(i,j);
//			ex_sum+=ex_precision;
//			//printf("%lf\n",ex_sum);
//			//printf("%d %d %lf\n",i,j,ex_precision);
//		}
//	}
//	printf("%lf\n",ex_sum/num/num);
}





//		int x0=x,y0=y;
//		double x0_mid=x0+0.5,y0_mid=y0+0.5;
//		double o1;
//		if(a6==1 && b6==1){
//			o1=x0_mid*y0_mid-(x0_mid+0.25)*(y0_mid+0.25);
//		}else if(a6==1 && b6==0){
//			o1=x0_mid*y0_mid-(x0_mid+0.25)*(y0_mid-0.25);
//		}else if(a6==0 && b6==1){
//			o1=x0_mid*y0_mid-(x0_mid-0.25)*(y0_mid+0.25);
//		}else if(a6==0 && b6==0){
//			o1=x0_mid*y0_mid-(x0_mid-0.25)*(y0_mid-0.25);
//		}
//		
//		int x1=x*2,y1=y*2;
//		double x1_mid=(double)x1/2+0.25,y1_mid=(double)y1/2+0.25;
//		double o2;
//		if(a5==1 && b5==1){
//			o2=x1_mid*y1_mid-(x1_mid+0.125)*(y1_mid+0.125);
//		}else if(a5==1 && b5==0){
//			o2=x1_mid*y1_mid-(x1_mid+0.125)*(y1_mid-0.125);
//		}else if(a5==0 && b5==1){
//			o2=x1_mid*y1_mid-(x1_mid-0.125)*(y1_mid+0.125);
//		}else if(a5==0 && b5==0){
//			o2=x1_mid*y1_mid-(x1_mid-0.125)*(y1_mid-0.125);
//		}
		
//		sum=sum+o1+o1;
//		sum=sum/num/num/2/2;   //  2 n+1