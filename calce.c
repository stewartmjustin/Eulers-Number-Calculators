/*
     Created by: Justin Stewart
     Email: stewartm.justin@outlook.com
*/

#include <stdio.h>
#include <math.h>
#include <string.h>

/*Print e to n significant digits to file*/
void keepe(int n, int *d, FILE *fp) {
	int i;

	fprintf(fp, "%d.", d[0]);
	for(i = 1; i < n; i++) {
		fprintf(fp, "%d", d[i]);
	}
}

/*calculate e to n sigificant digits*/
void ecalculation(int n, FILE *fp) {
	float test;

	/*d[] holds e*/
	int m = 4, i, j, carry, temp, d[n + 1];
	test = (n + 1) * 2.30258509;

	while (((float)m * (log(m) - 1.0) + 0.5 * log(6.2831852 * (float)m)) <= test) {
		m++;
	}

	int coef[m + 1];
	for (j = 2; j <= m; j++) {
		coef[j - 2] = 1;
	}
	d[0] = 2;
	
	for (i = 1; i <= n; i++) {
		carry = 0;
		for (j = m; j >= 2; j--) {
			temp = coef[j - 2] * 10 + carry;
			carry = temp/j;
			coef[j - 2] = temp - carry * j;
		}
		d[i] = carry;
	}

	keepe(n, d, fp);
}

/*prompt the user for n and a file name then call other functions*/
int main() {
	int n;
	FILE *fp;
	char fileName[255];
	printf("Enter the number of significant digits to calculate: ");
	fscanf(stdin, "%d", &n);
	printf("Enter the output location file-name: ");
	fscanf(stdin, "%s", fileName);

	fp = fopen(fileName, "w");
	if (fp == NULL) {
		printf("File failed to open");
		return 0;
	}
	ecalculation(n, fp);
	fclose(fp);
}