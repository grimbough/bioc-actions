# Github Actions for Bioconductor

This repository holds some GitHub actions that may be useful for those developing or maintaining R packages that will be hosted by the [Bioconductor](https://www.bioconductor.org) project.  These actions are built upon the [GitHub Actions for the R languarge](r-lib/actions) and should be considered complementary to them.  It's also recommended to checkout the [biocthis](https://bioconductor.org/packages/biocthis/) package which provides templates and functions for setting up GitHub Actions workflows for Bioconductor packages.

The actions currently hosted here are:

- [grimbough/bioc-actions/setup-bioc](https://github.com/grimbough/bioc-actions/tree/main/setup-bioc) - Given a version of Bioconductor, this action installs the appropriate version of R and initialises the [BiocManager](https://cran.r-project.org/package=BiocManager) package.
- [grimbough/bioc-actions/run-bioc-check](https://github.com/grimbough/bioc-actions/tree/main/run-bioc-check) - Runs `BiocCheck::BiocCheck()` on a given package directory.

