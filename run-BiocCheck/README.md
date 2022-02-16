# Run BiocCheck

GitHub Action to test an R package using [BiocCheck](https://bioconductor.org/packages/BiocCheck/).

The Bioconductor project has some extra checks in addition to the usual `R CMD check` that must be passed as part of the package submission process.  This action allows the `BiocCheck()` function to be deployed on a specified package folder.

## Inputs

- `working-directory`: (*Optional*) Specify the location of the package to check if it is not in the working directory.
- `error-on`: (*Optional*) Specify the conditions under which the action will report a failure.  Can be set to on of: `error`, `warning`, `note`, or `never`.  The first three options will cause the action to return a failure if `BiocCheck()` reports one or more issues of the corresponding severity.  The option `never` will allow the action complete succesfully whatever `BiocCheck()` reports.  The default value if this argument is not specified is `error`.
- `arguments`: (*Optional*) Arguments that should be passed to `BiocCheck()` to disable specific tests.  These should be provided as they were command line arguments, with multiple options seperated by a space e.g. '--no-check-bioc-views --no-check-bioc-help'. See the [BiocCheck vignette](https://bioconductor.org/packages/release/bioc/vignettes/BiocCheck/inst/doc/BiocCheck.html#using-bioccheck) for all possible options.

## Example usage

```yaml
- name: Run BiocCheck
  uses: grimbough/bioc-actions/run-bioc-check@v0
  with:
    working-directory: examplePKG
    error-on: 'never'
    arguments: '--no-check-bioc-views --no-check-bioc-help'
```
