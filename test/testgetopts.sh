#!/bin/bash

function test_getopts() 
{
# 	echo "OPTIND starts at $OPTIND"
	while getopts ":qp:" optname
	do
		case "$optname" in
			"q")
				echo "option $optname has value $OPTARG"
				;;
			"p")
				echo "option $optname has value $OPTARG"
				;;
			"*")
				echo "unknown option $OPTARG"
				;;
			":")
				echo "No argument value for option $OPTARG"
				;;
			*)
				echo "Uknown error while processing options"
				;;
		esac
	done
# 	echo "OPTIND is now $OPTIND"
}

test_getopts $@
<<usage
scriptfilename -q aa -p bb llll
usage
