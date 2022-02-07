input_arguments <- commandArgs(trailingOnly=TRUE)

if (length(input_arguments) < 2) {
  stop("At least two argument must be supplied.", call.=FALSE)
} else {
  dir <- input_arguments[1]
  bioccheck_args <- strsplit(tail(input_arguments, -1), "[[:space:],]+")[[1]]
}

## strip leading "--" from arguments
args_list <- as.list(rep(TRUE, length(bioccheck_args)))
names(args_list) <- gsub(x = bioccheck_args, pattern = "--", replacement = "", fixed = TRUE)

## run BiocCheck
check_results <- BiocCheck::BiocCheck(package = dir, args_list)

quit(save = "no", status = length(check_results$error)) 