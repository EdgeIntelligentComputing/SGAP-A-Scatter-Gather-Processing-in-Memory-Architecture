//四种优化后的ASCM
//w
#include <stdlib.h>
#include <malloc.h>
#include <stdint.h>
#include "cuda_runtime.h"
#include "curand.h"
#include "cublas_v2.h"
#include "stdint.h"
#include "math_functions.h"

extern "C" {
#include "gemm.h"
#include "cuda.h"
}  


 //#define __DEBUG  //通过定义DEBUG来决定要不要输出中间结果

#ifdef __DEBUG
#define DEBUG(format, ...) printf(format, ##__VA_ARGS__)
#else
#define DEBUG(format, ...)
#endif

// typedef uint8_t elemtype;

// #define SIZE 256              // 输入的量化值的位数
// #define bit_w 8
            //量化值实际需要用来表示的位数

__device__ int scale;
 __device__ int b_bit1;
// __device__ int WeightNumerator;           //weight分子
// __device__ int ActivationNumerator;        //act分子
// __device__ int weightPartition;
// __device__ int activationPartition;
// __device__ int addPartition;                //大行+大列

__device__ int StochasticComputing_6(double weight,double activation, int bit_w, int bit_w2){
	int Numerator1, Numerator2;
	int size = powf(2, bit_w);
  int size1 = powf(2, bit_w2);
	int part_w = bit_w / 2;
	int bn1_h, bn1_l, bn2_h, bn2_l; 
	int H1, H2;
	
	double b1, b2;
	int I1, I2, I3, I4;  //相与结果和取反相与结果
	int R, R2;  //每部分的结果  
	int partition1, partition2; //用来记录边界
	
	//将小数去掉小数点，转换成bit_w位整数，数值大小代表了SN中“1”的个数 
	Numerator1 = (int)round(weight * size);
	Numerator2 = (int)round(activation * size1);
	// printf("%d %d %d\t%d\n", size, size1, Numerator1, Numerator2);
	// printf("%f\t%d\n", activation, Numerator2);

	
		//始终让 Numerator1是硬连线， Numerator2是集中分布 
		//*****************9.23修改**************
	  if((Numerator1 <= Numerator2) && bit_w == bit_w2){
		 	  int temp = Numerator1;
		    Numerator1 = Numerator2;
		    Numerator2 = temp;
		}
		//printf("%d %d \n", Numerator1, Numerator2);
		//分别获取两个数的四个部分 

    if(bit_w == 6){
			bn1_h = (Numerator1 & 0x38) >> (part_w);
			bn1_l = (Numerator1 & 0x07);
			bn2_h = (Numerator2 & 0x38) >> (part_w);
			bn2_l = (Numerator2 & 0x07);
		}
    if(bit_w == 3){
			bn1_h = (Numerator1 & 0x4) >> (bit_w-part_w);
			bn1_l = (Numerator1 & 0x3);
			bn2_h = (Numerator2 & 0x6) >> (part_w);
			bn2_l = (Numerator2 & 0x1);
		}

		
		H1 = bn1_h;
		H2 = bn2_h;
		
     
    if(bit_w == 6){
    
      if (bn1_h >= 0 && bn1_h < 1){
				I1 = 0;
			}else if (bn1_h >= 1 && bn1_h <2){
				I1 = bn2_l / 4;
			}else if (bn1_h >= 2 && bn1_h < 3){
				I1 = bn2_l / 4;
			}else if (bn1_h >= 3 && bn1_h < 4){
				I1 = bn2_l / 2;
			}else if (bn1_h >= 4 && bn1_h < 5){
				I1 = bn2_l / 2;
			}else if (bn1_h >= 5 && bn1_h < 6){
				I1 = bn2_l * 0.75;
			}else if (bn1_h >= 6 && bn1_h < 7){
				I1 = bn2_l * 0.75;
			}else{
				I1 = bn2_l;
			}
      
      if (bn1_l >= 0 && bn1_l < 1){
				I2 = 0;
			}else if (bn1_l >= 1 && bn1_l < 2){
				I2 = bn2_h / 4;
			}else if (bn1_l >= 2 && bn1_l < 3){
				I2 = bn2_h / 4;
			}else if (bn1_l >= 3 && bn1_l < 4){
				I2 = bn2_h / 2;
			}else if (bn1_l >= 4 && bn1_l < 5){
				I2 = bn2_h / 2;
			}else if (bn1_l >= 5 && bn1_l < 6){
				I2 = bn2_h *0.75;
			}else if (bn1_l >= 6 && bn1_l < 7){
				I2 = bn2_h * 0.75;
			}else{
				I2 = bn2_h;
			}	
    	
    }
    
    if(bit_w == 3){
    
       if (bn1_h == 1){
          I1 = bn2_l;
       }else{
          I1 = 0;
       }
       
       if (bn1_l > 2)   //修改后w
			 {
				 I2 = bn2_h;
			 }else{
         if(bn1_l == 0){
            I2 = 0;
         }else{
            I2 = bn2_h / 2;
         }
			 }	
    }
    

    
		//printf("%d %d %d %d    %d %d %d \n", bn1_h,bn1_l,bn2_h,bn2_l,part_w,I1,I2);
    //printf("%d %d %d \n",part_w,I1,I2);
		
		R = I1 + I2;
		
    //printf("%d %d H:%d %d\n",part_w,bit_w-part_w,H1,H2);
    //printf("%d %d H:%d %d\n",bit_w,bit_w2,H1,H2);
		//2位的操作就直接给个逻辑 
		if(part_w > 2 || (bit_w2-part_w) > 2){
			b1 = (double)H1 / (double)powf(2, part_w);
			b2 = (double)H2 / (double)powf(2, bit_w2-part_w);
      R2 = StochasticComputing_6(b1, b2, part_w, bit_w2-part_w);
      
			//printf("%d %d \n", part_w, bit_w-part_w);

			//迭代的结果需要扩展！！！！！
			R2 = R2 << part_w;
      //printf("part_w:%d %d %d \n",part_w, R, R2);
      //
			R = R + R2;
		}	
		
		return R;	
}



