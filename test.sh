#!/usr/bin/env bash

pushd build-stage && docker build -t denismakogon/gocv-alpine:3.4.1-buildstage .; popd
pushd runtime && docker build -t denismakogon/gocv-alpine:3.4.1-runtime .; popd
pushd example && docker build -t denismakogon/gocv-alpine:test .; popd
docker run --rm -ti denismakogon/gocv-alpine:test
docker rmi -f denismakogon/gocv-alpine:test
