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

write.csv(x = res, file = "bioc-version-map.csv", quote = FALSE, row.names = FALSE)
