#!/bin/bash

### WARNING !!!!! STUDENTS MUST NOT CHANGE/EDIT THIS FILE !!!
### You might accidentally delete/change your files or change the intention of the test case
###   if you make changes to this sript without understanding the consequences.
### This script is intended to be executed in mimi using the bash shell.

# BEGIN SETUP
testcasenum=0
function printTestCaseNum
{
	testcasenum=`expr $testcasenum + 1`
	echo '--> Test Case '`printf "%02d" $testcasenum`' <--'
}

tmpdir=/tmp/__tmp_comp206_${LOGNAME}_$$
mkdir -p $tmpdir
stderrfile=$tmpdir/stderr.txt
scriptdir=$PWD

function printDataFile
{
	tag=$1
	echo '<'$tag'>'
	if [[ -f bankdata.csv ]]
	then
		cat bankdata.csv
	else
		echo '<NO FILE>'
	fi
	echo '</'$tag'>'
}

function printStderr
{
	echo '---- contents to stderr is ----'
	echo '<STDERR>'
	cat $stderrfile
	echo '</STDERR>'
}
# END SETUP

# Delete the current executable to recompile it from scratch.
if [[ -f bankapp ]]
then
	rm -f bankapp
fi

echo '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  bankapp tests @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
echo ''
echo '********************************************************************************'
echo '[[[ Compilation test ]]]'
printTestCaseNum
echo gcc -o bankapp bankapp.c
gcc -o bankapp bankapp.c
echo 'gcc return code is '$?
echo '********************************************************************************'
echo ''

if [[ ! -x bankapp ]]
then
	echo "FATAL !! Unable to compile the program. mini tester will not continue the execution."
	exit 1
fi

cp bankapp $tmpdir
cd $tmpdir

echo '[[[[ FAIL - incorrect usage ]]]]'
printTestCaseNum
echo '********************************************************************************'
cat > bankdata.csv <<-DATAEND
AC,1024,John Smith
DATAEND
printDataFile DATAFILEBEFORE
echo ./bankapp
./bankapp 2>$stderrfile
rc=$?
printStderr
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''

printTestCaseNum
echo '********************************************************************************'
cat > bankdata.csv <<-DATAEND
AC,1024,John Smith
DATAEND
printDataFile DATAFILEBEFORE
echo ./bankapp -a 1024
./bankapp -a 1024 2>$stderrfile
rc=$?
printStderr
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''

printTestCaseNum
echo '********************************************************************************'
cat > bankdata.csv <<-DATAEND
AC,1024,John Smith
DATAEND
printDataFile DATAFILEBEFORE
echo ./bankapp -d 1024 2010-02-12
./bankapp -d 1024 2010-02-12 2>$stderrfile
rc=$?
printStderr
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''

printTestCaseNum
echo '********************************************************************************'
cat > bankdata.csv <<-DATAEND
AC,1024,John Smith
TX,1024,2010-02-12,1500
DATAEND
printDataFile DATAFILEBEFORE
echo ./bankapp -w 1024
./bankapp -w 1024 2>$stderrfile
rc=$?
printStderr
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''

echo ''
echo '[[[[ FAIL - data file is missing ]]]]'
printTestCaseNum
echo '********************************************************************************'
printDataFile DATAFILEBEFORE
echo ./bankapp -a 1024 'John Smith'
./bankapp -a 1024 'John Smith' 2>$stderrfile
rc=$?
printStderr
printDataFile DATAFILEAFTER
echo "return code is $rc"
echo '********************************************************************************'
echo ''


echo ''
echo '[[[[ Handle an empty data file gracefully ]]]]'
printTestCaseNum
echo '********************************************************************************'
touch bankdata.csv
printDataFile DATAFILEBEFORE
echo ./bankapp -a 1024 'John Smith'
./bankapp -a 1024 'John Smith'
rc=$?
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''
printTestCaseNum
echo '********************************************************************************'
touch bankdata.csv
printDataFile DATAFILEBEFORE
echo ./bankapp -d 1024 2020-02-10 400.00
./bankapp -d 1024 2020-02-10 400.00
rc=$?
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''
printTestCaseNum
echo '********************************************************************************'
touch bankdata.csv
printDataFile DATAFILEBEFORE
echo ./bankapp -w 1024 2020-02-10 400.00
./bankapp -w 1024 2020-02-10 400.00
rc=$?
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''

