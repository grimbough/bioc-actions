#!/bin/bash

## This script mostly exists to convert the string "release" to the numeric version
## number of the current Bioconductor release.  This is because BiocManager::install()
## does not accept the string "release" to it's version argument.

BIOC=$1

if [[ $BIOC =~ ^3\.[0-9]{1,2}$ || $BIOC == 'devel' || $BIOC == 'release' ]]; then
  if [[ ${BIOC} == 'release' ]]; then
    echo '3.15';
  else 
    echo ${BIOC};
  fi
else
  echo -e "Invalid Bioconductor version supplied.\nMust be one of 'devel', 'release' or a number of the format 3.xy e.g. '3.15'";
  exit 1;
fi