__device__ int StochasticComputing_7(double weight,double activation, int bit_w, int bit_w2){
	int Numerator1, Numerator2;
	int size = powf(2, bit_w);
  int size1 = powf(2, bit_w2);
	int part_w = bit_w / 2;
	int bn1_h, bn1_l, bn2_h, bn2_l; 
	int H1, H2;
	
	double b1, b2;
	int I1, I2, I3, I4;  //相与结果和取反相与结果
	int R, R2;  //每部分的结果  
	int partition1, partition2; //用来记录边界
	
	//将小数去掉小数点，转换成bit_w位整数，数值大小代表了SN中“1”的个数 
	Numerator1 = (int)round(weight * size);
	Numerator2 = (int)round(activation * size1);
	// printf("%d %d %d\t%d\n", size, size1, Numerator1, Numerator2);
	// printf("%f\t%d\n", activation, Numerator2);

	
		//始终让 Numerator1是硬连线， Numerator2是集中分布 
		//*****************9.23修改**************
	  if((Numerator1 <= Numerator2) && bit_w == bit_w2){
		 	  int temp = Numerator1;
		    Numerator1 = Numerator2;
		    Numerator2 = temp;
		}
		//printf("%d %d \n", Numerator1, Numerator2);
   
		//分别获取两个数的四个部分 
    
    if(bit_w == 7){
			bn1_h = (Numerator1 & 0x70) >> (bit_w-part_w);
			bn1_l = (Numerator1 & 0x0F);
			bn2_h = (Numerator2 & 0x78) >> (part_w);
			bn2_l = (Numerator2 & 0x07);
		}
   
    if(bit_w == 3){
			bn1_h = (Numerator1 & 0x4) >> (bit_w-part_w);
			bn1_l = (Numerator1 & 0x3);
			bn2_h = (Numerator2 & 0xC) >> (bit_w-part_w);
			bn2_l = (Numerator2 & 0x3);
      //printf("%d %d afdfa: %d %d %d %d\n", Numerator1,Numerator2,bn1_h,bn1_l,bn2_h,bn2_l);
    }

		H1 = bn1_h;
		H2 = bn2_h;
    
    if(bit_w == 7){
    
      if (bn1_h >= 0 && bn1_h < 1){
				I1 = 0;
			}else if (bn1_h >= 1 && bn1_h <2){
				I1 = bn2_l / 4;
			}else if (bn1_h >= 2 && bn1_h < 3){
				I1 = bn2_l / 4;
			}else if (bn1_h >= 3 && bn1_h < 4){
				I1 = bn2_l / 2;
			}else if (bn1_h >= 4 && bn1_h < 5){
				I1 = bn2_l / 2;
			}else if (bn1_h >= 5 && bn1_h < 6){
				I1 = bn2_l * 0.75;
			}else if (bn1_h >= 6 && bn1_h < 7){
				I1 = bn2_l * 0.75;
			}else{
				I1 = bn2_l;
			}
      
      if (bn1_l >= 0 && bn1_l < 2){
				I2 = 0;
			}else if (bn1_l >= 2 && bn1_l < 4){
				I2 = bn2_h / 4;
			}else if (bn1_l >= 4 && bn1_l < 6){
				I2 = bn2_h / 4;
			}else if (bn1_l >= 6 && bn1_l < 8){
				I2 = bn2_h / 2;
			}else if (bn1_l >= 8 && bn1_l < 10){
				I2 = bn2_h / 2;
			}else if (bn1_l >= 10 && bn1_l < 12){
				I2 = bn2_h *0.75;
			}else if (bn1_l >= 12 && bn1_l < 14){
				I2 = bn2_h * 0.75;
			}else{
				I2 = bn2_h;
			}	
    
    }	
    
    if(bit_w == 3){
    
       if (bn1_h == 1){
          I1 = bn2_l;
       }else{
          I1 = 0;
       }
       
       if (bn1_l > 2)   //修改后w
			 {
				 I2 = bn2_h;
			 }else{
         if(bn1_l == 0){
            I2 = 0;
         }else{
            I2 = bn2_h / 2;
         }
			 }	
    }
    
		//printf("%d %d %d %d    %d %d %d \n", bn1_h,bn1_l,bn2_h,bn2_l,part_w,I1,I2);
    //printf("%d %d %d \n",part_w,I1,I2);
		
		R = I1 + I2;
		
    //printf("%d %d H:%d %d\n",part_w,bit_w-part_w,H1,H2);
    //printf("%d %d H:%d %d\n",bit_w,bit_w2,H1,H2);
		//2位的操作就直接给个逻辑 
		if(part_w > 2){
			b1 = (double)H1 / (double)powf(2, part_w);
			b2 = (double)H2 / (double)powf(2, bit_w2-part_w);
      R2 = StochasticComputing_7(b1, b2, part_w, bit_w2-part_w);
      //R2=1;
			//printf("%d %d \n", part_w, bit_w-part_w);

			//迭代的结果需要扩展！！！！！
			R2 = R2 << part_w;
      //printf("part_w:%d %d %d \n",part_w, R, R2);
      //
			R = R + R2;
		}	
		
		return R;	
}

