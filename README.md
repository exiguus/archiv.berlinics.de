# Archiv berlinics.de

Archives the current version of berlinics.de.
And create a static site.

Test the static site by build and run a Docker image with nginx.

## Download current version

```bash
make fetch
```

## Create Docker image

```bash
make create
make format
make build -B
make run
```

## Github Pages

Deploy github pages with lfs support need a [github action workflow](.github/workflows/gh-pages.yml).

Manual deploy to github pages:

<https://github.com/exiguus/archiv.berlinics.de/actions/workflows/gh-pages.yml>

## test

test static site:

```bash
make test
```

update `url-list.txt` mock:

```bash
make all
wget --recursive --spider localhost:8080 2>&1 | grep '^--' | awk '{ print $3 }' | sort | uniq > url-list.txt
```

## Prerequisites

- Prettier (https://prettier.io/)
- Git LFS (sudo apt-get install git-lfs)

### LFS

```bash
git lfs track "*.jpg"
git lfs track "*.jpeg"
git lfs track "*.html"
```
