/*
POLYNOMIAL APPLICATION
Parse through a file for coefficient and exponent
Adds polynomial term to a list
Displays and computes with x given by user.
***************************************************************
* Author Dept . Date Notes
***************************************************************
* Steven Luu	Software Engineering	APRIL 12, 2020 Initial creation
* Steven Luu	Software Engineering	APRIL 13, 2020 Completed polyapp.c
*/

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include "poly.h"
#include "utils.h"
#include <unistd.h>

#define MAX_DB_LEN 1024

int main(int argc, char *argv[])
{
    //Check that an argument is passed
    if (argc < 2)
    {
        printf("One argument expected.\n");
    }
    else if (argc > 2)
    {
        printf("Too many arguments supplied.\n");
    }
    else
    {

        FILE *fp;
        //File not Found
        if (access(argv[1], F_OK) == -1)
        {
            fprintf(stderr, "Error, unable to locate the data file %s\n", argv[1]);
            return -1;
        }
        fp = fopen(argv[1], "r");
        char line[MAX_DB_LEN];
        while (fgets(line, MAX_DB_LEN, fp))
        {
            int *p1 = 0;
            int *p2  = 0;
            parse(line, &p1, &p2);
            addPolyTerm(*p1, *p2);
        }
        displayPolynomial();
        printf("\n");
        //Display x=[-2,-1,0,1,2,]
        for (int i = -2; i < 3; i ++) {
            printf("for x=%d, y=%d\n",i,evaluatePolynomial(i));
        }
    }
    return 0;
}