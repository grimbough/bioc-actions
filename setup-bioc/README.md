# Setup R & Bioconductor

GitHub Action to install the appropriate version of R for a given version of Bioconductor.

The action will also install the `Renviron.bioc` file used by the Bioconductor Build System to enable settings that will cause `R CMD check` to throw an error that are not activated by default.  The current version of this file for the devel branch can be found at https://bioconductor.org/checkResults/devel/bioc-LATEST/Renviron.bioc

## Inputs

- `bioc-version`: (**Required**) The version of Bioconductor to use.  Default value is `devel`. This argument will also accept the string `release` as well as specific version numbers e.g. `3.15`.
- `bioc-mirror`: (*Optional*) The mirror to download Bioconductor packages from.  If this option is not supplied then `https://www.bioconductor.org` will be used.

## Example usage

```yaml
- name: Setup R and Bioconductor
  uses: grimbough/bioc-actions/setup-bioc@v0
  with:
    bioc-version: devel
    bioc-mirror: https://ftp.gwdg.de/pub/misc/bioconductor
```
