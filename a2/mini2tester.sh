#!/bin/bash

### WARNING !!!!! STUDENTS MUST NOT CHANGE/EDIT THIS FILE !!!
### You might accidentally delete/change your files or change the intention of the test case
###   if you make changes to this sript without understanding the consequences.
### This script is intended to be executed in mimi using the bash shell.

# BEGIN SETUP
scriptdir=$PWD
tmpdir=/tmp/__tmp_comp206_${LOGNAME}
mkdir -p $tmpdir
echo "Hello there, I am msg.txt" > $tmpdir/msg.txt
echo "Hi, I am msg2.txt" > $tmpdir/msg2.txt
echo "Not all those who wander are lost." >> $tmpdir/msg2.txt
echo "Howdy!!, I am  greetings.txt" > $tmpdir/greetings.txt

tardir=206tartest
mkdir -p $tmpdir/$tardir
echo "I am 206notes.txt" > $tmpdir/$tardir/206notes.txt
echo "I am 206cribsheet.txt" > $tmpdir/$tardir/206cribsheet.txt
echo "I am readme.txt" > $tmpdir/$tardir/readme.txt
cd $tmpdir
tar -cf $tardir/tar1.tar $tardir/*.txt
tar -cf $tardir/tar2.tar $tardir/readme.txt
cd $scriptdir
# END SETUP

echo '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  tarzan.sh tests @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'

echo '[[[[ FAIL - incorrect usage ]]]]'
echo '********************************************************************************'
echo ./tarzan.sh
./tarzan.sh
echo '********************************************************************************'
echo ./tarzan.sh 206notes.txt
./tarzan.sh 206notes.txt
echo '********************************************************************************'

echo '[[[[ FAIL - tar file not found ]]]]'
echo '********************************************************************************'
echo ./tarzan.sh 206notes.txt $tmpdir/$tardir/tar3.tar
./tarzan.sh 206notes.txt $tmpdir/$tardir/tar3.tar
echo '********************************************************************************'

echo '[[[[ WORKS - tar has the file ]]]]'
echo '********************************************************************************'
echo ./tarzan.sh 206notes.txt $tmpdir/$tardir/tar1.tar
./tarzan.sh 206notes.txt $tmpdir/$tardir/tar1.tar
echo '********************************************************************************'

echo '[[[[ WORKS - tar does not contain the file ]]]]'
echo '********************************************************************************'
echo ./tarzan.sh 206notes.txt $tmpdir/$tardir/tar2.tar
./tarzan.sh 206notes.txt $tmpdir/$tardir/tar2.tar
echo '********************************************************************************'


echo ""
echo ""
echo '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  seeker.sh tests @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'

# FAIL - incorrect usage
echo '[[[[ FAIL - incorrect usage ]]]]'
echo '********************************************************************************'
echo ./seeker.sh
./seeker.sh
echo '********************************************************************************'
echo ./seeker.sh -c
./seeker.sh -c
echo '********************************************************************************'
echo ./seeker.sh -a
./seeker.sh -a
echo '********************************************************************************'
echo ./seeker.sh -c -a
./seeker.sh -c -a
echo '********************************************************************************'

# FAIL - Invalid directory
echo '[[[[ FAIL - directory not present ]]]]'
echo '********************************************************************************'
echo ./seeker.sh msg /nosuchdir
./seeker.sh msg /nosuchdir
echo '********************************************************************************'
echo ./seeker.sh -a msg /nosuchdir
./seeker.sh -a msg /nosuchdir
echo '********************************************************************************'

# FAIL - cannot find pattern
echo '[[[[ FAIL - cannot find pattern ]]]]'
echo '********************************************************************************'
echo ./seeker.sh -a meow $tmpdir
./seeker.sh -a meow $tmpdir
echo '********************************************************************************'

# WORKS
echo '[[[[ WORKS ]]]]'
echo '********************************************************************************'
echo ./seeker.sh -a msg $tmpdir
./seeker.sh -a msg $tmpdir
echo '********************************************************************************'
echo ./seeker.sh msg $tmpdir
./seeker.sh  msg $tmpdir
echo '********************************************************************************'
echo ./seeker.sh -c msg $tmpdir
./seeker.sh -c msg $tmpdir
echo '********************************************************************************'
echo ./seeker.sh -c -a msg $tmpdir
./seeker.sh -c -a msg $tmpdir
echo '********************************************************************************'
cd $tmpdir
echo $scriptdir/seeker.sh -c -a msg
$scriptdir/seeker.sh -c -a msg
cd $scriptdir
echo '********************************************************************************'


# BEGIN CLEANUP
# remove the temporary setup used for testing.
if [[ -d $tmpdir ]]
then
  rm -rf $tmpdir
fi
# END CLEANUP