__device__ int StochasticComputing_8(double weight,double activation, int bit_w, int bit_w2){
	int Numerator1, Numerator2;
	int size = powf(2, bit_w);
  int size1 = powf(2, bit_w2);
	int part_w = bit_w / 2;
	int bn1_h, bn1_l, bn2_h, bn2_l; 
	int H1, H2;
	
	double b1, b2;
	int I1, I2, I3, I4;  //相与结果和取反相与结果
	int R, R2;  //每部分的结果  
	int partition1, partition2; //用来记录边界
	
	//将小数去掉小数点，转换成bit_w位整数，数值大小代表了SN中“1”的个数 
	Numerator1 = (int)round(weight * size);
	Numerator2 = (int)round(activation * size1);
	// printf("%d %d %d\t%d\n", size, size1, Numerator1, Numerator2);
	// printf("%f\t%d\n", activation, Numerator2);

	
		//始终让 Numerator1是硬连线， Numerator2是集中分布 
		//*****************9.23修改**************
	  if((Numerator1 <= Numerator2) && bit_w == bit_w2){
		 	  int temp = Numerator1;
		    Numerator1 = Numerator2;
		    Numerator2 = temp;
		}
		//printf("%d %d \n", Numerator1, Numerator2);
		//分别获取两个数的四个部分 

		if(bit_w == 8){
			bn1_h = (Numerator1 & 0xF0) >> (part_w);
			bn1_l = (Numerator1 & 0x0F);
			bn2_h = (Numerator2 & 0xF0) >> (part_w);
			bn2_l = (Numerator2 & 0x0F);
		}
		if(bit_w == 4){
			bn1_h = (Numerator1 & 0xC) >> (part_w);
			bn1_l = (Numerator1 & 0x3);
			bn2_h = (Numerator2 & 0xC) >> (part_w);
			bn2_l = (Numerator2 & 0x3);
		}

		
		H1 = bn1_h;
		H2 = bn2_h; 

		if(bit_w == 8){
			//*****************9.23修改**************
			// if(bn2_l > bn1_h) {
			// int temp = bn2_l;
			// bn2_l = bn1_h;
			// bn1_h = temp;
			// }
			if (bn1_h >= 0 && bn1_h < 2)
			{
				I1 = 0;
			}else if (bn1_h >= 2 && bn1_h <4){
				I1 = bn2_l / 4;
			}else if (bn1_h >= 4 && bn1_h < 6){
				I1 = bn2_l / 4;
			}else if (bn1_h >= 6 && bn1_h < 8){
				I1 = bn2_l / 2;
			}else if (bn1_h >= 8 && bn1_h < 10){
				I1 = bn2_l / 2;
			}else if (bn1_h >= 10 && bn1_h < 12){
				I1 = bn2_l * 0.75;
			}else if (bn1_h >= 12 && bn1_h < 14){
				I1 = bn2_l * 0.75;
			}else{
				I1 = bn2_l;
			}

			if (bn1_l >= 0 && bn1_l < 2)
			{
				I2 = 0;
			}else if (bn1_l >= 2 && bn1_l < 4){
				I2 = bn2_h / 4;
			}else if (bn1_l >= 4 && bn1_l < 6){
				I2 = bn2_h / 4;
			}else if (bn1_l >= 6 && bn1_l < 8){
				I2 = bn2_h / 2;
			}else if (bn1_l >= 8 && bn1_l < 10){
				I2 = bn2_h / 2;
			}else if (bn1_l >= 10 && bn1_l < 12){
				I2 = bn2_h *0.75;
			}else if (bn1_l >= 12 && bn1_l < 14){
				I2 = bn2_h * 0.75;
			}else{
				I2 = bn2_h;
			}	
		}

		if(bit_w == 4){

			if (bn1_h > 2)    //修改后w
			{
				I1 = bn2_l;
			}else{
        if(bn1_h == 0){
            I1 = 0;
        }else{
            I1 = bn2_l / 2;
        }
			}

			if (bn1_l > 2)   //修改后w
			{
				I2 = bn2_h;
			}else{
        if(bn1_l == 0){
            I2 = 0;
        }else{
            I2 = bn2_h / 2;
        }
			}	
		}

    
		//printf("%d %d %d %d    %d %d %d \n", bn1_h,bn1_l,bn2_h,bn2_l,part_w,I1,I2);
    //printf("%d %d %d \n",part_w,I1,I2);
		
		R = I1 + I2;
		
    //printf("%d %d H:%d %d\n",part_w,bit_w-part_w,H1,H2);
    //printf("%d %d H:%d %d\n",bit_w,bit_w2,H1,H2);
		//2位的操作就直接给个逻辑 
		if(part_w > 2 || (bit_w2-part_w) > 2){
			b1 = (double)H1 / (double)powf(2, part_w);
			b2 = (double)H2 / (double)powf(2, bit_w2-part_w);
      R2 = StochasticComputing_8(b1, b2, part_w, bit_w2-part_w);
      
			//printf("%d %d \n", part_w, bit_w-part_w);

			//迭代的结果需要扩展！！！！！
			R2 = R2 << part_w;
      //printf("part_w:%d %d %d \n",part_w, R, R2);
      //
			R = R + R2;
		}	
		
		return R;	
}

