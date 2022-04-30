map <- BiocManager:::.version_map()
map <- map[,c("Bioc", "R", "BiocStatus")]

idx_release <- which(map$BiocStatus == "release")
idx_devel   <- which(map$BiocStatus == "devel")
idx_future   <- which(map$BiocStatus == "future")

## remove the future entry
map <- map[-idx_future,]

bioc_version <- c(as.character(map$Bioc), 'release', 'devel')
r_version <- c(map$R, map$R[ c(idx_release, idx_devel) ])

## assign appropriate Rtools version
rtools <- rep("35", length(r_version))
rtools[ r_version >= 4.0 & r_version <= 4.1 ] <- "40"
rtools[ r_version >= 4.2 ] <- "42"
               
res <- data.frame(
  bioc_version,
  r_version,
  rtools
)

## we need to use the word "devel" or "next" rather than specifying a version 
## number when using r-lib/setup-r to install the devel or pre-release version 
## of R
currentR <- as.numeric_version(rversions::r_release()$version)
# currentR <- readLines("https://rversions.r-pkg.org/r-release/")
# currentR <- grep("version", currentR, value = TRUE, fixed = TRUE)
# currentR <- gsub(".*version.*([0-9]\\.[0-9]+\\.[0-9]+).*", "\\1", x = currentR)
# currentR <- as.numeric_version(currentR)

nextR <- jsonlite::fromJSON("https://api.r-hub.io/rversions/r-next-macos")$version
nextR <- as.numeric_version(paste(strsplit(nextR, "\\.")[[1]][1:2], collapse = "."))

## For "non-release" R versions, figure out whether they should be "next" 
## or "devel"
nonrelease_R_idx <- which(res$r_version > currentR)
next_R_idx <- intersect(nonrelease_R_idx, which(res$r_version == nextR))
devel_R_idx <- setdiff(nonrelease_R_idx, next_R_idx)

res$r_version <- as.character(res$r_version)
res$r_version[next_R_idx] <- "next"
res$r_version[devel_R_idx] <- "devel"

write.csv(x = res, file = "bioc-version-map.csv", quote = FALSE, row.names = FALSE)
