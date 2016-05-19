
#ifndef __MAP_CU__
#define __MAP_CU__

#include "MarsInc.h"
#include "global.h"

__device__ void MAP_COUNT_FUNC//(void *key, void *val, size_t keySize, size_t valSize)
{
	EMIT_INTER_COUNT_FUNC(sizeof(KM_KEY_T), sizeof(KM_VAL_T));
}

__device__ void MAP_FUNC//(void *key, void val, size_t keySize, size_t valSize)
{
	KM_KEY_T* pKey = (KM_KEY_T*)key;
	KM_VAL_T* pVal = (KM_VAL_T*)val;

	int dim = pKey->dim;
	int K = pKey->K;
	int ptId = pKey->point_id;
	int clusterId = pKey->ptrClusterId[ptId];

	int* point = (int*)(pVal->ptrPoints + ptId*dim);
	int* cluster = (int*)pVal->ptrClusters; 
	int* change = (int*)pVal->ptrChange;

	int minDist = 0;
	int* originCluster = cluster + clusterId * dim;
	for (int i = 0; i < dim; ++i)
	{
		int pt = point[i];
		int cl = originCluster[i];
		int delta = pt - cl;
		
		minDist += (delta * delta);
	}

	int curClusterId = clusterId;
	for (int i = 0; i < K; ++i)
	{
		int* curCluster = cluster + i*dim;
		int curDist = 0;
		for (int j = 0; j < dim; ++j)
		{
			int pt = point[j];
			int cl = curCluster[j];
			int delta = pt - cl;
			curDist += (delta * delta);
		}
//printf("pt:%d, cluster:%d, minDist:%d, curDist:%d\n", point[0], curCluster[0], minDist, curDist);
		if (minDist > curDist) 
		{
			curClusterId = i;	
			minDist = curDist;
		}
	}
//printf("point:%d, curClusterId:%d, clusterId:%d\n", ptId, curClusterId, clusterId);

	if (curClusterId != clusterId) 
	{
		*change = 1;
		pKey->ptrClusterId[ptId] = curClusterId;
	}

	EMIT_INTERMEDIATE_FUNC(key, val, sizeof(KM_KEY_T), sizeof(KM_VAL_T));
}
#endif //__MAP_CU__
