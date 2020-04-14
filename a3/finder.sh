#!/bin/bash
#a3config is not found
if [ ! -f a3config ]
then echo "Error cannot find a3config"
	exit 1
else 
	#Imports variable from a3config
	source a3config
	if [ ! $DIRNAME ] || [ ! $EXTENSION ]
	then 
		echo "Error DIRNAME and EXTENSION must be set"
		exit 2
	#Cannot find Directory
	elif [ ! -d $DIRNAME ]
	then 
		echo "Error directory $DIRNAME does not exist"
		exit 3
	#Cannot find extension
	elif [ -z "$(ls $DIRNAME | grep $EXTENSION'$')" ]
	then
		echo "Unable to locate any files with extension $EXTENSION in $DIRNAME"
		exit 0
	#SHOW = false
	elif [ ! "$SHOW" ]
	then
		for f in $(ls $DIRNAME | grep $EXTENSION'$')
		do
			echo $DIRNAME/$f
		done
		exit 0
	#SHOW = true
	else
		for f in $(ls $DIRNAME | grep $EXTENSION'$')
		do 
			echo $DIRNAME/$f
			cat "$DIRNAME/$f"
		done
		exit 0
	fi
fi
