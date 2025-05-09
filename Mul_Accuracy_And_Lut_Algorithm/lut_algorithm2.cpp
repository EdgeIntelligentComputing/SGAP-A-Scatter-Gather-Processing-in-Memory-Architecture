#include<stdio.h>
#include<stdlib.h>

#define SIZE 40
#define MAX 200
#define POWER2 4.1178     
#define POWER3 10.511     
//#define POWER2 1.077
//#define POWER3 2.194
#define MAXPOWER 99999999

//5-16 bits

//combination
#define MAXIN 40
int a[MAXIN]={0};
int counts=0;

int xy[MAX][MAX];
int st[MAX][MAX];
int z=0;

//result
int power;
int result[MAX][MAX+2];

int min_a,min_b;
int ab[MAX][2];

//combination case
void comb(int n, int m)
{
	//printf("%d %d \n",n,m);
    if (m<=0)
    {
        for (int j=1;j<=counts;j++){
        	//0:2-bit    1:3-bit
        	st[z][a[j]-1]=1;
        	//printf("%d %d %d\n",z,a[j]-1,st[z][a[j]-1]);
		}        
		z++;
        //printf("\n");
        return;
    }
    for (int i=n;i>=m;i--)
    {
        a[m]=i;
        comb(i-1,m-1);
    }
    return;
}

int min_2(int a,int b){
	if(a<=b){
		return a;
	}else{
		return b;
	}
}

int max_2(int a,int b){
	if(a<b){
		return b;
	}else{
		return a;
	}
}

double f_matrix(int a1,int n,int n_3,int m){
	int matrix[MAX][MAX];
	int weight[MAX];
	
	//printf "0 1 1 1 1"
//	for(int i=0;i<n;i++){
//		printf("%3d ",st[a1][i]);
//	}
//	printf("\n");
	
	for(int i=1;i<n;i++){
		weight[i]=0;
		//printf("%3d ",weight[i]);
	}
	
	weight[0]=0;
	//printf("%3d ",weight[0]);
	for(int i=1;i<n;i++){
		weight[i]=weight[i-1]+2+st[a1][i-1];
		//printf("%3d",weight[i]);
	}
	//printf("\n\n");
	
	int tag=-1;
	for(int i=0;i<n;i++){
		for(int j=0;j<n;j++){
			matrix[i][j]=weight[i]+weight[j];
			
			//get the highest bit weight
			if(st[a1][i]||st[a1][j]){
			    matrix[i][j]+=5;
			}else{
				matrix[i][j]+=3;
			}
			
			//get "k"
			if((i==0||(i!=0&&j==n-1))&&tag==-1){
				if(matrix[i][j]>=m){
					tag=i+j-1;
				}
			}
		}
	}
	
	int a=0,b=0;
	int tag2=tag/2;
	//C 
	for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
        	if(matrix[i][j]>=m){
        		if(st[a1][i]==1||st[a1][j]==1){
            		b++;
				}else{
					a++;
				}
			}
		}
	}
	
	//algorithm
//    for(int i=tag2;i<min_2(tag2+3,n);i++){
//        for(int j=max_2(tag-i,0);j<min_2(i+1,tag+3-i);j++){
//            if(matrix[i][j]>=m){
//            	if(st[a1][i]==1||st[a1][j]==1){
//            		if(i==j){
//            			b++;
//					}else{
//						b+=2;
//					}
//				}else{
//					if(i==j){
//						a++;
//					}else{
//						a+=2;
//					}
//				}
//			}
//		}
//	}
	//printf("1tag:%3d a:%3d b:%3d %3d\n\n",tag,a,b,m);
//	for(int i=(tag+3)/2;i<n;i++){
//		for(int j=max_2(tag+3-i,0);j<=i;j++){
//			if(st[a1][i]==1||st[a1][j]==1){
//            	if(i==j){
//            		b++;
//				}else{
//					b+=2;
//				}
//			}else{
//				if(i==j){
//					a++;
//				}else{
//					a+=2;
//				}
//			}
//		}
//	}
	
	//print matrix (weights)
//	for(int i=0;i<n;i++){
//		for(int j=0;j<n;j++){
//			printf("%3d ",matrix[i][j]);
//		}
//		printf("\n");
//	}
	
	//printf("tag:%3d a:%3d b:%3d %3d\n\n",tag,a,b,m);
	ab[a1][0]=a;
	ab[a1][1]=b;
	//printf("a:%3d b:%3d %3d\n\n",a,b,m);
	
	return POWER2*a+POWER3*b;
}

