# Setup R & Bioconductor

GitHub Action to install the appropriate version of R for a given version of Bioconductor.

## Motivation

Releases of Bioconductor are tied to specific versions of R.  However, because Bioconductors' release cycle is 6 monthly and R's is annual, it can be tricky to keep GitHub Actions Workflows using the appropriate versions.  This action tries to simplify this by automatically installing the correct version of R (and Rtools) for a given Bioconductor version.

The action will also install the `Renviron.bioc` file used by the Bioconductor Build System to enable settings that will cause `R CMD check` to throw an error, but which are not activated by default.  The current version of this file for the devel branch can be found at https://bioconductor.org/checkResults/devel/bioc-LATEST/Renviron.bioc

## Inputs

- `bioc-version`: (**Required**) The version of Bioconductor to use.  Default value is `devel`. This argument will also accept the string `release` as well as specific version numbers e.g. `3.15`.
- `bioc-mirror`: (*Optional*) The mirror to download Bioconductor packages from.  If this option is not supplied then `https://www.bioconductor.org` will be used.

## Example usage

```yaml
- name: Setup R and Bioconductor
  uses: grimbough/bioc-actions/setup-bioc@v1
  with:
    bioc-version: devel
    bioc-mirror: https://ftp.gwdg.de/pub/misc/bioconductor
```
