/*
Helper functions
parse(char *str, int **p1, int **p2): Parse a line for coefficient and exponent
powi(int x, int expo) : Computer x power exponent
***************************************************************
* Author Dept . Date Notes
***************************************************************
* Steven Luu	Software Engineering	April 12, 2020 Initial creation
* Steven Luu	Software Engineering	April 13, 2020 Finished helper functions
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
Uses double pointer to update original
input: string and two integer pointers
output: Line of coefficient and exponent in two input pointers
*/
void parse(char *str, int **p1, int **p2)
{
    char *token1 = strtok(str, " ");
    int i1 = atoi(token1);
    char *token2 = strtok(NULL, " ");
    int i2 = atoi(token2);
    *p1 = &i1;
    *p2 = &i2;
}

/*
This only works, assuming postivie exponent
input: two integers, x and exponent
output: integer x raised to the power of the exponent
*/
int powi(int x, int expo)
{
    int result = 1;
    while (expo > 0)
    {
        //if LSB is 1, multiply result with current x
        if (expo & 1)
        {
            result *= x;
        }
        x *= x;
        //Shift bit to left by 1
        expo >>= 1;
    }
    return result;
}