int main(){
	int n=16;
	//the length of array xy
	int xy_length=0;
	//the length of combination case
	int com_length=0;
	
	//find all (x,y)
	for(int i=0;i<=n/2;i++){
		int a=n-2*i;
		if(a%3==0){
			xy[xy_length][0]=i;
			xy[xy_length][1]=a/3;
			xy_length++;
		}
	}
	
	//print array xy 
	printf("i  x  y\n");
	for(int i=0;i<xy_length;i++){
		printf("%d %2d %2d \n",i,xy[i][0],xy[i][1]);
	}
	printf("\n");
    
    //array st initialization
    for(int j=0;j<MAX;j++){
        for(int q;q<MAX;q++){
        	st[j][q]=0;
		}
	}
    
    //all combination case
    int j=0;
    double power_c,power_nc;
    double min_power=MAXPOWER;
    
    int m;
    for(m=15;m<=19;m++){
    min_power=9999999;
    
    	
    for(int i=0;i<xy_length;i++){

        if(xy[i][0]!=0 && xy[i][1]!=0){
        	counts=xy[i][1];
        	comb(xy[i][0]+xy[i][1], xy[i][1]);
        	//printf("%d %2d %2d %2d\n",i,xy[i][0],xy[i][1],counts);
        	//printf("z:%d\n",z);
        	
        	int min_j;
        	//printf("x+y:%3d y:%3d\n",xy[i][0]+xy[i][1], xy[i][1]);
        	for(j;j<z;j++){
        		power_c=f_matrix(j,xy[i][0]+xy[i][1],xy[i][1],m);
        		//printf("power_c:%lf %d %d\n",power_c,xy[i][0],xy[i][1]);
        		if(power_c<min_power){
        			result[m][0]=xy[i][0];
        			result[m][1]=xy[i][1];
        			for(int q=0;q<xy[i][0]+xy[i][1];q++){
        				result[m][q+2]=st[j][q];
					}
					min_j=j;
					min_power=power_c;
				}
        		//print st[j]
//        	    for(int q=0;q<xy[i][0]+xy[i][1];q++){
//        		    printf("%3d ",st[j][q]);
//			    }
//			    printf("\n");
		    }
		    printf("power_c: a:%2d b:%2d %lf\n",ab[min_j][0],ab[min_j][1],min_power);
		    //printf("\n");
		    
		}else{
			int a=0,b=0;
			for(int l=0;l<xy[i][0]+xy[i][1];l++){
                for(int j=0;j<xy[i][0]+xy[i][1];j++){
                	if(xy[i][0]==0){
                		if((l*3+j*3+5)>=m){
                			b++;
						}
					}else{
						if((l*2+j*2+3)>=m){
							a++;
						}
					}
			    }
			}

			power_nc=POWER2*a + POWER3*b;
			printf("power_nc: %2d %2d %lf %2d %2d\n",a,b,power_nc,xy[i][0],xy[i][1]);
			if(power_nc<min_power){
        		result[m][0]=xy[i][0];
        		result[m][1]=xy[i][1];
        		for(int q=0;q<xy[i][0]+xy[i][1];q++){
        			if(xy[i][0]==0){
        				result[m][q+2]=1;
					}else{
						result[m][q+2]=0;
					}
        			
			    }
			    min_power=power_nc;
			    //printf("%lf %2d %2d\n",min_power,xy[m][0],xy[m][0]);
			}
		}
        
	}
    
    printf("n:%d m:%d\n",n,m);
	for(int i=0;i<result[m][0]+result[m][1]+2;i++){
		printf("%2d ",result[m][i]);
	}
	printf("\n");
	int q=0;
	printf("%2d ",q);
	for(int i=2;i<result[m][0]+result[m][1]+1;i++){
		if(result[m][i]==0){
			q+=2;
			printf("%2d ",q);
		}else{
			q+=3;
			printf("%2d ",q);
		}
	}
	printf("\n");
	
	printf("min_power: %lf\n\n",min_power);
	
	}
}


    	//find combination by min(x,y)
//    	if(xy[i][0]>=xy[i][1]){
//    		comb(xy[i][0]+xy[i][1], xy[i][1]);
//		}else{
//			comb(xy[i][0]+xy[i][1], xy[i][0]);
//		}