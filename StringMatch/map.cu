#ifndef __MAP_CU__
#define __MAP_CU__

#include "MarsInc.h"
#include "global.h"

__device__ void MAP_COUNT_FUNC//(void *key, void *val, size_t keySize, size_t valSize)
{
	SM_KEY_T* pKey = (SM_KEY_T*)key;
	SM_VAL_T* pVal = (SM_VAL_T*)val;

	int bufOffset = pVal->linebuf_offset;
	int bufSize = pVal->linebuf_size;
	char* buf = pKey->ptrFile + bufOffset;

	char* keyword =  pKey->ptrKeyword;
	int keywordSize = pVal->keyword_size;

	int cur = 0;
	char* p = buf;
	char* start = buf;

	while(1)
	{
		for (; *p != '\n'; ++p, ++cur);
		++p;
		int wordSize = (int)(p - start);

		if (cur >= bufSize) break;
		char* k = keyword;
		char* s = start;
		if (wordSize == keywordSize) 
		{
			for (; *s == *k && *k != '\0'; s++, k++);
			if (*s == '\n') EMIT_INTER_COUNT_FUNC(sizeof(int), sizeof(int));
		}

		start = p;
		bufOffset += wordSize;
	}
}

__device__ void MAP_FUNC//(void *key, void val, size_t keySize, size_t valSize)
{
	SM_KEY_T* pKey = (SM_KEY_T*)key;
	SM_VAL_T* pVal = (SM_VAL_T*)val;

	int bufOffset = pVal->linebuf_offset;
	int bufSize = pVal->linebuf_size;
	char* buf = pKey->ptrFile + bufOffset;

	char* keyword =  pKey->ptrKeyword;
	int keywordSize = pVal->keyword_size;

	int cur = 0;
	char* p = buf;
	char* start = buf;

	while(1)
	{
		for (; *p != '\n'; ++p, ++cur);
		++p;
		int wordSize = (int)(p - start);
		int wordOffset = bufOffset;

		if (cur >= bufSize) break;

		char* k = keyword;
		char* s = start;

		if (wordSize == keywordSize) 
		{
			for (; *s == *k && *k != '\0'; s++, k++);
			if (*s == '\n') 
			{
				int* o_offset = (int*)GET_OUTPUT_BUF(0);
				int* o_size = (int*)GET_OUTPUT_BUF(sizeof(int));
				*o_offset = wordOffset;
				*o_size = wordSize;
				EMIT_INTERMEDIATE_FUNC(o_offset, o_size, sizeof(int), sizeof(int));
			}
		}

		start = p;
		bufOffset += wordSize;
	}
}
#endif //__MAP_CU__
