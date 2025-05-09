#include<stdio.h>
#include<stdlib.h>

#define SIZE 20
#define POWER2 1.077
#define POWER3 2.194

int result[SIZE];
int q[8];
int i=0;

double divide(int n,int m,int a_bit,int a_w,int b_bit,int b_w){
	int a_l,a_h;
	int b_l,b_h;
	
	if(a_bit<=2&&b_bit<=2){
		if((a_w+b_w+4)<(n-m)){
			return 0;
		}else{
			return POWER2;
		}
	}else{
		if(a_bit<=3&&b_bit<=3){
			if((a_w+b_w+6)<(n-m)){
			    return 0;
		    }else{
			    return POWER3;
		    }
		}
	}
	printf("a:%d b:%d\n",a_bit,b_bit);
	if(a_bit>b_bit){
		b_bit=a_bit;
	}else{
		a_bit=b_bit;
	}
	
	if(a_bit%2==0){
		double p[4];
		a_l=a_bit/2;
		a_h=a_l;
		b_l=a_l;
		b_h=b_l;
		
		p[0]=divide(n,m,a_h,a_w+a_l,b_h,b_w+b_l);
		p[1]=divide(n,m,a_h,a_w+a_l,b_l,b_w);
		p[2]=p[1];
		//p[2]=divide(n,m,a_l,a_w,b_h,b_w+b_l);
		p[3]=divide(n,m,a_l,a_w,b_l,b_w);	
		printf("%lf \n",p[0]+p[1]+p[2]+p[3]);

		return (p[0]+p[1]+p[2]+p[3]);
	}else{
		double c0[5],c1[5];
		double p;
		int i1,i2,i3;
		int min;
		a_l=a_bit/2;
		a_h=a_bit-a_l;
		b_l=a_l;
		b_h=a_h;

		c0[0]=divide(n,m,a_l,a_w+a_h,b_l,b_w+b_h);
		c0[1]=divide(n,m,a_l,a_w+a_h,b_h,b_w);
		c0[2]=c0[1];
		//c0[2]=divide(n,m,a_h,a_w,b_l,b_w+b_h);
		c0[3]=divide(n,m,a_h,a_w,b_h,b_w);
		
		c1[0]=divide(n,m,a_h,a_w+a_l,b_h,b_w+b_l);
		c1[1]=divide(n,m,a_h,a_w+a_l,b_l,b_w);
		c1[2]=c1[1];
		//c1[2]=divide(n,m,a_l,a_w,b_h,b_w+b_l);
		c1[3]=divide(n,m,a_l,a_w,b_l,b_w);
		
		c0[4]=c0[0]+c0[1]+c0[2]+c0[3];
		c1[4]=c1[0]+c1[1]+c1[2]+c1[3];
		
		//printf("0:%lf 1:%lf\n",c0[4],c1[4]);
		//5-16
		//long
		if(c0[4]>c1[4]){
			p=c1[4];
			q[i++]=1;
			printf("long: %d\n",i);
			if(n<8 && a_bit==n){
				q[i-2]=q[i-1];
				q[i-1]=0;
			}else{
//				double pp[2];
//				for(int k=0;k<i;k+=2){
//					if(i==k+1){
//						//printf("%d %d\n",i,k);
//						pp[0]=c0[4];
//						pp[1]=c1[4];
//					}
//					printf("q[k]:%d q[k+1]:%d k:%d i:%d\n",q[k],q[k+1],k,i);
//					if(q[k]!=q[k+1] && i==2+k){
//						printf("Not equal\n");
//						if((pp[0]+c0[4])>(pp[1]+c1[4])){
//							q[k]=q[k+1];
//						}else{
//							q[k+1]=q[k];
//						}
//					}
//				}
//				
//				if(i==5){
//					q[1]=q[2];
//					i=2;
//				}
				
				if(n<=16 && a_bit==n && i>=3){
					//printf("long: %d\n",i);
					q[i-3]=q[i-1];
					q[i-4]=q[i-2];
					q[i-1]=0;
					q[i-2]=0;
				}
			}
		}else{
			//short
			p=c0[4];
			q[i++]=0;
			printf("short: %d\n",i);
			if(n<8 && a_bit==n){
				q[i-1]=0;
			}else{
//				double pp[2];
//				for(int k=0;k<i;k+=2){
//					if(i==k+1){
//						//printf("%d %d\n",i,k);
//						pp[0]=c0[4];
//						pp[1]=c1[4];
//					}
//					printf("q[k]:%d q[k+1]:%d k:%d i:%d\n",q[k],q[k+1],k,i);
//					if(q[k]!=q[k+1] && i==2+k){
//						printf("Not equal\n");
//						if((pp[0]+c0[4])>(pp[1]+c1[4])){
//							q[k]=q[k+1];
//						}else{
//							q[k+1]=q[k];
//						}
//					}
//				}
//				
//				if(i==5){
//					q[1]=q[2];
//					i=2;
//				}
				
				if(n<=16 && a_bit==n && i>=3){
					//printf("short: %d\n",i);
					q[i-1]=0;
					q[i-2]=0;
				}
			}
		}
		
		return p;
	}
		
}

