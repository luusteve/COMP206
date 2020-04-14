/*
Program to implement a simple calculator
***************************************************************
* Author Dept . Date Notes
***************************************************************
* Steven Luu ECSE Feb 19 2020 Initial Version.
*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, char *argv[])
{
    //argc should be 4 arguments, ./simplecalc[0]  <x>[1] <op>[2] <y>[3]
    if (argc != 4 || isdigit(*argv[1]) == 0 || isdigit(*argv[3]) == 0)
    {
        printf("Error: usage is simplecalc <x> <op> <y>\n");
        return 1;
    }
    //turn character into int
    int x = atoi(argv[1]);
    int y = atoi(argv[3]);
    char op = *argv[2];
    int result;
    //Variable r might become irrational
//    float r;
    switch (op)
    {
    case '+':
    {
        result = x + y;
        printf("%i\n", result);
        break;
    }
    case '-':
    {
        result = x - y;
        printf("%i\n", result);
        break;
    }
    case '*':
    {
        result = x * y;
        printf("%i\n", result);
        break;
    }
    case '/':
    {
        result = x / y;
        printf("%i\n", result);
        break;
    }
    default:
        printf("%c not a valid operator\n", op);
        return 2;
    }
    return 0;
}
