#!/bin/bash - 
# 如何区分参数和选项，注意showopts的返回值
function showopts()
{
	while getopts ":pq:" optname
	do
		case "$optname" in 
			"p")
				echo "option $optname is specified"
				;;
			"q") 
				echo "option $optname has value $OPTARG"
				;;
			"?")
				echo "Unknown option $OPTARG"
				;;
		esac
	done
	return $OPTIND
}

function showargs()
{
	for p in "$@"
	do
		echo "[$p]"
	done
}

optinfo=$(showopts "$@")
argstart=$?
arginfo=$(showargs "${@:$argstart}")
echo "Arguments are:"
echo "$arginfo"
echo "=========="
echo "Options are:"
echo "$optinfo"

<<usage 
./scriptfilename -p -q hehe a b c d e f
usage