int x=0;
int j=0;

int door(int n,int w,int f){
	if(n<=3){
		return 0;
	}
	
	if(n%2==0){
		result[j++]=n/2+w;
		//printf("%d \n",n/2);
		door(n/2,w,f);
		door(n/2,n/2+w,f);
	}else{
		if(q[f]==0){
			result[j++]=n/2+w+1;
			//printf("%d \n",n/2+w+1);
			door(n/2,n/2+1+w,f+1);
			door(n/2+1,w,f+1); 
		}else{
			result[j++]=n/2+w;
			//printf("%d %d %d \n",result[0],j,n/2+w);
			door(n/2+1,n/2+w,f+1);
			door(n/2,w,f+1); 
		}
	}
	return 0;
}		


int main(){
   int n=5,m=0;
   double power;
   
   for(int k=0;k<20;k++){
   	    result[k]=0;
   }
   
   scanf("%d %d",&n,&m);
   power=divide(n,m,n,0,n,0);
   
   printf("Power:%lf\n",power);
   for(int k=0;k<8;k++){
   	    printf("%d ",q[k]);
   }
   printf("\n");

   door(n,0,0);

   for(int k=0;k<20;k++){
   	    printf("%d ",result[k]);
   }
   printf("\n");
}








//#include<stdio.h>
//#include<stdlib.h>
//
//#define SIZE 20
//#define POWER2 1.077
//#define POWER3 2.194
//
//int result[SIZE];
//int q[4];
//int i=0;
//
//double divide(int n,int m,int a_bit,int a_w,int b_bit,int b_w){
//	int a_l,a_h;
//	int b_l,b_h;
//	
//	if(a_bit<=2&&b_bit<=2){
//		if((a_w+b_w+4)<(n-m)){
//			return 0;
//		}else{
//			return POWER2;
//		}
//	}else{
//		if(a_bit<=3&&b_bit<=3){
//			if((a_w+b_w+6)<(n-m)){
//			    return 0;
//		    }else{
//			    return POWER3;
//		    }
//		}
//	}
//	
//	if(a_bit>b_bit){
//		b_bit=a_bit;
//	}else{
//		a_bit=b_bit;
//	}
//	
//	if(a_bit%2==0){
//		double p[4];
//		a_l=a_bit/2;
//		a_h=a_l;
//		b_l=a_l;
//		b_h=b_l;
//		
//		p[0]=divide(n,m,a_h,a_w+a_l,b_h,b_w+b_l);
//		p[1]=divide(n,m,a_h,a_w+a_l,b_l,b_w);
//		p[2]=divide(n,m,a_l,a_w,b_h,b_w+b_l);
//		p[3]=divide(n,m,a_l,a_w,b_l,b_w);	
//
//		return (p[0]+p[1]+p[2]+p[3]);
//	}else{
//		double c0[5],c1[5];
//		double p=0;
//		int i1,i2,i3;
//		int min;
//		a_l=a_bit/2;
//		a_h=a_bit-a_l;
//		b_l=a_l;
//		b_h=a_h;
//
//		c0[0]=divide(n,m,a_l,a_w+a_h,b_l,b_w+b_h);
//		c0[1]=divide(n,m,a_l,a_w+a_h,b_h,b_w);
//		c0[2]=divide(n,m,a_h,a_w,b_l,b_w+b_h);
//		c0[3]=divide(n,m,a_h,a_w,b_h,b_w);
//		
//		c1[0]=divide(n,m,a_h,a_w+a_l,b_h,b_w+b_l);
//		c1[1]=divide(n,m,a_h,a_w+a_l,b_l,b_w);
//		c1[2]=divide(n,m,a_l,a_w,b_h,b_w+b_l);
//		c1[3]=divide(n,m,a_l,a_w,b_l,b_w);
//		
//		c0[4]=c0[0]+c0[1]+c0[2]+c0[3];
//		c1[4]=c1[0]+c1[1]+c1[2]+c1[3];
//		
//		printf("0:%lf 1:%lf\n",c0[4],c1[4]);
//		if(c0[4]>c1[4]){
//			p+=c1[4];
//			q[i++]=1;
//			printf("11111111  %d %d %d\n",a_w,a_l,i);
//		}else{
//			p+=c0[4];
//			q[i++]=0;
//			printf("00000000  %d %d %d\n",a_w,a_h,i);
//		}
//		
//		return p;
//	}
//}
//
//int x=0;
//int j=0;
//
//int door(int n,int w,int f){
//	if(n<=3){
//		return 0;
//	}
//	
//	if(n%2==0){
//		result[j++]=n/2+w;
//		//printf("%d \n",n/2);
//		door(n/2,w,f);
//		door(n/2,n/2+w,f);
//	}else{
//		if(q[f]==0){
//			result[j++]=n/2+w+1;
//			//printf("%d \n",n/2+w+1);
//			door(n/2,n/2+1+w,f+1);
//			door(n/2+1,w,f+1); 
//		}else{
//			result[j++]=n/2+w;
//			//printf("%d %d %d \n",result[0],j,n/2+w);
//			door(n/2+1,n/2+w,f+1);
//			door(n/2,w,f+1); 
//		}
//	}
//	return 0;
//}		
//
//
//int main(){
//   int n=5,m=0;
//   double power;
//   
//   for(int k=0;k<20;k++){
//   	    result[k]=0;
//   }
//   
//   scanf("%d %d",&n,&m);
//   power=divide(n,m,n,0,n,0);
//   
//   printf("Power:%lf\n",power);
//   for(int k=0;k<4;k++){
//   	    printf("%d ",q[k]);
//   }
//   printf("\n");
//
//   door(n,0,0);
//
//   for(int k=0;k<20;k++){
//   	    printf("%d ",result[k]);
//   }
//   printf("\n");
//}




