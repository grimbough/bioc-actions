# Run BiocCheck

GitHub Action to test an R package using [BiocCheck](https://bioconductor.org/packages/BiocCheck/).

The Bioconductor project has some extra checks in addition to the usual `R CMD check` that must be passed as part of the package submission process.  This action allows the `BiocCheck()` function to be deployed on a specified package folder.

## Inputs

- `package-directory`: (*Optional*) Specify the location of the package to check if it is not in the working directory.
- `error-on`: (*Optional*) Specify the conditions under which the action will report a failure.  Can be set to one of: `error`, `warning`, `note`, or `never`.  The first three options will cause the action to return a failure if `BiocCheck()` reports one or more issues of the corresponding severity.  The option `never` will allow the action complete successfully whatever `BiocCheck()` reports.  The default value if this argument is not specified is `error`.
- `arguments`: (*Optional*) Arguments that should be passed to `BiocCheck()` to disable specific tests.  These should be provided as they were command line arguments, with multiple options separated by a space e.g. '`--no-check-bioc-views --no-check-bioc-help`'. See the [BiocCheck vignette](https://bioconductor.org/packages/release/bioc/vignettes/BiocCheck/inst/doc/BiocCheck.html#using-bioccheck) for all possible options.

## Example usage

This action assumes you have R installed on the runner.  This is true by default all Github hosted runners.  Alternatively [bioc-actions/setup-bioc](https://github.com/grimbough/bioc-actions/tree/v1/setup-bioc) or [r-lib/actions/setup-r](https://github.com/r-lib/actions/tree/v2/setup-r) could be used to install a specific version.

```yaml
- name: Run BiocCheck
  uses: grimbough/bioc-actions/run-BiocCheck@v1
  with:
    working-directory: examplePKG
    error-on: 'never'
    arguments: '--no-check-bioc-views --no-check-bioc-help'
```
