#!/bin/bash
if [[ $# -ne 2 ]];
then
        echo "Usage $0 filename tarfile"
else
        if [[ ! -f $2 ]];	# If the tar file is not found
        then
        	echo "Error cannot find tar file $2"
        else
		if [[ $(tar -tf $2 | grep -w $1) ]];   # -w for to detect full string
        	then
			echo "$1 exists in $2"
		else
			echo "$1 does not exist in $2"
		fi
        fi
fi