//
//#include<stdio.h>
//#include<stdlib.h>
//
//#define SIZE 20
//#define POWER2 1.077
//#define POWER3 2.194
//
//int result[SIZE];
//int i=0;
//
////int Min(double c1,double c2){
////	double min_num;
////	int tag;
////	
////	if(c1<=c2){
////		min_num=c1;
////		tag=1;
////	}else{
////		min_num=c2;
////		tag=2;
////	}
////	
////	return tag;
////}
//
//double divide(int nm,int a_bit,int a_w,int b_bit,int b_w,int j,int flag){
//	int a_l,a_h;
//	int b_l,b_h;
//	
//	if(a_bit<=2&&b_bit<=2){
//		if((a_w+b_w+4)<nm){
//			return 0;
//		}else{
//			return POWER2;
//		}
//	}else{
//		if(a_bit<=3&&b_bit<=3){
//			if((a_w+b_w+6)<nm){
//			    return 0;
//		    }else{
//			    return POWER3;
//		    }
//		}
//	}
//	
//	if(a_bit>b_bit){
//		b_bit=a_bit;
//	}else{
//		a_bit=b_bit;
//	}
//	
//	if(a_bit%2==0){
//		double p[4];
//		a_l=a_bit/2;
//		a_h=a_l;
//		b_l=a_l;
//		b_h=b_l;
//		if(flag==0){
//			result[i++]=a_w+a_l;
//		}
//		
//		p[0]=divide(nm,a_h,a_w+a_l,b_h,b_w+b_l,i,0);
//		p[1]=divide(nm,a_h,a_w+a_l,b_l,b_w,i,0);
//		p[2]=divide(nm,a_l,a_w,b_h,b_w+b_l,i,0);
//		p[3]=divide(nm,a_l,a_w,b_l,b_w,i,0);	
//		//printf("a_bit:%d a_w:%d a_l:%d j:%d\n",a_bit,a_w,a_l,i);
////		printf("a:%d %d b:%d %d\n",a_h,a_l,b_h,b_l);
////		printf("aw:%d %d bw:%d %d\n",a_bit,a_w,b_bit,b_w);
//		//printf("%lf %lf %lf %lf\n",p[0],p[1],p[2],p[3]);
//		return (p[0]+p[1]+p[2]+p[3]);
//	}else{
//		double c0[5],c1[5];
//		double p=0;
//		int min;
//		a_l=a_bit/2;
//		a_h=a_bit-a_l;
//		b_l=a_l;
//		b_h=a_h;
//		printf("a_bit:%d a_w:%d a_l:%d j:%d\n",a_bit,a_w,a_l,i);
//		c0[0]=divide(nm,a_l,a_w+a_h,b_l,b_w+b_h,i,1);
//		c0[1]=divide(nm,a_l,a_w+a_h,b_h,b_w,i,1);
//		c0[2]=divide(nm,a_h,a_w,b_l,b_w+b_h,i,1);
//		c0[3]=divide(nm,a_h,a_w,b_h,b_w,i,1);
//		
//		c1[0]=divide(nm,a_h,a_w+a_l,b_h,b_w+b_l,i,1);
//		c1[1]=divide(nm,a_h,a_w+a_l,b_l,b_w,i,1);
//		c1[2]=divide(nm,a_l,a_w,b_h,b_w+b_l,i,1);
//		c1[3]=divide(nm,a_l,a_w,b_l,b_w,i,1);
//		
//		c0[4]=c0[0]+c0[1]+c0[2]+c0[3];
//		c1[4]=c1[0]+c1[1]+c1[2]+c1[3];
//		
//		if(c0[4]>c1[4]){
//			p+=c1[4];
//			if(flag==0){
//				result[i++]=a_w+a_l;
//			}
//			
//		}else{
//			p+=c0[4];
//			if(flag==0){
//				result[i++]=a_w+a_h;
//			}
//			
//			//printf("result:%d\n",a_w+a_h);
//		}
//		
//		printf("0:%lf 1:%lf\n",c0[4],c1[4]);
//		return p;
//	}
//}
//
//		
//
//
//int main(){
//   int n,m;
//   int a[SIZE],b[SIZE],final_result[SIZE];
//   double power;
//   
//   scanf("%d %d",&n,&m);
//   power=divide(n-m,n,0,n,0,i,0);
//   
//   printf("Power:%lf\n",power);
//   for(int k=0;k<=20;k++){
//   	    printf("%d ",result[k]);
//   }
//   printf("\n");
//   
//   int k1=0;
//   for(int k=0;k<=20;k++){
//   	    int tag=0;
//   	    for(int z=0;z<k;z++){
//   	    	if(result[k]==result[z]){
//   	    		tag=1;
//			}
//		}
//		if(tag==0){
//			final_result[k1++]=result[k];
//			printf("%d ",result[k]);
//		}   
//   }
//}



