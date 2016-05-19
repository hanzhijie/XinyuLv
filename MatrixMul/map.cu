
#ifndef __MAP_CU__
#define __MAP_CU__

#include "MarsInc.h"
#include "global.h"

__device__ float operator*(float4 a, float4 b)
{
	return (a.x*b.x+a.y*b.y+a.z*b.z+a.w*b.w);
}

__device__ void MAP_COUNT_FUNC//(void *key, void *val, size_t keySize, size_t valSize)
{			
	EMIT_INTER_COUNT_FUNC(sizeof(float), sizeof(int2));
}

__device__ void MAP_FUNC//(void *key, void val, size_t keySize, size_t valSize)
{
	MM_KEY_T* pKey = ((MM_KEY_T*)key);
	MM_VAL_T* pVal = ((MM_VAL_T*)val);

	int rowId = pVal->row;
	int colId = pVal->col;

	int M_COL_COUNT = pVal->col_dim;

	float4 *matrix1 = (float4*)(pKey->matrix1+rowId*M_COL_COUNT);
	float4 *matrix2 = (float4*)(pKey->matrix2+colId*M_COL_COUNT);

	float newVal = 0.0f;

	int col4 = M_COL_COUNT >> 2;
	int remainder = M_COL_COUNT & 0x00000003;

	for (int i = 0; i < col4; i++)
	{
		float4 v1 = matrix1[i];
		float4 v2 = matrix2[i];

		newVal += v1.x * v2.x;
		newVal += v1.y * v2.y;
		newVal += v1.z * v2.z;
		newVal += v1.w * v2.w;
	}

	float *rMatrix1 = (float*)(matrix1+col4);
	float *rMatrix2 = (float*)(matrix2+col4);

	for (int i = 0; i < remainder; i++)
	{
		float f1 = rMatrix1[i];
		float f2 = rMatrix2[i];
		newVal += (f1 * f2);
	}

	float* o_result = (float*)GET_OUTPUT_BUF(0);
	*o_result = newVal;
	int2* o_pos = (int2*)GET_OUTPUT_BUF(sizeof(float));
	o_pos->x = rowId;
	o_pos->y = colId;
	EMIT_INTERMEDIATE_FUNC(o_result, o_pos, sizeof(float), sizeof(int2));			 
}

#endif //__MAP_CU__
