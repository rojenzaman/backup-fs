#!/bin/bash

# print usage info
usage() {
	echo "Usage: ${BASH_SOURCE[0]} -l list -d dir"
        exit 1
} ; if [[ "$#" -lt 4 ]]; then usage; fi

# parse options
while getopts ":l:d:" opt; do
    case "${opt}" in
	l) list="${OPTARG}" ; test -f "${list}" && lflag=true ;;
	d) dir="$(realpath "${OPTARG}")" ; test -d "${dir}" && dflag=true ;;
        :) echo "Error: -${OPTARG} requires an argument." ; usage ;;
        *) usage ;;
    esac
done

# check important variables
if [[ ! "${lflag}" ]]; then echo "-l option must be specified"; exit 1; fi
if [[ ! "${dflag}" ]]; then echo "-d option must be specified"; exit 1; fi

while IFS= read -r entity; do
	rsync -Rradhzv --delete "${entity}" "${dir}/"
done < "${list}"