//#include<stdio.h>
//#include<stdlib.h>
//
//#define SIZE 20
//#define POWER2 1.077
//#define POWER3 2.194
//
//int result[SIZE];
//int i=0;
//
////int Min(double c1,double c2){
////	double min_num;
////	int tag;
////	
////	if(c1<=c2){
////		min_num=c1;
////		tag=1;
////	}else{
////		min_num=c2;
////		tag=2;
////	}
////	
////	return tag;
////}
//
//double divide(int n,int m,int a_bit,int a_w,int b_bit,int b_w,int j){
//	int a_l,a_h;
//	int b_l,b_h;
//	
//	if(a_bit<=2&&b_bit<=2){
//		if((a_w+b_w+4)<(n-m)){
//			return 0;
//		}else{
//			return POWER2;
//		}
//	}else{
//		if(a_bit<=3&&b_bit<=3){
//			if((a_w+b_w+6)<(n-m)){
//			    return 0;
//		    }else{
//			    return POWER3;
//		    }
//		}
//	}
//	
//	if(a_bit>b_bit){
//		b_bit=a_bit;
//	}else{
//		a_bit=b_bit;
//	}
//	
//	int d[4];
//	
//	if(a_bit%2==0){
//		double p[4];
//		a_l=a_bit/2;
//		a_h=a_l;
//		b_l=a_l;
//		b_h=b_l;
////		if((2*a_bit!=n)&&(4*a_bit!=n))
////		    result[i++]=a_w+a_l;
////		printf("same: i:%d a_w:%d a_l:%d b_w:%d b_l:%d a_bit:%d b_bit:%d \n",i,a_w,a_l,b_w,b_l,a_bit,b_bit);
//		
//		p[0]=divide(n,m,a_h,a_w+a_l,b_h,b_w+b_l,i);
//		p[1]=divide(n,m,a_h,a_w+a_l,b_l,b_w,i);
//		p[2]=divide(n,m,a_l,a_w,b_h,b_w+b_l,i);
//		p[3]=divide(n,m,a_l,a_w,b_l,b_w,i);	
//
//		return (p[0]+p[1]+p[2]+p[3]);
//	}else{
//		double c0[5],c1[5];
//		double p=0;
//		int i1,i2,i3;
//		int min;
//		a_l=a_bit/2;
//		a_h=a_bit-a_l;
//		b_l=a_l;
//		b_h=a_h;
//		//printf("a_bit:%d a_w:%d a_l:%d j:%d\n",a_bit,a_w,a_l,i);
//		printf("i:%d a_w:%d a_l:%d b_w:%d b_l:%d a_bit:%d b_bit:%d \n",i,a_w,a_l,b_w,b_l,a_bit,b_bit);
//
//		c0[0]=divide(n,m,a_l,a_w+a_h,b_l,b_w+b_h,i);
//		c0[1]=divide(n,m,a_l,a_w+a_h,b_h,b_w,i);
//		c0[2]=divide(n,m,a_h,a_w,b_l,b_w+b_h,i);
//		c0[3]=divide(n,m,a_h,a_w,b_h,b_w,i);
//		
//		c1[0]=divide(n,m,a_h,a_w+a_l,b_h,b_w+b_l,i);
//		c1[1]=divide(n,m,a_h,a_w+a_l,b_l,b_w,i);
//		c1[2]=divide(n,m,a_l,a_w,b_h,b_w+b_l,i);
//		c1[3]=divide(n,m,a_l,a_w,b_l,b_w,i);
//		
//		c0[4]=c0[0]+c0[1]+c0[2]+c0[3];
//		c1[4]=c1[0]+c1[1]+c1[2]+c1[3];
//		
//		//printf("i1:%d i2:%d i3:%d %d\n",i1,i2,i3,i);
//		
////		if(a_bit<=n/2<=(a_bit+1)){
////			result[i++]=a_w+a_l;
////			//printf("i:%d a_w:%d a_l:%d\n",i,a_w,a_l);
////		}
//		
//		printf("0:%lf 1:%lf\n",c0[4],c1[4]);
//		if(c0[4]>c1[4]){
//			p+=c1[4];
//			switch(b_bit){
//				case 5:
//					result[i++]=a_w+a_l;
//					break;
//				case 7:
//					result[i++]=a_w+a_l;
//					result[i++]=a_w+5;
//					break;
//				case 9:
//					result[i++]=a_w+a_l;
//					result[i++]=a_w+2;
//					break;
//				case 11:
//					result[i++]=a_w+a_l;
//					result[i++]=a_w+a_l+3;
//					break;
//				case 13:
//					result[i++]=a_w+a_l;
//					result[i++]=a_w+3;
//					break;
//				case 15:
//					result[i++]=a_w+a_l;
//					result[i++]=a_w+a_l+2;
//					result[i++]=a_w+a_l+4;
//					result[i++]=a_w+a_l+6;
//					break;
//			}		
//			printf("11111111  %d %d %d\n",a_w,a_l,i);
//		}else{
//			p+=c0[4];
//			switch(b_bit){
//				case 5:
//					result[i++]=a_w+a_h;
//					break;
//				case 7:
//					result[i++]=a_w+a_h;
//					result[i++]=a_w+2;
//					break;
//				case 9:
//					result[i++]=a_w+a_h;
//					result[i++]=a_w+a_h+2;
//					break;
//				case 11:
//					result[i++]=a_w+a_h;
//					result[i++]=a_w+3;
//					break;	
//				case 13:
//					result[i++]=a_w+a_h;
//					result[i++]=a_w+a_h+3;
//					break;
//				case 15:
//					result[i++]=a_w+a_h;
//					result[i++]=a_w+2;
//					result[i++]=a_w+4;
//					result[i++]=a_w+6;
//					break;
//			}
//			printf("00000000  %d %d %d\n",a_w,a_h,i);
//		}
//		
//		//printf("0:%lf 1:%lf\n",c0[4],c1[4]);
//		return p;
//	}
//}
//
//		
//
//
//int main(){
//   int n,m;
//   int a[SIZE],b[SIZE],final_result[SIZE];
//   double power;
//   
//   scanf("%d %d",&n,&m);
//   power=divide(n,m,n,0,n,0,i);
//   
//   printf("Power:%lf\n",power);
//   for(int k=0;k<=40;k++){
//   	    printf("%d ",result[k]);
//   }
//   printf("\n");
//   
//   int k1=0;
//   for(int k=0;k<=40;k++){
//   	    int tag=0;
//   	    for(int z=0;z<k;z++){
//   	    	if(result[k]==result[z]){
//   	    		tag=1;
//			}
//		}
//		if(tag==0){
//			final_result[k1++]=result[k];
//			printf("%d ",result[k]);
//		}   
//   }
//}