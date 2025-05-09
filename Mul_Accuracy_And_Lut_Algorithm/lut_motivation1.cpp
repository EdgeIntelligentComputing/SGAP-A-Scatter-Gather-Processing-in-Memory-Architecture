#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define BITWIDTH 9
#define MAXSIZE 13

#define POWER2 4.1178     
#define POWER3 10.511  

int k;
int p2=0,p3=0;

//结果是6位的，返回值为结果与12位结果之比
double exact_mul(int a,int b){
	int c,num,exact_c;
	double precision;
	if(a==0||b==0){
		return 0;
	}
	c=a*b;
	num=pow(2,BITWIDTH);
	exact_c=c/num * num;
	precision=(double)exact_c/c;
	return precision;
}

double app_mul(int a,int b,int m){
	int a_divide[5],b_divide[5];
	int weight[5];
	
	if(a==0||b==0){
		return 0;
	}
	p2=0;
	p3=0;
	//divide
	for(int i=0;i<5;i++){
		a_divide[i]=0;
		b_divide[i]=0;
		weight[i]=0;
	}

				if(BITWIDTH==9){
					k=3;
					a_divide[2]=a%8;
				    a_divide[1]=a/8%8 *8;
				    a_divide[0]=a/64 *64;
					b_divide[2]=b%8;
				    b_divide[1]=b/8%8 *8;
				    b_divide[0]=b/64 *64;
				    weight[0]=6;
		            weight[1]=3;
		            weight[2]=0;
					
//					k=4;
//					
//					a_divide[3]=a%4;
//					a_divide[2]=a/4%4 *4;
//				    a_divide[1]=a/16%4 *16;
//				    a_divide[0]=a/64 *64;
//				    b_divide[3]=b%4;
//					b_divide[2]=b/4%4 *4;
//				    b_divide[1]=b/16%4 *16;
//				    b_divide[0]=b/64 *64;
//				    weight[0]=6;
//		            weight[1]=4;
//		            weight[2]=2;
//		            weight[3]=0;
					
//					a_divide[3]=a%4;
//					a_divide[2]=a/4%4 *4;
//				    a_divide[1]=a/16%8 *16;
//				    a_divide[0]=a/128 *128;
//				    b_divide[3]=b%4;
//					b_divide[2]=b/4%4 *4;
//				    b_divide[1]=b/16%8 *16;
//				    b_divide[0]=b/128 *128;
//				    weight[0]=7;
//		            weight[1]=4;
//		            weight[2]=2;
//		            weight[3]=0;
					
//7 5 2 0
//					a_divide[3]=a%4;
//					a_divide[2]=a/4%8 *4;
//				    a_divide[1]=a/32%4 *32;
//				    a_divide[0]=a/128 *128;
//				    b_divide[3]=b%4;
//					b_divide[2]=b/4%8 *4;
//				    b_divide[1]=b/32%4 *32;
//				    b_divide[0]=b/128 *128;
//				    weight[0]=7;
//		            weight[1]=5;
//		            weight[2]=2;
//		            weight[3]=0;
		            
//7 5 3 0
//					a_divide[3]=a%8;
//					a_divide[2]=a/8%4 *8;
//				    a_divide[1]=a/32%4 *32;
//				    a_divide[0]=a/128 *128;
//				    b_divide[3]=b%8;
//					b_divide[2]=b/8%4 *8;
//				    b_divide[1]=b/32%4 *32;
//				    b_divide[0]=b/128 *128;
//				    weight[0]=7;
//		            weight[1]=5;
//		            weight[2]=3;
//		            weight[3]=0;
		            //printf("%d %d a:%d %d %d %d %d b:%d %d %d %d\n",a,b,a_divide[0],a_divide[1],a_divide[2],a_divide[3],a_divide[4],b_divide[0],b_divide[1],b_divide[2],b_divide[3]);
				}

	//filter  computation
	int sum=0;
	for(int i=0;i<k;i++){
		for(int j=0;j<k;j++){

						if(BITWIDTH==9){
							if((weight[i]+weight[j])>(m-6)){
				                    sum+=a_divide[i]*b_divide[j];
				                    p3++;
		  	                    }
//							if(weight[i]==6||weight[j]==6){
//				                if((weight[i]+weight[j])>(m-6)){
//				                    sum+=a_divide[i]*b_divide[j];
//				                    p3++;
//		  	                    }
//			                }else{
//			                	if((weight[i]+weight[j])>(m-4)){
//				                    sum+=a_divide[i]*b_divide[j];
//				                    p2++;
//		  	                    }
//							}
						}
		}
	}
	int c=a*b;
	double ed;
	int num=pow(2,BITWIDTH);
	
	//precision
	//precision=(double)(sum/num*num)/c;
	
	//MED
	ed=abs((double)(sum/num*num)-c);
	
	//MRED
	//ed=abs((double)(sum/num*num)-c)/(double)c;
	
	//if(m<=3)
	//printf("%2d %2d %2d %d %d %d %lf\n",a,b,m,sum,sum/num*num,c,ed);
	return ed/num/num;
}

int main(){
	int num=pow(2,BITWIDTH);
	double ex_precision,ex_sum=0;
	double app_precision,app_sum=0;
	double avg;
	double power=0;
	
//approximate computing
//    int m;
//    for(m=0;m<MAXSIZE;m++){
//    	app_sum[m]=0;
//    	avg[m]=0;
//	}
    	for(int i=0;i<num;i++){
		    for(int j=0;j<num;j++){
			    app_precision = app_mul(i,j,9);
			    app_sum+=app_precision;
			    power+=(p2*POWER2+p3*POWER3);
		    }
	    }
	    avg=app_sum/num/num;
	    //printf("%d ",m);
	    printf("%lf %d %d %lf\n",avg,p2,p3,power/num/num);

}