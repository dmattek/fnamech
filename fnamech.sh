#!/bin/bash

#####################################################################
# Script  name      : fnamech.sh
#
# Author            : Maciej Dobrzynski
#
# Date created      : 20170411
#
# Purpose           : Process files recursively in the directory and change part of filename
#
# Example usage
#  assume we have a directory ~/tmp with files: 
#  ch1_t1.tif, 
#  ch1_t2.tif, etc.
#  and we want to rename extensions from "tif" to "TIFF"
#
#  ./fnamech.sh -f .tif -t .TIFF ~/tmp
#  
#  Note, there's no trailing slash in directory name
#
# If the selected pattern appears more than once,
# the substitution will occur only for the last instance.
# 
# WARNING: uses GNU getopt
# Standard OSX installation of getopt doesn't support long params
# Install through macports
# sudo port install getopt
#
# Tested on:
# OSX 10.11.6 (Darwin Kernel Version 15.6.0)
# Ubuntu 16.04.2 LTS
# 
#####################################################################

usage="This script changes extensions of all files recursively in the current folder.

Usage:
$(basename "$0") [-h] [-f char] [-t char] path_without_trailing_/

where:
	-h | --help		Show this Help text.
	-f | --from		Part of file name to change from (default TIF).
	-t | --to   	Part of file name to change to (default tif).
	-d | --debug	Test mode. Explicitly prints extracted and padded numbers. Don't use for "
	

# string: extension to change from
EXTFROM=TIF

# string: extension to change to
EXTTO=tif

# Flag for test mode
TST=0

# read arguments
TEMP=`getopt -o dhf:t: --long debug,help,from:,to: -n 'fextch.sh' -- "$@"`
eval set -- "$TEMP"

# Extract options and their arguments into variables.
# Tutorial at:
# http://www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt

while true ; do
    case "$1" in
        -d|--debug) TST=1 ; shift ;;
        -h|--help) echo "$usage"; exit ;;
        -f|--from)
            case "$2" in
                "") shift 2 ;;
                *) EXTFROM=$2 ; shift 2 ;;
            esac ;;
        -t|--to)
            case "$2" in
                "") shift 2 ;;
                *) EXTTO=$2 ; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done


# Loop recursively through all files
# From: http://stackoverflow.com/a/15088473/1898713
# /tmp/* are files in dir and /tmp/**/* are files in subfolders
# It is possible that you have to enable globstar option (shopt -s globstar)
for currf in $1/**/* ; do
	newf=`echo ${currf/$EXTFROM/$EXTTO}`
	printf "From: %s\nTo: %s\n\n" $currf $newf
	if [ $TST -eq 0 ]; then
		mv $currf $newf
	fi
done
