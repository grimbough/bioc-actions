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

## we need to use the word "devel" rather than specifyin a version number
## when using r-lib/setup-r to install the devel version of R
currentR <- readLines("https://rversions.r-pkg.org/r-release/")
currentR <- grep("version", currentR, value = TRUE, fixed = TRUE)
currentR <- gsub(".*version.*([0-9]\\.[0-9]+\\.[0-9]+).*", "\\1", x = currentR)
currentR <- as.numeric_version(currentR)

devel_R_idx <- which(res$r_version > currentR)

res$r_version <- as.character(res$r_version)
res$r_version[devel_R_idx] <- "devel"

write.csv(x = res, file = "bioc-version-map.csv", quote = FALSE, row.names = FALSE)
