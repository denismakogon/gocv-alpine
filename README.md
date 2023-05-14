# GoCV-compatible OpenCV 4.7.0 Alpine 3.18 Docker images

## What's in build-stage image?

 - Alpine 3.18
 - FFMPEG 4.2.9
 - Golang 1.20
 - OpenCV 4.7.0
 - OpenCV 4.7.0 contrib packages required by GoCV

## What's in runtime image?

 - Alpine 3.18
 - Whatever you need there

## Purpose

This is a build image for the multi-stage image provisioning as well as runtime image to work with gocv-based binaries.

## Example

Sample Docker file you can find [here](example/Dockerfile).

## Build the runtime image

```bash
pushd runtime && docker build -t denismakogon/gocv-alpine:4.0.1-runtime .; popd
```

## Build the build-stage image

```bash
pushd build-stage && docker build -t denismakogon/gocv-alpine:4.7.0-buildstage .; popd
```

## Test sample:

```bash
pushd example && docker build -t denismakogon/gocv-alpine:test .; popd
```
```bash
docker run --rm -ti denismakogon/gocv-alpine:test
```

the output should be the following:
```bash
gocv version: 0.18.0
opencv lib version: 4.7.0
```
