#!/bin/bash

### WARNING !!!!! STUDENTS MUST NOT CHANGE/EDIT THIS FILE !!!
### You might accidentally delete/change your files or change the intention of the test case
###   if you make changes to this sript without understanding the consequences.
### This script is intended to be executed in mimi using the bash shell.

# BEGIN SETUP
umask 077
testcasenum=0
function printTestCaseNum
{
	if [[ $1 == "" ]]
	then
		testcasenum=`expr $testcasenum + 1`
		echo '--> Test Case '`printf "%02d" $testcasenum`' <--'
	else
		if [[ $1 =~ 1/ ]]
		then
			testcasenum=`expr $testcasenum + 1`
		fi
		echo '--> Test Case '`printf "%02d(%s)" $testcasenum $1`' <--'
	fi
}

tmpdir=/tmp/__tmp_comp206_${LOGNAME}_$$
mkdir -p $tmpdir
rc=$?

if [[ $rc -ne 0 ]]
then
	echo "FATAL ERROR during setup !!" 1>&2
	exit 1
fi

scriptdir=$PWD

function printDataFile
{
	echo '<SSV>'
	cat data.ssv
	echo '</SSV>'
}

for f in `ls *.c *.h [Mm]akefile 2>/dev/null`
do
	if [[ -f $f ]]
	then
		cp -p $f $tmpdir
	fi
done

cd $tmpdir
# END SETUP

function cleanup()
{
# BEGIN CLEANUP
	if [[ -d $tmpdir ]]
	then
  	rm -rf $tmpdir
	fi
# END CLEANUP
}

echo '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  polyapp tests @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
echo ''
echo '********************************************************************************'
echo '[[[ Compilation test ]]]'
printTestCaseNum
echo make
make
echo 'make return code is '$?
echo '********************************************************************************'
echo ''

echo '********************************************************************************'
echo '[[[ Compilation test with random source time stamp changes ]]]'
echo '[[[ Your results might be slightly different for this test case ]]]'
echo '[[[ However, it should not show any errors or warnings from make or gcc ]]]'
echo ''
tc=1
for f in `ls *.h *.c 2>/dev/null`
do
	touch $f
	printTestCaseNum $tc/$f
	echo make
	make
	echo 'make return code is '$?
	echo '********************************************************************************'
	echo ''
	tc=`expr $tc + 1`
done

if [[ ! -x polyapp ]]
then
	echo "FATAL !! Unable to compile the program. mini tester will not continue the execution."
	cleanup
	exit 1
fi

echo '[[[[ WORKS ]]]]'
printTestCaseNum
echo '********************************************************************************'
cat > data.ssv <<-DATAEND
12 3
DATAEND
printDataFile
echo ./polyapp data.ssv
./polyapp data.ssv
echo '********************************************************************************'
echo ''

printTestCaseNum
echo '********************************************************************************'
cat > data.ssv <<-DATAEND
12 3
4 5
DATAEND
printDataFile
echo ./polyapp data.ssv
./polyapp data.ssv
echo '********************************************************************************'
echo ''

printTestCaseNum
echo '********************************************************************************'
cat > data.ssv <<-DATAEND
12 3
3 0
4 5
DATAEND
printDataFile
echo ./polyapp data.ssv
./polyapp data.ssv
echo '********************************************************************************'
echo ''

printTestCaseNum
echo '********************************************************************************'
cat > data.ssv <<-DATAEND
12 3
0 2
4 5
DATAEND
printDataFile
echo ./polyapp data.ssv
./polyapp data.ssv
echo '********************************************************************************'
echo ''

printTestCaseNum
echo '********************************************************************************'
cat > data.ssv <<-DATAEND
12 3
3 0
4 2
4 5
3 2
DATAEND
printDataFile
echo ./polyapp data.ssv
./polyapp data.ssv
echo '********************************************************************************'
echo ''

printTestCaseNum
echo '********************************************************************************'
cat > data.ssv <<-DATAEND
12 3
3 0
-4 2
4 5
3 2
DATAEND
printDataFile
echo ./polyapp data.ssv
./polyapp data.ssv
echo '********************************************************************************'
echo ''

cleanup