__device__ int StochasticComputing_9(double weight,double activation, int bit_w, int bit_w2){
	int Numerator1, Numerator2;
	int size = powf(2, bit_w);
  int size1 = powf(2, bit_w2);
	int part_w = bit_w / 2;
	int bn1_h, bn1_l, bn2_h, bn2_l; 
	int H1, H2;
	
	double b1, b2;
	int I1, I2, I3, I4;  //相与结果和取反相与结果
	int R, R2;  //每部分的结果  
	int partition1, partition2; //用来记录边界
	
	//将小数去掉小数点，转换成bit_w位整数，数值大小代表了SN中“1”的个数 
	Numerator1 = (int)round(weight * size);
	Numerator2 = (int)round(activation * size1);
	// printf("%d %d %d\t%d\n", size, size1, Numerator1, Numerator2);
	// printf("%f\t%d\n", activation, Numerator2);

	
		//始终让 Numerator1是硬连线， Numerator2是集中分布 
		//*****************9.23修改**************
	  if((Numerator1 <= Numerator2) && bit_w == bit_w2){
		 	  int temp = Numerator1;
		    Numerator1 = Numerator2;
		    Numerator2 = temp;
		}
		//printf("%d %d \n", Numerator1, Numerator2);
		//分别获取两个数的四个部分 
    if(bit_w == 9){
			bn1_h = (Numerator1 & 0x1E0) >> (bit_w-part_w);
			bn1_l = (Numerator1 & 0x01F);
			bn2_h = (Numerator2 & 0x1F0) >> (part_w);
			bn2_l = (Numerator2 & 0x00F);
		}
    if(bit_w == 2){
			bn1_h = (Numerator1 & 0x2) >> (part_w);
			bn1_l = (Numerator1 & 0x1);
			bn2_h = (Numerator2 & 0x6) >> (part_w);
			bn2_l = (Numerator2 & 0x1);
      //printf("%d %d afdfa: %d %d %d %d\n", Numerator1,Numerator2,bn1_h,bn1_l,bn2_h,bn2_l);
		}
    if(bit_w == 4){
			bn1_h = (Numerator1 & 0xC) >> (part_w);
			bn1_l = (Numerator1 & 0x3);
			bn2_h = (Numerator2 & 0x1C) >> (part_w);
			bn2_l = (Numerator2 & 0x3);
      //printf("%d %d %d %d afdfa: %d %d %d %d\n", bit_w, bit_w2, Numerator1,Numerator2,bn1_h,bn1_l,bn2_h,bn2_l);
		}
		
		H1 = bn1_h;
		H2 = bn2_h;
		
   
   if(bit_w == 9){
			
			if (bn1_h >= 0 && bn1_h < 2)
			{
				I1 = 0;
			}else if (bn1_h >= 2 && bn1_h <4){
				I1 = bn2_l / 4;
			}else if (bn1_h >= 4 && bn1_h < 6){
				I1 = bn2_l / 4;
			}else if (bn1_h >= 6 && bn1_h < 8){
				I1 = bn2_l / 2;
			}else if (bn1_h >= 8 && bn1_h < 10){
				I1 = bn2_l / 2;
			}else if (bn1_h >= 10 && bn1_h < 12){
				I1 = bn2_l * 0.75;
			}else if (bn1_h >= 12 && bn1_h < 14){
				I1 = bn2_l * 0.75;
			}else{
				I1 = bn2_l;
			}

			if (bn1_l >= 0 && bn1_l < 2)
			{
				I2 = 0;
			}else if (bn1_l >= 2 && bn1_l < 6){
				I2 = bn2_h / 8;
			}else if (bn1_l >= 6 && bn1_l < 10){
				I2 = bn2_h / 4;
			}else if (bn1_l >= 10 && bn1_l < 14){
				I2 = bn2_h * 0.375;
			}else if (bn1_l >= 14 && bn1_l < 18){
				I2 = bn2_h / 2;
			}else if (bn1_l >= 18 && bn1_l < 22){
				I2 = bn2_h *0.625;
			}else if (bn1_l >= 22 && bn1_l < 26){
				I2 = bn2_h * 0.75;
			}else if (bn1_l >= 26 && bn1_l < 30){
				I2 = bn2_h * 0.875;
			}else{
				I2 = bn2_h;
			}	
		}

		if(bit_w == 4){
			if (bn1_h > 2)    //修改后w
			{
				I1 = bn2_l;
			}else{
        if(bn1_h == 0){
            I1 = 0;
        }else{
            I1 = bn2_l / 2;
        }
			}

			if (bn1_l > 2)   //修改后w
			{
				I2 = bn2_h;
			}else{
        if(bn1_l == 0){
            I2 = 0;
        }else{
            I2 = bn2_h / 2;
        }
			}	
		}
    
    if(bit_w == 2){
    
       if (bn1_h == 1){
          I1 = bn2_l;
       }else{
          I1 = 0;
       }
       
       if (bn1_l == 1)   
			 {
				 I2 = bn2_h;
			 }else{
         I2 = 0;
			 }	
    }
    
		//printf("%d %d %d %d    %d %d %d \n", bn1_h,bn1_l,bn2_h,bn2_l,part_w,I1,I2);
    //printf("%d %d %d \n",part_w,I1,I2);
		
		R = I1 + I2;
		
    //printf("%d %d H:%d %d\n",part_w,bit_w-part_w,H1,H2);
    //printf("%d %d H:%d %d\n",bit_w,bit_w2,H1,H2);
		//2位的操作就直接给个逻辑 
		if(part_w > 2 || (bit_w2-part_w) > 2){
			b1 = (double)H1 / (double)powf(2, part_w);
			b2 = (double)H2 / (double)powf(2, bit_w2-part_w);
      R2 = StochasticComputing_9(b1, b2, part_w, bit_w2-part_w);
      
			//printf("%d %d \n", part_w, bit_w-part_w);

			//迭代的结果需要扩展！！！！！
			R2 = R2 << part_w;
      //printf("part_w:%d %d %d \n",part_w, R, R2);
      //
			R = R + R2;
		}	
		
		return R;	
}

