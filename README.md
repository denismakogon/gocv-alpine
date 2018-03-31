# GoCV-compatible OpenCV 3.4 Alpine 3.7 Docker image

## What's in it?

 - Alpine 3.7
 - Golang 1.10
 - OpenCV 3.4.1
 - OpenCV 3.4.1 contrib packages required by GoCV

## Purpose

This is a build image for the multi-stage image provisioning

## Example

Sample Docker file you can find [here](example/Dockerfile).

## Build the build-stage image

```bash
docker build -t denismakogon/golang-opencv-alpine:<tag> .
```

## Test sample:

```bash
pushd example && docker build denismakogon/golang-opencv-alpine:test .;popd
```

## TODO
Build custom Golang image with `libstdc++ ca-certificates wget glibc-2.27-r0.apk` packages.
