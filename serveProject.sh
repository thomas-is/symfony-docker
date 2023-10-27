#!/bin/bash

docker build -t symfony . || exit 1

echo "Serving project on http://localhost:8080"
docker run --rm -it \
  -v $(pwd)/srv:/srv \
  -p 8080:80 \
  symfony
