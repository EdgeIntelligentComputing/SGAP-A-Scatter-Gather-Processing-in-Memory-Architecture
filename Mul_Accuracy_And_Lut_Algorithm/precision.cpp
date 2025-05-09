#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int BITWIDTH;
int MAXSIZE;

#define  random(x)    (rand()%x)

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

double app_mul(int a,int b,int m){
	int a_divide[5],b_divide[5];
	int weight[5];
	
	if(a==0||b==0){
		return 1;
	}
	
	//divide
	for(int i=0;i<5;i++){
		a_divide[i]=0;
		b_divide[i]=0;
		weight[i]=0;
	}
	if(BITWIDTH==6){
		k=2;
		a_divide[1]=a%8;
		a_divide[0]=a-a_divide[1];
		b_divide[1]=b%8;
		b_divide[0]=b-b_divide[1];
		weight[0]=3;
		weight[1]=0;
	}else{
		if(BITWIDTH==7){
			k=3;
			a_divide[2]=a%4;
		    a_divide[1]=a/4%4 *4;
		    a_divide[0]=a/16 *16;
		    b_divide[2]=b%4;
		    b_divide[1]=b/4%4 *4;
		    b_divide[0]=b/16 *16;
		    weight[0]=4;
		    weight[1]=2;
		    weight[2]=0;
		    //printf("%d %d a:%d %d %d b:%d %d %d\n",a,b,a_divide[0],a_divide[1],a_divide[2],b_divide[0],b_divide[1],b_divide[2]);
		}else{
			if(BITWIDTH==8){
				k=4;
				a_divide[3]=a%4;
				a_divide[2]=a/4%4 *4;
				a_divide[1]=a/16%4 *16;
				a_divide[0]=a/64 *64;
				b_divide[3]=b%4;
				b_divide[2]=b/4%4 *4;
				b_divide[1]=b/16%4 *16;
				b_divide[0]=b/64 *64;
				weight[0]=6;
		        weight[1]=4;
		        weight[2]=2;
		        weight[3]=0;
		        //printf("%d %d a:%d %d %d %d b:%d %d %d %d\n",a,b,a_divide[0],a_divide[1],a_divide[2],a_divide[3],b_divide[0],b_divide[1],b_divide[2],b_divide[3]);
			}else{
				if(BITWIDTH==9){
					k=4;
					a_divide[3]=a%8;
					a_divide[2]=a/8%4 *8;
				    a_divide[1]=a/32%4 *32;
				    a_divide[0]=a/128 *128;
				    b_divide[3]=b%8;
					b_divide[2]=b/8%4 *8;
				    b_divide[1]=b/32%4 *32;
				    b_divide[0]=b/128 *128;
				    weight[0]=7;
		            weight[1]=5;
		            weight[2]=3;
		            weight[3]=0;
		            //printf("%d %d a:%d %d %d %d %d b:%d %d %d %d\n",a,b,a_divide[0],a_divide[1],a_divide[2],a_divide[3],a_divide[4],b_divide[0],b_divide[1],b_divide[2],b_divide[3]);
				}else{
						if(BITWIDTH==10){
					k=5;
					a_divide[4]=a%4;
					a_divide[3]=a/4%4*4;
					a_divide[2]=a/16%4 *16;
				    a_divide[1]=a/64%4 *64;
				    a_divide[0]=a/256 *256;
				    b_divide[4]=b%4;
					b_divide[3]=b/4%4*4;
					b_divide[2]=b/16%4 *16;
				    b_divide[1]=b/64%4 *64;
				    b_divide[0]=b/256 *256;
				    weight[0]=8;
		            weight[1]=6;
		            weight[2]=4;
		            weight[3]=2;
		            weight[4]=0;
		            //printf("%d %d a:%d %d %d %d %d b:%d %d %d %d %d\n",a,b,a_divide[0],a_divide[1],a_divide[2],a_divide[3],a_divide[4],b_divide[0],b_divide[1],b_divide[2],b_divide[3],b_divide[4]);
			            }
				}
			}
		}
	}
	//filter  computation
	int sum=0;
	for(int i=0;i<k;i++){
		for(int j=0;j<k;j++){
			if(BITWIDTH==7){
				if(weight[i]==4||weight[j]==4){
				    if((weight[i]+weight[j])>(m-6)){
				        sum+=a_divide[i]*b_divide[j];
				        //printf("%d %d\n",i,j);
		  	        }
			    }else{
				    if((weight[i]+weight[j])>(m-4)){
				        sum+=a_divide[i]*b_divide[j];
				        //printf("%d %d\n",i,j);
			        }
			    }
			}else{
				if(BITWIDTH==6){
					if((weight[i]+weight[j])>(m-6)){
				        sum+=a_divide[i]*b_divide[j];
		  	        }
				}else{
					if(BITWIDTH==8){
						if((weight[i]+weight[j])>(m-4)){
				            sum+=a_divide[i]*b_divide[j];
		  	            }
					}else{
						if(BITWIDTH==9){
							if(weight[i]==0||weight[j]==0){
				                if((weight[i]+weight[j])>(m-6)){
				                    sum+=a_divide[i]*b_divide[j];
				                    //printf("%d %d\n",i,j);
		  	                    }
			                }else{
			                	if((weight[i]+weight[j])>(m-4)){
				                    sum+=a_divide[i]*b_divide[j];
				                    //printf("%d %d\n",i,j);
		  	                    }
							}
						}else{
							if(BITWIDTH==10){
						        if((weight[i]+weight[j])>(m-4)){
				                    sum+=a_divide[i]*b_divide[j];
		  	                    }
					        }
						}
					}
					
				}
			}
			
			
		}
	}
	int c;
	double precision;
	int num=pow(2,BITWIDTH);
	c=a*b;
	precision=(double)(sum/num*num)/c;
	return precision;
}

int main(){
	for(int bw=7;bw<=10;bw++){
		BITWIDTH=bw;
		int num=pow(2,BITWIDTH);
		double ex_precision,ex_sum=0;
		double app_precision[MAXSIZE],app_sum[MAXSIZE];
		double avg[MAXSIZE];
		
	//approximate computing
		int m;
		for(m=0;m<MAXSIZE;m++){
			app_sum[m]=0;
			avg[m]=0;
		}
		for(m=0;m<MAXSIZE;m++){
			for(int i=0;i<num;i++){
				for(int j=0;j<num;j++){
					app_precision[m] = app_mul(i,j,m);
					app_sum[m]+=app_precision[m];
				}
			}
			avg[m]=app_sum[m]/num/num;
			printf("n=%d: %lf\n",BITWIDTH,m,avg[m]);
		}
	}
	
	//printf("%d\n",(952972/64 *64));


	
	
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