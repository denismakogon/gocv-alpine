#!/usr/bin/env bash

pushd build-stage && docker build -t denismakogon/gocv-build-stage:edge .; popd
pushd runtime && docker build -t denismakogon/gocv-runtime:edge .; popd
pushd example && docker build -t denismakogon/golang-opencv-alpine:test .; popd
docker run --rm -ti denismakogon/golang-opencv-alpine:test
docker rmi -f denismakogon/golang-opencv-alpine:test