echo ''
echo '[[[[ WORKS - Add a new account ]]]]'
printTestCaseNum
echo '********************************************************************************'
cat > bankdata.csv <<-DATAEND
AC,1025,John Snow
AC,1024,John Smith
TX,1025,2020-01-10,400.00
AC,1026,Mary Jane
TX,1025,2020-02-11,-300.00
TX,1024,2020-02-12,200.00
DATAEND
printDataFile DATAFILEBEFORE
echo ./bankapp -a 1027 'Jane Smith'
./bankapp -a 1027 'Jane Smith'
rc=$?
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''

echo ''
echo '[[[[ FAILS - Add Account - account number already exists ]]]]'
printTestCaseNum
echo '********************************************************************************'
cat > bankdata.csv <<-DATAEND
AC,1025,John Snow
AC,1024,John Smith
TX,1025,2020-01-10,400.00
AC,1026,Mary Jane
TX,1025,2020-02-11,-300.00
TX,1024,2020-02-12,200.00
DATAEND
printDataFile DATAFILEBEFORE
echo ./bankapp -a 1024 'Jane Smith'
./bankapp -a 1024 'Jane Smith' 2>$stderrfile
rc=$?
printStderr
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''

echo ''
echo '[[[[ WORKS - make a deposit ]]]]'
printTestCaseNum
echo '********************************************************************************'
cat > bankdata.csv <<-DATAEND
AC,1025,John Snow
AC,1024,John Smith
TX,1025,2020-01-10,400.00
AC,1026,Mary Jane
TX,1025,2020-02-11,-300.00
TX,1024,2020-02-12,200.00
DATAEND
printDataFile DATAFILEBEFORE
echo ./bankapp -d 1024 2020-02-13 2500.45
./bankapp -d 1024 2020-02-13 2500.45
rc=$?
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''

echo ''
echo '[[[[ FAILS - deposit - account number does not exists ]]]]'
printTestCaseNum
echo '********************************************************************************'
cat > bankdata.csv <<-DATAEND
AC,1025,John Snow
AC,1024,John Smith
TX,1025,2020-01-10,400.00
AC,1026,Mary Jane
TX,1025,2020-02-11,-300.00
TX,1024,2020-02-12,200.00
DATAEND
printDataFile DATAFILEBEFORE
echo ./bankapp -d 1029 2020-02-13 2500.45
./bankapp -d 1029 2020-02-13 2500.45 2>$stderrfile
rc=$?
printStderr
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''

echo ''
echo '[[[[ FAILS - withdrawal - account number does not exists ]]]]'
printTestCaseNum
echo '********************************************************************************'
cat > bankdata.csv <<-DATAEND
AC,1025,John Snow
AC,1024,John Smith
TX,1025,2020-01-10,400.00
AC,1026,Mary Jane
TX,1025,2020-02-11,-300.00
TX,1024,2020-02-12,200.00
DATAEND
printDataFile DATAFILEBEFORE
echo ./bankapp -w 1029 2020-02-13 2500.45
./bankapp -w 1029 2020-02-13 2500.45 2>$stderrfile
rc=$?
printStderr
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''

echo ''
echo '[[[[ FAILS - withdrawal - no sufficient balance ]]]]'
printTestCaseNum
echo '********************************************************************************'
cat > bankdata.csv <<-DATAEND
AC,1025,John Snow
AC,1024,John Smith
TX,1025,2020-01-10,400.00
AC,1026,Mary Jane
TX,1026,2020-02-11,100.00
TX,1025,2020-02-11,-300.60
TX,1024,2020-02-12,200.00
DATAEND
printDataFile DATAFILEBEFORE
echo ./bankapp -w 1025 2020-02-13 500.45
./bankapp -w 1025 2020-02-13 500.45 2>$stderrfile
rc=$?
printStderr
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''

echo ''
echo '[[[[ WORKS - withdrawal ]]]]'
printTestCaseNum
echo '********************************************************************************'
cat > bankdata.csv <<-DATAEND
AC,1025,John Snow
AC,1024,John Smith
TX,1025,2020-01-10,400.00
AC,1026,Mary Jane
TX,1026,2020-02-11,100.00
TX,1025,2020-02-11,-300.60
TX,1024,2020-02-12,200.00
DATAEND
printDataFile DATAFILEBEFORE
echo ./bankapp -w 1025 2020-02-13 99.30
./bankapp -w 1025 2020-02-13 99.30 2>$stderrfile
rc=$?
printDataFile DATAFILEAFTER
echo "return code is $rc"
rm bankdata.csv
echo '********************************************************************************'
echo ''



# BEGIN CLEANUP
if [[ -d $tmpdir ]]
then
  rm -rf $tmpdir
fi
# END CLEANUP
