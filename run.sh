#!/bin/sh

# Docker Imageを引数として受け取り
IMAGE_NAME=$1
shift

# Docker Imageが空だとexit
if [ "${IMAGE_NAME}" = "" ]; then
  exit 1
fi

docker run --rm -it \
  -v $(pwd):/usr/local/src/${IMAGE_NAME} \
  -w /usr/local/src/${IMAGE_NAME} \
  --env-file ./envfile.env \
  ${IMAGE_NAME} "$@"