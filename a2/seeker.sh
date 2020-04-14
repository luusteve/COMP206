#!/bin/bash

#global variable to determine if option a and c are an input
optionA=false
optionC=false

while getopts ac opt; do
	case $opt in
	a) optionA=true ;;
	c) optionC=true ;;
	*) ;;
	esac
done

#Remove all the options that have been parsed by getopts
shift $((OPTIND - 1))

#Make sure that there is atleast a pattern argument
if [[ $# == 0 ]]; then
	echo "Error missing the pattern argument."
	echo "Usage $0 [-c] [-a] pattern [path]"
	exit 1
fi

if [[ $# == 2 ]]; then
	path=$2"/"
	#Make sure that the directory is valid
	if [[ ! -d $path ]]; then
		echo "Error $path is not a valid directory"
		exit 2
	fi
else
	#Make sure that the folder does not have a space
	path=$(pwd)"/"
fi

#Determine if the pattern exists
if [[ -z "$(ls $path | grep $1)" ]]; then
	echo "Unable to locate any files that has pattern $1 in its name in $path."
#Determine if options were used or not
else
	if $optionA || $optionC; then
		#optionA without optionC
		if $optionA && ! $optionC; then
			for i in $(ls $path | grep $1); do
				echo "$path$i"
			done
		#optionC without optionA
		elif ! $optionA && $optionC; then
			echo "=== Contents of: $path"$(ls $path | grep $1 | head -1)" ==="
			cat "$path"$(ls $path | grep $1 | head -1)""
		#both options
		else
			for i in $(ls $path | grep $1); do
				echo "=== Contents of: $path$i ==="
				cat "$path$i"
			done
		fi
	#No option A or C
	else
		echo $path"$(ls $path | grep $1 | head -1)"

	fi
fi
