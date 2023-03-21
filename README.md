This program is used to add the required `.jar` files to a CARDS Docker
image so that it can be _self-contained_ and thus not require
connectivity to remote Maven repositories during startup. This program
should only copy the `.jar` files that are necessary for _running_ CARDS
and not _building_ CARDS thus producing a smaller-sized Docker image
that is less likely to generate false positives during security scans.

Building
--------

```bash
cd sling-org-apache-sling-feature-launcher
mvn clean install
cd ..
docker build -t cards/sling-feature-downloader .
```

Using
-----

1. In your local CARDS repository build a CARDS Docker image.
```bash
mvn clean install -Pdocker
```

2. In this directory, run `run.sh` as follows.
```bash
./run.sh /path/to/cards/local/repository cards.input.docker.image cards.output.docker.image
```
For example,
```bash
./run.sh ~/Documents/cards cards/cards:latest ghcr.io/data-team-uhn/cards:latest
```
