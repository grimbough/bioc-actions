# Setup R & Bioconductor

GitHub Action to install the appropriate version of R for a given version of Bioconductor.

## Inputs

- `bioc-version`: (**Required**) The version of Bioconductor to use.  Default value is `devel`. This argument will also accept the string `release` as well as specific version numbers e.g. `3.15`.
- `bioc-mirror`: (*Optional*) The mirror to download Bioconductor packages from.  If this option is no supplied then `https://www.bioconductor.org` will be used.

## Example usage

```yaml
- name: Setup R and Bioconductor
  uses: grimbough/bioc-actions/setup-bioc@v0
  with:
    bioc-version: devel
    bioc-mirror: https://ftp.gwdg.de/pub/misc/bioconductor
```
