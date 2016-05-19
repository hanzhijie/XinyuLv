

#ifndef __COMPARE_CU__
#define __COMPARE_CU__
#include "MarsInc.h"
#include "global.h"

//-----------------------------------------------------------
//No Sort in this application
//-----------------------------------------------------------
__device__ int compare(const void *d_a, int len_a, const void *d_b, int len_b)
{
	KM_KEY_T* k1 = (KM_KEY_T*)d_a;
	KM_KEY_T* k2 = (KM_KEY_T*)d_b;

	int k1_id = k1->ptrClusterId[k1->point_id];
	int k2_id = k2->ptrClusterId[k2->point_id];

	if (k1_id > k2_id) return 1;
	if (k1_id < k2_id) return -1;
	return 0;
}

#endif //__COMPARE_CU__
