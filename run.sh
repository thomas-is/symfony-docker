#!/bin/bash

docker build -t symfony . || exit 1

docker run --rm -it \
  -v $(pwd)/srv:/srv \
  symfony sh -l
