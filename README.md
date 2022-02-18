# Github Actions for Bioconductor

[![Top-level package repository](https://github.com/grimbough/biocActionsExamples/actions/workflows/top-level-pkg.yml/badge.svg?event=workflow_dispatch)](https://github.com/grimbough/biocActionsExamples/actions/workflows/top-level-pkg.yml)

This repository holds some GitHub actions that may be useful for those developing or maintaining R packages that will be hosted by the [Bioconductor](https://www.bioconductor.org) project.  These actions are built upon the [GitHub Actions for the R language](r-lib/actions) and should be considered complementary to them.  It's also recommended to take a look at the [biocthis](https://bioconductor.org/packages/biocthis/) package, which provides templates and functions for setting up GitHub Actions workflows for Bioconductor packages.

## Actions

The actions currently hosted here are:

- [bioc-actions/setup-bioc](https://github.com/grimbough/bioc-actions/tree/v1/setup-bioc) - Given a version of Bioconductor, this action installs the appropriate version of R and initialises the [BiocManager](https://cran.r-project.org/package=BiocManager) package.
- [bioc-actions/run-BiocCheck](https://github.com/grimbough/bioc-actions/tree/v1/run-BiocCheck) - Runs `BiocCheck::BiocCheck()` on a given package directory.
- [bioc-actions/build-install-check](https://github.com/grimbough/bioc-actions/tree/v1/build-install-check) - Build, install, and check a package emulating the process used by the Bioconductor Build System.

## Examples

Example workflows for using these actions on both a package repository and a repository where a package is stored in a subdirectory can be found in the [biocActionsExamples](https://github.com/grimbough/biocActionsExamples) repository.