__device__ int StochasticComputing_10(double weight,double activation, int bit_w, int bit_w2){
	int Numerator1, Numerator2;
	int size = powf(2, bit_w);
  int size1 = powf(2, bit_w2);
	int part_w = bit_w / 2;
	int bn1_h, bn1_l, bn2_h, bn2_l; 
	int H1, H2;
	
	double b1, b2;
	int I1, I2, I3, I4;  //相与结果和取反相与结果
	int R, R2;  //每部分的结果  
	int partition1, partition2; //用来记录边界
	
	//将小数去掉小数点，转换成bit_w位整数，数值大小代表了SN中“1”的个数 
	Numerator1 = (int)round(weight * size);
	Numerator2 = (int)round(activation * size1);
	// printf("%d %d %d\t%d\n", size, size1, Numerator1, Numerator2);
	// printf("%f\t%d\n", activation, Numerator2);

	
		//始终让 Numerator1是硬连线， Numerator2是集中分布 
		//*****************9.23修改**************
	  if((Numerator1 <= Numerator2) && bit_w == bit_w2){
		 	  int temp = Numerator1;
		    Numerator1 = Numerator2;
		    Numerator2 = temp;
		}
		//printf("%d %d \n", Numerator1, Numerator2);
		//分别获取两个数的四个部分 
    if(bit_w == 10){
			bn1_h = (Numerator1 & 0x3E0) >> (part_w);
			bn1_l = (Numerator1 & 0x01F);
			bn2_h = (Numerator2 & 0x3E0) >> (part_w);
			bn2_l = (Numerator2 & 0x01F);
		}
    if(bit_w == 2){
			bn1_h = (Numerator1 & 0x2) >> (part_w);
			bn1_l = (Numerator1 & 0x1);
			bn2_h = (Numerator2 & 0x6) >> (part_w);
			bn2_l = (Numerator2 & 0x1);
      //printf("%d %d afdfa: %d %d %d %d\n", Numerator1,Numerator2,bn1_h,bn1_l,bn2_h,bn2_l);
		}
    if(bit_w == 5){
			bn1_h = (Numerator1 & 0x18) >> (bit_w-part_w);
			bn1_l = (Numerator1 & 0x07);
			bn2_h = (Numerator2 & 0x1c) >> (part_w);
			bn2_l = (Numerator2 & 0x03);
		}
		
		H1 = bn1_h;
		H2 = bn2_h;
		
		
   
   if(bit_w == 10){
			
			if (bn1_h >= 0 && bn1_h < 2)
			{
				I1 = 0;
			}else if (bn1_h >= 2 && bn1_h < 6){
				I1 = bn2_l / 8;
			}else if (bn1_h >= 6 && bn1_h < 10){
				I1 = bn2_l / 4;
			}else if (bn1_h >= 10 && bn1_h < 14){
				I1 = bn2_l * 0.375;
			}else if (bn1_h >= 14 && bn1_h < 18){
				I1 = bn2_l / 2;
			}else if (bn1_h >= 18 && bn1_h < 22){
				I1 = bn2_l *0.625;
			}else if (bn1_h >= 22 && bn1_h < 26){
				I1 = bn2_l * 0.75;
			}else if (bn1_h >= 26 && bn1_h < 30){
				I1 = bn2_l * 0.875;
			}else{
				I1 = bn2_l;
			}	

			if (bn1_l >= 0 && bn1_l < 2)
			{
				I2 = 0;
			}else if (bn1_l >= 2 && bn1_l < 6){
				I2 = bn2_h / 8;
			}else if (bn1_l >= 6 && bn1_l < 10){
				I2 = bn2_h / 4;
			}else if (bn1_l >= 10 && bn1_l < 14){
				I2 = bn2_h * 0.375;
			}else if (bn1_l >= 14 && bn1_l < 18){
				I2 = bn2_h / 2;
			}else if (bn1_l >= 18 && bn1_l < 22){
				I2 = bn2_h *0.625;
			}else if (bn1_l >= 22 && bn1_l < 26){
				I2 = bn2_h * 0.75;
			}else if (bn1_l >= 26 && bn1_l < 30){
				I2 = bn2_h * 0.875;
			}else{
				I2 = bn2_h;
			}	
		}
   
    if(bit_w == 5){
		
			if (bn1_h > 2){   
				I1 = bn2_l;
			}else{
        if(bn1_h == 0){
            I1 = 0;
        }else{
            I1 = bn2_l / 2;
        }
			}

			if (bn1_l >= 0 && bn1_l < 1){
				I2 = 0;
			}else if (bn1_l >= 1 && bn1_l < 2){
				I2 = bn2_h / 4;
			}else if (bn1_l >= 2 && bn1_l < 3){
				I2 = bn2_h / 4;
			}else if (bn1_l >= 3 && bn1_l < 4){
				I2 = bn2_h / 2;
			}else if (bn1_l >= 4 && bn1_l < 5){
				I2 = bn2_h / 2;
			}else if (bn1_l >= 5 && bn1_l < 6){
				I2 = bn2_h *0.75;
			}else if (bn1_l >= 6 && bn1_l < 7){
				I2 = bn2_h * 0.75;
			}else{
				I2 = bn2_h;
			}	
		}
    
    if(bit_w == 2){
    
       if (bn1_h == 1){
          I1 = bn2_l;
       }else{
          I1 = 0;
       }
       
       if (bn1_l == 1)   
			 {
				 I2 = bn2_h;
			 }else{
         I2 = 0;
			 }	
    }
    
		//printf("%d %d %d %d    %d %d %d \n", bn1_h,bn1_l,bn2_h,bn2_l,part_w,I1,I2);
    //printf("%d %d %d \n",part_w,I1,I2);
		
		R = I1 + I2;
		
    //printf("%d %d H:%d %d\n",part_w,bit_w-part_w,H1,H2);
    //printf("%d %d H:%d %d\n",bit_w,bit_w2,H1,H2);
		//2位的操作就直接给个逻辑 
		if(part_w > 2 || (bit_w2-part_w) > 2){
			b1 = (double)H1 / (double)powf(2, part_w);
			b2 = (double)H2 / (double)powf(2, bit_w2-part_w);
      R2 = StochasticComputing_10(b1, b2, part_w, bit_w2-part_w);
      
			//printf("%d %d \n", part_w, bit_w-part_w);

			//迭代的结果需要扩展！！！！！
			R2 = R2 << part_w;
      //printf("part_w:%d %d %d \n",part_w, R, R2);
      //
			R = R + R2;
		}	
		
		return R;	
}


