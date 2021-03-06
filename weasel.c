#include <stdio.h>
#include <stdlib.h>
#include <string.h>
 
const char target[] = "METHINKS IT IS LIKE A WEASEL";
const char tbl[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
 
#define CHOICE (sizeof(tbl) - 1)
#define MUTATE 15
#define COPIES 50
 
/* retorna um inteiro aleatório de 0 a n - 1 */
int irand(int n)
{
	int r, rand_max = RAND_MAX - (RAND_MAX % n);
	while((r = rand()) >= rand_max);
	return r / (rand_max / n);
}
 
/* número de caracteres diferentes entre a e b */
int unfitness(const char *ancestral, const char *prole)
{
	int i, sum = 0;
	for (i = 0; ancestral[i]; i++)
		sum += (ancestral[i] != prole[i]);
	return sum;
}
 
/* cada caractere de b tem 1 / MUTATE de chance de diferir de a */
void mutate(const char *ancestral, char *prole)
{
	int i;
	for (i = 0; ancestral[i]; i++)
		prole[i] = irand(MUTATE) ? ancestral[i] : tbl[irand(CHOICE)];
 
	prole[i] = '\0';
}
 
int main (int argc, char** argv)

{
	int i, best_i, unfit, best, iters = 0;
	char specimen[COPIES][sizeof(target) / sizeof(char)];
 
	/* sorteando a string inicial */
	for (i = 0; target[i]; i++)
		specimen[0][i] = tbl[irand(CHOICE)];
	specimen[0][i] = 0;
 
	do {
		for (i = 1; i < COPIES; i++)
			mutate(specimen[0], specimen[i]);
 
		/* encontrando a string mais parecida com o alvo(target) */
		for (best_i = i = 0; i < COPIES; i++) {
			unfit = unfitness(target, specimen[i]);
			if(unfit < best || !i) {
				best = unfit;
				best_i = i;
			}
		}
 
		if (best_i) strcpy(specimen[0], specimen[best_i]);
		printf("iter %d, score %d: %s\n", iters++, best, specimen[0]);

	} while (best);
 
	return 0;
}
