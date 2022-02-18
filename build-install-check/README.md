# Install, build, and check like the Bioconductor build system

Run the `R CMD INSTALL`, `R CMD build`, `R CMD check` sequence using the strategy found on the Bioconductor build system.

## Inputs

- `package-directory`: (*Optional*) Path to the package directory with in the repository.  The default value of `.` assumes the package is the git repository. Alternatively you can provide a path if the package is located in a sub-folder.

## Outputs

This action will return the absolute paths to several of the files or folders produced during workflow.  These can then be passed to actions like [`upload-artifact`](https://github.com/actions/upload-artifact) to make the output available for inspection.

- `source-tarball`: The `<pkgname>_x.y.z.tar.gz` file produced by the call the `R CMD build`.
- `check-dir`: The `<pkgname>.Rcheck` folder containing various check logs.  `R CMD check` failures are often accompanied by an instruction to examine one or more files in this directory.

## Example usage

This action assumes you have R installed on the runner (for Windows Rtools).  It is recommended to use [bioc-actions/setup-bioc](https://github.com/grimbough/bioc-actions/tree/v1/setup-bioc) or [r-lib/actions/setup-r](https://github.com/r-lib/actions/tree/v2/setup-r) to install these, although the default installation of R on the Github hosted runners may be sufficient in some circumstances. 

In the simplest case, where the root of the repository of our package folder, we can use the action like this:

```yaml
- name: Build, Install, Check
  uses: grimbough/bioc-actions/build-install-check@v1
```

Here we provide the path to a package in a sub-folder.  We can also give the step an `id` so that the output variables can be referenced by further steps in a larger workflow.

```yaml
- name: Build, Install, Check
  id: build-install-check
  uses: grimbough/bioc-actions/build-install-check@v1
  with:
    package-directory: 'inst/nestedPKG'
```