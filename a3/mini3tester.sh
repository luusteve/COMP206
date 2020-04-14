#!/bin/bash

### WARNING !!!!! STUDENTS MUST NOT CHANGE/EDIT THIS FILE !!!
### You might accidentally delete/change your files or change the intention of the test case
###   if you make changes to this sript without understanding the consequences.
### This script is intended to be executed in mimi using the bash shell.

# BEGIN SETUP
export scriptdir=$PWD
export tmpdir=/tmp/__tmp_comp206_a3_${LOGNAME}
mkdir -p $tmpdir
echo "Hello there, I am first.msg" > $tmpdir/first.msg
echo "Hi, I am second.msg" > $tmpdir/second.msg
echo "Not all those who wander are lost." >> $tmpdir/msg2.txt
echo "Howdy!!, I am  greetings.txt" > $tmpdir/greetings.txt
# END SETUP

echo '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  finder.sh tests @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'

if [[ ! -f finder.sh ]]
then
  echo "-------FATAL !!! You do not have finder.sh in this directory!-------"
  echo "------- Skipping finder.sh test cases -------"
else
  cp -p $scriptdir/finder.sh $tmpdir
  cd $tmpdir
  chmod u+x $tmpdir/finder.sh

  echo '[[[[ FAIL - a3config not found ]]]]'
  echo '********************************************************************************'
  echo ./finder.sh
  ./finder.sh
  echo "Script status code is == $? =="
  echo '********************************************************************************'

  echo '[[[[ FAIL - EXTENSION is not set ]]]]'
  (
    echo "DIRNAME=$tmpdir"
  ) > $tmpdir/a3config
  echo '********************************************************************************'
  echo ./finder.sh
  ./finder.sh
  echo "Script status code is == $? =="
  echo '********************************************************************************'

  echo '[[[[ FAIL - DIRNAME is not set ]]]]'
  (
    echo "EXTENSION=msg"
  ) > $tmpdir/a3config
  echo '********************************************************************************'
  echo ./finder.sh
  ./finder.sh
  echo "Script status code is == $? =="
  echo '********************************************************************************'

  echo '[[[[ FAIL - DIRNAME value not a dir ]]]]'
  (
    echo "DIRNAME=$tmpdir/nosuchdir"
    echo "EXTENSION=msg"
  ) > $tmpdir/a3config
  echo '********************************************************************************'
  echo ./finder.sh
  ./finder.sh
  echo "Script status code is == $? =="
  echo '********************************************************************************'

  echo '[[[[ WORKS - but no files with that extension ]]]]'
  (
    echo "DIRNAME=$tmpdir"
    echo "EXTENSION=cfg"
  ) > $tmpdir/a3config
  echo '********************************************************************************'
  echo ./finder.sh
  ./finder.sh
  echo "Script status code is == $? =="
  echo '********************************************************************************'

  echo '[[[[ WORKS - without showing contents ]]]]'
  (
    echo "DIRNAME=$tmpdir"
    echo "EXTENSION=msg"
  ) > $tmpdir/a3config
  echo '********************************************************************************'
  echo ./finder.sh
  ./finder.sh
  echo "Script status code is == $? =="
  echo '********************************************************************************'

  echo '[[[[ WORKS - shows contents ]]]]'
  (
    echo "DIRNAME=$tmpdir"
    echo "EXTENSION=msg"
    echo "SHOW=true"
  ) > $tmpdir/a3config
  echo '********************************************************************************'
  echo ./finder.sh
  ./finder.sh
  echo "Script status code is == $? =="
  echo '********************************************************************************'
  cd $scriptdir
fi

echo ""
echo ""
echo '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  fname tests @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'

if [[ ! -f showusr ]]
then
  echo "-------FATAL !!! You do not have showusr in this directory!-------"
  echo "------- Skipping fname test cases -------"
else
  echo '[[[[ FAIL - userid is not passed ]]]]'
  (
    source showusr
    echo '********************************************************************************'
		echo "fname"
    fname
    echo "Function status code is ==$?==  FNAME value is ==$FNAME==" 
  )

  echo '[[[[ WORKS - but user id is not found ]]]]'
  (
    source showusr
    echo '********************************************************************************'
		echo "fname nouser"
    fname nouser
    echo "Function status code is ==$?==  FNAME value is ==$FNAME==" 
  )

  echo '[[[[ WORKS - user id is found ]]]]'
  (
    source showusr
    echo '********************************************************************************'
		echo "fname $LOGNAME"
    fname $LOGNAME
    echo "Function status code is ==$?==  FNAME value is ==$FNAME==" 
  )

fi


# BEGIN CLEANUP
# remove the temporary setup used for testing.
if [[ -d $tmpdir ]]
then
  rm -rf $tmpdir
fi
# END CLEANUP