//高两位相乘，也就是最内层递归的结果，直接给逻辑
__device__ int operTwo(double weight,double activation){
	
	int size = powf(2, b_bit1);
	int Numerator1 = (int)round(weight * size);
	int Numerator2 = (int)round(activation * size);
	
	int b1_h_2;
	int b2_h_2;  //取两个数的高两位
	int result;  //结果 

  if(Numerator1 <= Numerator2){
     int temp = Numerator1;
     Numerator1 = Numerator2;
     Numerator2 = temp;
	}
   
  if(b_bit1 == 8){
     b1_h_2 = Numerator1 >> (b_bit1 - 2);
     b2_h_2 = Numerator2 >> (b_bit1 - 2);
     result = (b1_h_2 * b2_h_2) << (b_bit1 - 4);
  }else{
     if(b_bit1 == 6 || b_bit1 == 7 || b_bit1 == 9 || b_bit1 == 10){
        b1_h_2 = Numerator1 >> (b_bit1 - 1);
        b2_h_2 = Numerator2 >> (b_bit1 - 2);
        result = (b1_h_2 * b2_h_2) << (b_bit1 - 3);
     }
  }
		
		return result;


} 



__device__ double Computing(double weight,double activation){
	int bit_w = b_bit1;
  //double weight = 0.6328125;
  //double activation = 0.78515625;//0.28515625;   0.78515625

//如果有负数
    double flag=1.0;
    if((weight<0 && activation>0) || (weight>0 && activation<0))
        flag=-1.0;
                
    weight=fabs(weight);
    activation=fabs(activation); 
    
    //缩小为二分之一
    if((weight + activation) > 1){
       weight = weight * 0.5;
       activation = activation * 0.5;
       scale = 1;   //记录是否缩放
    }else{
       scale = 0;
    }
    
    
    
// 如果有0/1这些特殊值，就直接输出了，不算了
    if (activation == 0 || weight == 0)
        {
            return 0;
        }
    if (activation == 1)
        {
            return weight;
        }
    if (weight == 1)
        {
            return activation;
        }

    //加上这个if训练出错，降低学习率0.01 ---> 0.001
    if (activation > 1.0 || weight > 1.0)
    {
    	return activation * weight * flag;
    }

    double result;
    
    if(bit_w == 6){
       result= ((StochasticComputing_6(weight, activation, bit_w, bit_w) + operTwo(weight,activation)) * 1.0) / 64;
    }else if(bit_w == 7){
       result= ((StochasticComputing_7(weight, activation, bit_w, bit_w) + operTwo(weight,activation)) * 1.0) / 128;
    }else if(bit_w == 8){
       result= ((StochasticComputing_8(weight, activation, bit_w, bit_w) + operTwo(weight,activation)) * 1.0) / 256;
    }else if(bit_w == 9){
       result= ((StochasticComputing_9(weight, activation, bit_w, bit_w) + operTwo(weight,activation)) * 1.0) / 512;
    }else if(bit_w == 10){
       result= ((StochasticComputing_10(weight, activation, bit_w, bit_w) + operTwo(weight,activation)) * 1.0) / 1024;
    }
    //result = ((StochasticComputing(weight, activation, bit_w, bit_w) + operTwo(weight,activation, bit_w)) * 1.0) / 256;
    
    if(scale == 1){
       result = result * 4;
    }

    //printf("%lf %lf %d %d %d %lf\n", weight, activation, (int)round(weight * 256), (int)round(activation * 256),bit_w,result);
    //printf("%d %d %lf\n", StochasticComputing_10(weight, activation, bit_w, bit_w), operTwo(weight,activation), result);
    //printf("%d %lf\n", bit_w,result);
    
    return result * flag;

}



 
__global__ void MatrixMul_device(int TA, int TB, float ALPHA, float BETA, float *a, int a_rows, int a_cols, float *b, int b_rows, int b_cols, float *c, int b_bit) {
    int tix = threadIdx.x;

    int bix = blockIdx.x;

    int bdx = blockDim.x;
    
    b_bit1 = b_bit;
 
if(TA ==1 && TB ==0){

    //A的转置
    for (int i = tix; i < b_cols; i += bdx) {
	   float sum = 0;
        for (int k = 0; k < a_cols; k++) {
		sum += Computing(ALPHA * a[bix+a_rows*k],b[b_cols*k+i]);			
		//	sum += normal(ALPHA * a[bix+a_rows*k],b[b_cols*k+i]);
			//sum += ALPHA * a[bix+a_rows*k] * b[b_cols*k+i];
			
			
		//	printf("%lf\t%lf\t%lf\n" ,ALPHA * a[bix+a_rows*k],b[b_cols*k+i],ALPHA * a[bix+a_rows*k]*b[b_cols*k+i]);
	//printf("%lf\n" ,ALPHA * a[bix*a_cols+k] * b[k*b_cols+i]);
		// printf("%lf\t%lf\n" ,ALPHA * a[bix*a_cols+k], b[k*b_cols+i]);
        }
        c[bix*b_cols+i] = sum;   
     //   printf("-----------------------%lf----------------------\n\n\n",sum);

      
    } 
    
    } 
    
if(TA == 0 && TB == 1){
    //B的转置
     for (int i = tix; i < b_cols; i += bdx) {
        float sum = 0;
        float aaaaa;
        for (int k = 0; k < a_cols; k++) {
         sum += Computing(ALPHA * a[bix*a_cols+k], b[b_rows*i+k]);
         //sum += ALPHA * a[bix*a_cols+k] * b[b_rows*i+k];
         //printf("%d\n",b_bit1);
         //printf("%lf\t%lf--->%lf\t%lf\n", b[b_rows*i+k], ALPHA * a[bix*a_cols+k], b[b_rows*i+k] * ALPHA * a[bix*a_cols+k], aaaaa);
		//	sum += normal(ALPHA * a[bix*a_cols+k], b[b_rows*i+k]);
		    //sum += ALPHA * a[bix*a_cols+k] * b[b_rows*i+k];
		
	//	printf("%lf\t%lf\t%lf\n" ,ALPHA * a[bix*a_cols+k] , b[b_rows*i+k],ALPHA * a[bix*a_cols+k] * b[b_rows*i+k]);
		
		// printf("%lf\t%lf\n" ,ALPHA * a[bix*a_cols+k], b[k*b_cols+i]);
        }
         c[bix* b_cols+i] = sum;
    //   printf("---------------------%lf-------------------\n\n",sum);
    }
    
    }  
    
 if(TA == 0 && TB == 0){
    //不转置
    for (int i = tix; i < b_cols; i += bdx) {
      float sum = 0;
        for (int k = 0; k < a_cols; k++) {
			sum += Computing(ALPHA * a[bix*a_cols+k] , b[k*b_cols+i]);
      //sum += 5;
	//		sum += normal(ALPHA * a[bix*a_cols+k] , b[k*b_cols+i]);
	//		sum += ALPHA * a[bix*a_cols+k] * b[k*b_cols+i];
	
				// printf("%lf\t%lf\t%lf\n" ,ALPHA * a[bix*a_cols+k] , b[k*b_cols+i],ALPHA * a[bix*a_cols+k] * b[k*b_cols+i]);
	//printf("*************");
	//printf("%lf\n" ,ALPHA * a[bix*a_cols+k] * b[k*b_cols+i]);
			// printf("%lf\t%lf\n" ,ALPHA * a[bix*a_cols+k], b[k*b_cols+i]);
        }
        c[bix*b_cols+i] = sum;   
           // printf("--------------------%lf-------------------\n\n\n",sum);
    }
    
    }
    
   
}

