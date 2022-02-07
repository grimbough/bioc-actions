input_arguments <- commandArgs(trailingOnly=TRUE)

if (length(input_arguments) < 3) {
  stop("At least three argument must be supplied.", call.=FALSE)
} else {
  dir <- input_arguments[1]
  error_on <- input_arguments[2]
  bioccheck_args <- unlist(strsplit(tail(input_arguments, -2), "[[:space:],]+"))
}

print(bioccheck_args)

if(!error_on %in% c("error", "warning", "note", "never")) {
  message("error on argument should be one of: 'error', 'warning', 'note', 'never'")
  error_on <- "never"
}

## strip leading "--" from arguments
args_list <- as.list(rep(TRUE, length(bioccheck_args)))
names(args_list) <- gsub(x = bioccheck_args, pattern = "--", replacement = "", fixed = TRUE)

## run BiocCheck
check_results <- BiocCheck::BiocCheck(package = dir, args_list)

status <- switch(error_on,
                 error = length(check_results$error),
                 warning = length(check_results$warning),
                 note = length(check_results$note),
                 never = 0)

quit(save = "no", status = status) 