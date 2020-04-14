/*
Program to implement a basic version of Caesar's cipher
***************************************************************
* Author Dept . Date Notes
***************************************************************
* Steven Luu ECSE Feb 19 2020 Initial Version.
*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, char *argv[])
{
    //atoi returns 0 if not a number, but need to check if the value was 0

    if (argc != 2)
    {

        printf("Error: usage is caesarcipher <offset>\n");
        return 1;
    }
    // modulo 26 ensures that the wrap around is efficient
    // Example caesar cipher 52 = caesar ciper 0
    int offset = atoi(argv[1])%26;
    //ensures that program runs till runs out of inputs
    char d;
    int i;
    //unsigned char is used if value goes 0-255
    unsigned char c;
    //Continue until EOF
    while ((d = getchar()) != EOF)
    {
	c = d;
        //only lower case is ciphered
	//in ascii 97=a and 122=z
        if (c >= 'a' && c <= 'z')
        {
            c = c + offset;
            //wrap arround
            if (c > 'z')
            {
                c = c - 'z' + 'a' - 1;
            }
	    //only necessary if offset is negative
	    else if ( c < 'a' )
	    {
		c = c + 26;
		}
        }
        printf("%c", c%127);
    }

    return 0;
}