float matrixMul(int TA, int TB, int M, int N, int K, float ALPHA, 
        float *A_gpu, int lda, 
        float *B_gpu, int ldb,
        float BETA,
        float *C_gpu, int ldc, int b_bit){
/*
if((ALPHA !=1 && BETA!=0) || (ALPHA !=1 && BETA !=1)){
	printf("--------------------------------------------------------------------%lf,%lf\n",ALPHA,BETA);
	}
*/
float *a_device;

float *b_device;

float *result_device;


//srand(0);



cudaMalloc((void**)&a_device,sizeof(float) *M * K);
cudaMalloc((void**)&b_device,sizeof(float) *N * K);
cudaMalloc((void**)&result_device,sizeof(float) *M * N);
cudaMemcpy(a_device,A_gpu,sizeof(float) *M * K,cudaMemcpyHostToDevice);
cudaMemcpy(b_device,B_gpu,sizeof(float) *N * K,cudaMemcpyHostToDevice);

/*
cudaEvent_t start_device, stop_device;
float time_device;
cudaEventCreate(&start_device);
cudaEventCreate(&stop_device);
cudaEventRecord( start_device, 0 );

	
int NN = 1024;
if(NN < 32){
    NN = 32;
}else if(NN<256){
	NN=256;}else if(NN<512){
			NN=512;}else{
					NN=1024;}
*/	
//b_bit=10;
//printf("%d\n",b_bit);   
int NN=N;
if(NN > 1024){
	NN = 1024;
	}				

dim3 gridsize(M,1,1);
dim3 blocksize(NN,1,1);
MatrixMul_device<<<gridsize,blocksize>>>(TA,TB,ALPHA,BETA,a_device,M,K,b_device,K,N,result_device,b_bit);

/*
cudaEventRecord( stop_device, 0 );
cudaEventSynchronize( stop_device );
cudaEventElapsedTime( &time_device, start_device, stop_device );
cudaEventDestroy( start_device );
cudaEventDestroy( stop_device );
*/
//
cudaMemcpy(C_gpu, result_device,sizeof(float) *M * N,cudaMemcpyDeviceToHost);


cudaFree(a_device);
cudaFree(b_device);
cudaFree(result_device);
//clock_t start_host = clock();


    
    return 0;
}
