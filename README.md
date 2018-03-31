# GoCV-compatible OpenCV 3.4 Alpine 3.7 Docker images

## What's in build-stage image?

 - Alpine 3.7
 - Golang 1.10
 - OpenCV 3.4.1
 - OpenCV 3.4.1 contrib packages required by GoCV

## What's in runtime image?

 - Alpine 3.7
 - Whatever you need there

## Purpose

This is a build image for the multi-stage image provisioning as well as runtime image to work with gocv-based binaries.

## Example

Sample Docker file you can find [here](example/Dockerfile).

## Build the runtime image

```bash
pushd runtime && docker build -t denismakogon/gocv-runtime:edge .; popd
```

## Build the build-stage image

```bash
pushd build-stage && docker build -t denismakogon/gocv-build-stage:edge .; popd
```

## Test sample:

```bash
pushd example && docker build -t denismakogon/golang-opencv-alpine:test .;popd
```
