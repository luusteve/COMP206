#!/bin/bash

### WARNING !!!!! STUDENTS MUST NOT CHANGE/EDIT THIS FILE !!!
### You might accidentally delete/change your files or change the intention of the test case
###   if you make changes to this sript without understanding the consequences.
### This script is intended to be executed in mimi using the bash shell.

# BEGIN SETUP

# END SETUP

echo '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  simplecalc tests @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
echo ''
echo '********************************************************************************'
echo '[[[ Compilation test ]]]'
gcc -o simplecalc simplecalc.c
echo 'gcc return code is '$?
echo '********************************************************************************'
echo ''

echo '[[[[ FAIL - incorrect usage ]]]]'
echo '********************************************************************************'
echo ./simplecalc 500 +
./simplecalc 500 +
echo "return code is $?"
echo '********************************************************************************'
echo ''

echo '[[[[ FAIL - unsupported operator ]]]]'
echo '********************************************************************************'
echo ./simplecalc 500 @ 200
./simplecalc 500 @ 200
echo "return code is $?"
echo '********************************************************************************'
echo ''

echo '[[[[ WORKS ]]]]'
echo '********************************************************************************'
echo ./simplecalc 500 + 200
./simplecalc 500 + 200
echo "return code is $?"
echo '********************************************************************************'
echo ./simplecalc 500 - 200
./simplecalc 500 - 200
echo "return code is $?"
echo '********************************************************************************'
echo ./simplecalc 500 / 200
./simplecalc 500 / 200
echo "return code is $?"
echo '********************************************************************************'
echo ./simplecalc 500 '*' 200
./simplecalc 500 '*' 200
echo "return code is $?"
echo '********************************************************************************'
echo ''

echo ''
echo ''

echo '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  caesarcipher tests @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'

echo ''
echo '********************************************************************************'
echo '[[[ Compilation test ]]]'
gcc -o caesarcipher caesarcipher.c
echo 'gcc return code is '$?
echo '********************************************************************************'
echo ''

echo '[[[[ FAIL - incorrect usage ]]]]'
echo '********************************************************************************'
echo ./caesarcipher
./caesarcipher
echo "return code is $?"
echo '********************************************************************************'

echo '[[[[ WORKS - right shift ]]]]'
echo '********************************************************************************'
echo ./caesarcipher 17 
echo abcdefghijklmnopqrstuvwxyz
./caesarcipher 17 <<MSGEND
abcdefghijklmnopqrstuvwxyz
MSGEND
echo "return code is $?"
echo '********************************************************************************'

echo '[[[[ WORKS - left shift ]]]]'
echo '********************************************************************************'
echo ./caesarcipher -17 
echo abcdefghijklmnopqrstuvwxyz
./caesarcipher -17 <<MSGEND
abcdefghijklmnopqrstuvwxyz
MSGEND
echo "return code is $?"
echo '********************************************************************************'


echo '[[[[ WORKS - multiple lines ]]]]'
echo '********************************************************************************'
echo ./caesarcipher 7 
echo 'meet me at the restaurant'
echo 'for dinner after six on tuesday'
./caesarcipher 7 <<MSGEND
meet me at the restaurant
for dinner after six on tuesday
MSGEND
echo "return code is $?"
echo '********************************************************************************'

echo '[[[[ WORKS - Does not change non-lowercase characters, etc. ]]]]'
echo '********************************************************************************'
echo ./caesarcipher 7 
echo 'Greetings COMP206!! We come in peace.'
./caesarcipher 7 <<MSGEND
Greetings COMP206!! We come in peace.
MSGEND
echo "return code is $?"
echo '********************************************************************************'


# BEGIN CLEANUP
# END CLEANUP
