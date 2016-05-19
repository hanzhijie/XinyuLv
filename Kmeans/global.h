

#ifndef __GLOBAL_H__
#define __GLOBAL_H__

typedef struct
{
	int point_id;
	int dim;
	int K;
	int* ptrClusterId;
} KM_KEY_T;

typedef struct
{
	int* ptrPoints;
	int* ptrClusters;
	int* ptrChange;
} KM_VAL_T;


#endif
