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
        exit 1
    fi
}

mapping_file=$1

if readlink -f $mapping_file &> /dev/null
then
  mapping_file_full=$(readlink -f $mapping_file)
else
  mapping_file_full=$(abspath $mapping_file);
fi

bioc_version=`echo $2 | tr '[:upper:]' '[:lower:]'`
selection=`echo $3 | tr '[:upper:]' '[:lower:]'`

line=`grep ^$bioc_version, $mapping_file_full`

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
