#include <stdint.h>
#include <string.h>
#include <stdio.h>


#include "sha-256.h"
int main() 
{
	uint8_t output[32];
	char hash_output[128];
	char expected_output[] = "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb";
	char input[] = "a";
	int index = 0;
	calc_sha_256(output,input,strlen(input));
	for (int i=0; i< 32; i++)
	{
		index += sprintf(&hash_output[index], "%02x", output[i]);
	}
//	for (int j=0; j< 32; j++) {
//		printf("%02x",output[j]);
//	}
//	printf("\n");
	int expected_len = strlen(expected_output);
	for (int idx =0; idx < expected_len; idx++)
	{
		if (hash_output[idx] != expected_output[idx])
		{
			printf("Error, expected %s \n HW returned %s\n",expected_output2,hash_output);
			return 1;
		}
	}
	printf("HW returned %s\n",hash_output);
	return 0;
}
