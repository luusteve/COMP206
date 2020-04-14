/*
Linked list to store a polynomial of arbitrary length
Include adding polynomials, displaying and computing
***************************************************************
* Author Dept . Date Notes
***************************************************************
* Steven Luu	Software Engineering	April 12, 2020 Initial creation
* Steven Luu	Software Engineering	April 13, 2020 Finished functions
*/

#include <stdio.h>
#include <stdlib.h>
#include "utils.h"

struct PolyTerm
{
    int coeff;
    int expo;
    struct PolyTerm *next;
};
struct PolyTerm *head = NULL;
/*
Adds polynomial term to linked list
Assimilates polynomial to existing polynomial
input: coefficient and exponent
output: 0 indicates success, -1 failure
*/
int addPolyTerm(int coeff, int expo)
{
    if (head == NULL)
    {
        head = (struct PolyTerm *)malloc(sizeof(struct PolyTerm));
        head->coeff = coeff;
        head->expo = expo;
        head->next = NULL;
        return 0;
    }
    //2 nodes in memory to traverse, one in the past and one in the present
    struct PolyTerm *node = NULL;
    struct PolyTerm *pastNode = NULL;
    node = head;
    while (node != NULL)
    {
        //Same exponent
        if (expo == node->expo)
        {
            //DO NOT NEED TO REMOVE IF 0
            node->coeff += coeff;
            return 0;
        }

        //If exponent is smaller insert
        if (expo < node->expo)
        {
            struct PolyTerm *newNode = NULL;
            newNode = (struct PolyTerm *)malloc(sizeof(struct PolyTerm));
            //New head
            if (expo < head->expo)
            {
                newNode->coeff = coeff;
                newNode->expo = expo;
                newNode->next = node;
                head = newNode;
                return 0;
            }
            //Node inserted in between
            else
            {
                newNode->coeff = coeff;
                newNode->expo = expo;
                newNode->next = node;
                pastNode->next = newNode;
                return 0;
            }
        }
        //new exponent is biggest
        if (node->next == NULL)
        {
            struct PolyTerm *newNode = NULL;
            newNode = (struct PolyTerm *)malloc(sizeof(struct PolyTerm));
            newNode->coeff = coeff;
            newNode->expo = expo;
            newNode->next = NULL;
            node->next = newNode;
            return 0;
        }
        pastNode = node;
        node = node->next;
    }
    return -1;
}

/*
Displays polynomial expression
From smallest exponent to biggest
*/
void displayPolynomial()
{
    struct PolyTerm *node = NULL;
    node = head;
    while (node != NULL)
    {
        //smallest exponent or negative coefficient
        if (node == head || node->coeff < 0)
        {
            printf("%dx%d", node->coeff, node->expo);
        }
        //positive coefficient must display addition sign if not smallest exponent
        else
        {
            printf("+%dx%d", node->coeff, node->expo);
        }
        node = node->next;
    }
}

/*
Evaluates polynomial expression with given x
Traverses through linked list
returns integer 
*/
int evaluatePolynomial(int x)
{
    struct PolyTerm *node = NULL;
    node = head;
    int result = 0;
    while (node != NULL)
    {
        result += node->coeff * powi(x, node->expo);
        node = node->next;
    }
    return result;
}
