# Use Bioconductor Caches

Make use of cached Bioconductor resources between workflow runs.

## Motivation

Several Bioconductor packages (e.g. [ExperimentHub](https://bioconductor.org/packages/ExperimentHu), [AnnotationHub](https://bioconductor.org/packages/AnnotaionHub), [BiocFileCache](https://bioconductor.org/packages/BiocFileCache)) will cache files to save time repeatedly downloading large datasets in vignettes, workflows etc.

This action will initialise a directory under which package specific caches will be created, and sets environment variables that will provide the locations to R sessions used later in a workflow.  It will then use [action/cache](https://github.com/actions/cache) to retain and restore the cache between workflow runs.

Currently supported packages are:
- ExperimentHub
- AnnotationHub
- BiocFileCache
- biomaRt

## Inputs

- `cache-version`: (*Optional*) A version number to be included in the cache key. Default value of `'1'`. This argument can be used to invalidate the existing cache. Pass a new number and a new cache will be used.  
- `cache-directory`: (*Optional*) Path to the location of the cache folders. Use this if you want to control where caches are created on the runner. If left blank the output from `tools::R_user_dir(package = "bioc_cache", which = "cache")` will be used.

## Example usage

This action assumes a version of R (>= 4.0) is installed as well as the **BiocManager** manager package.  It will fail if that is not the case.  Using [bioc-actions/setup-bioc](https://github.com/grimbough/bioc-actions/tree/v1/setup-bioc) will satisfy these conditions.

```yaml
- name: Use Bioc Caches
  uses: grimbough/bioc-actions/use-bioc-caches@v1
  with:
    cache-version: '1'
```
