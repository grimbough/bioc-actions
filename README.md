# Github Actions for Bioconductor

[![Workflow that tests the actions](https://github.com/grimbough/biocActionsExamples/actions/workflows/example-workflow.yml/badge.svg)](https://github.com/grimbough/biocActionsExamples/actions/workflows/example-workflow.yml)

This repository holds some GitHub actions that may be useful for those developing or maintaining R packages that will be hosted by the [Bioconductor](https://www.bioconductor.org) project.  Actions can be considered as tasks that form the building blocks of larger workflows.  The development of an R package often benefits from the deployment of workflows for testing the code in a variety of conditions e.g. a variety of operating systems and specific versions of software.

The acceptance of a package to Bioconductor project, as well as continued inclusion and deployment by passing tests on it's nightly build system, involves accommodating a number of specific requirements and features that make developing for it subtly different to a CRAN package.  The actions provided here aim to simplify deploying a Github Workflow that closely matches the Bioconductor requirements.

These actions are built upon the [GitHub Actions for the R language](r-lib/actions) and should be considered complementary to them.  It's also recommended to take a look at the [biocthis](https://bioconductor.org/packages/biocthis/) package, which provides templates and functions for setting up GitHub Actions workflows for Bioconductor packages.

## Actions

The actions currently hosted here are:

- [bioc-actions/setup-bioc](https://github.com/grimbough/bioc-actions/tree/v1/setup-bioc) - Given a version of Bioconductor, this action installs the appropriate version of R and initialises the [BiocManager](https://cran.r-project.org/package=BiocManager) package.
- [bioc-actions/build-install-check](https://github.com/grimbough/bioc-actions/tree/v1/build-install-check) - Build, install, and check a package emulating the process used by the Bioconductor Build System.
- [bioc-actions/run-BiocCheck](https://github.com/grimbough/bioc-actions/tree/v1/run-BiocCheck) - Runs `BiocCheck::BiocCheck()` on a given package directory.
- [bioc-actions/use-bioc-caches](https://github.com/grimbough/bioc-actions/tree/v1/use-bioc-caches) - Create and use a directory for caching files downloaded by Bioconductor packages between workflow runs.

## Examples

Example workflows for using these actions on both a package repository and a repository where a package is stored in a subdirectory can be found in the [biocActionsExamples](https://github.com/grimbough/biocActionsExamples) repository.
