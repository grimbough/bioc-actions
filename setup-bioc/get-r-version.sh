#!/usr/bin/env bash

abspath() {
    if [[ -d "$1" ]]
    then
        pushd "$1" >/dev/null
        pwd
        popd >/dev/null
    elif [[ -e "$1" ]]
    then
        pushd "$(dirname "$1")" >/dev/null
        echo "$(pwd)/$(basename "$1")"
        popd >/dev/null
    else
        echo "$1" does not exist! >&2
        return 127
    fi
}

if readlink -f $1 2>&1/dev/null; then
  mapping_file=$(readlink -f $1)
else
  mapping_file=$(abspath $1);
fi

bioc_version=`echo $2 | tr '[:upper:]' '[:lower:]'`
selection=`echo $3 | tr '[:upper:]' '[:lower:]'`

line=`grep ^$bioc_version, $mapping_file`

if [ $selection = "bioc_version_explicit" ]; then
  result=`echo $line | cut -d, -f 2 -`
elif [ $selection = "r_version" ]; then
  result=`echo $line | cut -d, -f 3 -`
elif [ $selection = "rtools" ]; then
  result=`echo $line | cut -d, -f 4 -`
else 
  echo "Unknown column selected"
  exit 1
fi

echo $result
exit 0
