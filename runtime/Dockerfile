FROM alpine:edge

LABEL maintainer="Denis Makogon. mail: lildee1991@gmail.com"

RUN apk update && apk upgrade \
  && apk add libstdc++ ca-certificates wget

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/glibc-2.27-r0.apk && apk add glibc-2.27-r0.apk

RUN rm -rf /var/cache/apk/*
