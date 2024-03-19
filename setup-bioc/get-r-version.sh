# input_arguments <- commandArgs(trailingOnly=TRUE)
# 
# if (length(input_arguments) != 3) {
#   stop("Three arguments must be supplied.", call.=FALSE)
# } else {
#   mapping_file <- normalizePath( input_arguments[1] )
#   bioc_version <- tolower( input_arguments[2] )
#   selection <- tolower( input_arguments[3] )
# }

mapping_file=`readlink -f $1`
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
