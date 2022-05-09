
input_arguments <- commandArgs(trailingOnly=TRUE)

if (length(input_arguments) != 3) {
  stop("Three arguments must be supplied.", call.=FALSE)
} else {
  mapping_file <- normalizePath( input_arguments[1] )
  bioc_version <- tolower( input_arguments[2] )
  selection <- tolower( input_arguments[3] )
}

## Check file exists and then read it
if(!file.exists(mapping_file)) {
  stop("Unable to find the map file: ", mapping_file)
} else {
  version_map <- read.csv(file = mapping_file)
}

## Check the given Bioc version is valid
if(!(bioc_version %in% version_map[[ 'bioc_version' ]])) {
  stop("Unknown Bioconductor version: ", bioc_version)
} else {
  row_idx <- which(version_map[[ 'bioc_version' ]] == bioc_version)
}

## Check our selection is a valid column name
if(!(selection %in% colnames(version_map))) {
  stop("Unknown selection argument: ", selection, 
       "\nValid options are: ", 
       paste(tail(colnames(version_map), n = -1), collapse = ' '))
} else {
  result <- version_map[ row_idx, selection ]
}

## print results to screen
cat(result)

quit(save = "no", status = 0)