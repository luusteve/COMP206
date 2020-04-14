/*
Bank app
Add account number
Make Deposit
Make a withdrawal
DATA stored in bankdata.csv
***************************************************************
* Author Dept . Date Notes
***************************************************************
* Steven Luu	Software Engineering	March 4, 2020 Initial creation
* Steven Luu	Software Engineering	March 9, 2020 CSV PARSER
* Steven Luu	Software Engineering	March 10, 2020 END integration 
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <unistd.h>

#define MAX_DB_LEN 1024

/*
line = line of string
num = column number, seperated by comas
*/
char *getField(char *line, int num)
{
    const char *p = line;
    size_t len;
    char *field;
    while (1)
    {
        //Find length of current field, separated by coma or newline
        len = strcspn(p, ",\n");
        //field is reached, break
        if (--num <= 0)
            break;
        //pointer p goes to + len, which is the next field
        p += len;
        if (*p == ',')
            //goes to first character of the field
            p++;
    }
    //Matched field is of size len + 1. +1 for the end '\0'
    //field will be allocated the length of the field
    field = malloc(len + 1);
    if (field)
    {
        memcpy(field, p, len);
        //end of string
        field[len] = '\0';
    }
    return field;
}

int main(int argc, char *argv[])
{
    //initiate options
    int aFlag = 0;
    int dFlag = 0;
    int wFlag = 0;
    int accountNumber;
    char name[30];
    char *date = NULL;
    float amount;
    FILE *fp;

    int opt;

    //Determine which option has been selected and switch flags
    while ((opt = getopt(argc, argv, "adw")) != -1)
    {
        switch (opt)
        {
        case 'a':
            if (argc != 4)
            {
                fprintf(stderr, "%s", "Error, incorrect usage!\n");
                fprintf(stderr, "%s", "-a ACCTNUM NAME\n");
                return 1;
            }
            aFlag = 1;
            accountNumber = atoi(argv[2]);
            strcpy(name, argv[3]);
            break;

        case 'd':
            if (argc != 5)
            {
                fprintf(stderr, "%s", "Error, incorrect usage!\n");
                fprintf(stderr, "%s", "-d ACCTNUM DATE AMOUNT\n");
                return 1;
            }
            dFlag = 1;
            accountNumber = atoi(argv[2]);
            date = argv[3];
            amount = atof(argv[4]);
            break;
        case 'w':
            if (argc != 5)
            {
                fprintf(stderr, "%s", "Error, incorrect usage!\n");
                fprintf(stderr, "%s", "-w ACCTNUM DATE AMOUNT\n");
                return 1;
            }
            wFlag = 1;
            accountNumber = atoi(argv[2]);
            date = argv[3];
            amount = atof(argv[4]);
            break;
        }
    }
    //No valid options
    if (!(aFlag || dFlag || wFlag))
    {
        fprintf(stderr, "%s", "Error, incorrect usage!\n");
        fprintf(stderr, "%s", "-a ACCTNUM NAME\n");
        fprintf(stderr, "%s", "-d ACCTNUM DATE AMOUNT\n");
        fprintf(stderr, "%s", "-w ACCTNUM DATE AMOUNT\n");
        return 1;
    }

    //Check if file exists
    if (access("bankdata.csv", F_OK) == -1)
    {
        fprintf(stderr, "%s", "Error, unable to locate the data file bankdata.csv\n");
        return 100;
    }
    fp = fopen("bankdata.csv", "a+");
    char line[MAX_DB_LEN];
    //ADD ACCOUNT
    if (aFlag)
    {
        //go through every line in search of AC
        while (fgets(line, MAX_DB_LEN, fp))
        {
            char *tmp = strdup(line);
            if (strcmp(getField(tmp, 1), "AC") == 0)
            {
                //convert string to integer and compare to current accountNumber
                if (accountNumber == atoi(getField(tmp, 2)))
                {
                    fprintf(stderr, "Error, account number %d already exists\n", accountNumber);
                    return 50;
                }
            }
            //Deallocate allocated memory
            free(tmp);
        }
        fprintf(fp, "AC,%d,%s\n", accountNumber, name);
    }
    //DEPOSIT
    else if (dFlag)
    {
        //set to 1 if AC exists
        int exists = 0;
        //go through every line in search of AC
        while (fgets(line, MAX_DB_LEN, fp))
        {
            char *tmp = strdup(line);
            if (strcmp(getField(tmp, 1), "AC") == 0)
            {
                //convert string to integer and compare to current accountNumber
                if (accountNumber == atoi(getField(tmp, 2)))
                {
                    exists = 1;
                }
            }
            //Deallocate allocated memory
            free(tmp);
        }
        if (exists)
        {
            fprintf(fp, "TX,%d,%s,%.2f\n", accountNumber, date, amount);
        }
        else
        {
            fprintf(stderr, "Error, account number %d does not exists\n", accountNumber);
            return 50;
        }
    }
    //WITHDRAW
    else if (wFlag)
    {

        //set to 1 if AC exists
        int exists = 0;
        float balance = 0;

        while (fgets(line, MAX_DB_LEN, fp))
        {
            char *tmp = strdup(line);
            if (accountNumber == atoi(getField(tmp, 2)))
            {
                exists = 1;
            }
            if (strcmp(getField(tmp, 1), "TX") == 0)
            {
                if (accountNumber == atoi(getField(tmp, 2)))
                {
                    //convert string to integer and compare to current accountNumber
                    balance += atof(getField(tmp, 4));
                }
            }
            //Deallocate allocated memory
            free(tmp);
        }
        if (!exists)
        {
            fprintf(stderr, "Error, account number %d does not exists\n", accountNumber);
            return 50;
        }
        balance -= amount;
        if (balance >= 0)
        {
            fprintf(fp, "TX,%d,%s,-%.2f\n", accountNumber, date, amount);
        }
        else
        {
            balance += amount;
            fprintf(stderr, "Error, account number %d has only %.2f\n", accountNumber, balance);
            return 60;
        }
    }

    fclose(fp);
    return 0;
}
