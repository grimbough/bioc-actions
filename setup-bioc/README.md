# setup-bioc

![Workflow To Test Action](https://github.com/carlosperate/download-file-action/workflows/Workflow%20To%20Test%20Action/badge.svg)

GitHub Action to install the appropriate version of R for a given version of Bioconductor

## Inputs

- `bioc-version`: (**Required**) The version of Bioconductor to use.  Default value is `devel`. This argument will also accept the string `release` as well as specific version numbers e.g. `3.15`.
- `bioc-mirror`: (*Optional*) The mirror to download Bioconductor packages from.  If this option is no supplied then `https://www.bioconductor.org` will be used.

## Example usage

In its simplest form you can you indicate what file to download and use it:

```yaml
- name: Setup R and Bioconductor
  uses: grimbough/bioc-actions/setup-bioc@v0
  with:
    bioc-version: devel
    bioc-mirror: https://ftp.gwdg.de/pub/misc/bioconductor
```
