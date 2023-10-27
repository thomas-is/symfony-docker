#!/bin/bash

docker build -t symfony . || exit 1

docker run --rm -it \
  -v $(pwd)/srv:/srv \
  -w /srv \
  -p 8080:8080 \
  symfony \
  symfony new project
