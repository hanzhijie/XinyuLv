

#ifndef __REDUCE_CU__
#define __REDUCE_CU__

#include "MarsInc.h"
#include "global.h"

//-------------------------------------------------------------------------
//No Reduce in this application
//-------------------------------------------------------------------------
__device__ void REDUCE_COUNT_FUNC//(void* key, void* vals, size_t keySize, size_t valCount)
{
	EMIT_COUNT_FUNC(sizeof(KM_KEY_T), sizeof(KM_VAL_T));
}

__device__ void REDUCE_FUNC//(void* key, void* vals, size_t keySize, size_t valCount)
{
	KM_KEY_T* pKey = (KM_KEY_T*)key;
	KM_VAL_T* pFirstVal = (KM_VAL_T*)vals;
	int dim = pKey->dim;
	int firstPtId = pKey->point_id;
	int cluster_id = pKey->ptrClusterId[firstPtId];
	int* clusters = (int*)pFirstVal->ptrClusters + cluster_id * dim;
	int* points = (int*)pFirstVal->ptrPoints;

	for (int i = 0; i < dim; i++)
		clusters[i] = 0;

	for (int i = 0; i < valCount; i++)
	{
		KM_KEY_T* iKey = (KM_KEY_T*)GET_KEY_FUNC(key, i);
		int* pt = points + iKey->point_id * dim;	
		for (int j = 0; j < dim; j++)
			clusters[j] += pt[j];	
	}

	for (int i = 0; i < dim; i++)
		clusters[i] /= (int)valCount;

	//EMIT_FUNC(key, vals, sizeof(KM_KEY_T), sizeof(KM_VAL_T));
}
#endif //__REDUCE_CU__
