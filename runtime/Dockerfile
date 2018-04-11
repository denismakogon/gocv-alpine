FROM denismakogon/gocv-build-stage:edge as build-stage
FROM alpine:edge

LABEL maintainer="Denis Makogon. mail: lildee1991@gmail.com"

# OpenCV 3.4.1 shared objects from build-stage
COPY --from=build-stage /usr/local/lib /usr/local/lib
COPY --from=build-stage /usr/local/lib64 /usr/local/lib64
COPY --from=build-stage /usr/local/lib64/pkgconfig /usr/local/lib64/pkgconfig
COPY --from=build-stage /usr/local/include/opencv /usr/local/include/opencv
COPY --from=build-stage /usr/local/include/opencv2 /usr/local/include/opencv2

RUN apk update && \
    apk upgrade && \
    apk add --no-cache libstdc++ ca-certificates wget && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/glibc-2.27-r0.apk && \
    apk add --no-cache  glibc-2.27-r0.apk && \
    rm -fr /glibc-2.27-r0.apk && \
    rm -rf /var/cache/apk/* && \
    apk del wget

ENV PKG_CONFIG_PATH /usr/local/lib64/pkgconfig
ENV LD_LIBRARY_PATH /usr/local/lib64
ENV CGO_CPPFLAGS -I/usr/local/include
ENV CGO_CXXFLAGS "--std=c++1z"
ENV CGO_LDFLAGS "-L/usr/local/lib -lopencv_core -lopencv_face -lopencv_videoio -lopencv_imgproc -lopencv_highgui -lopencv_imgcodecs -lopencv_objdetect -lopencv_features2d -lopencv_video -lopencv_dnn -lopencv_xfeatures2d -lopencv_plot -lopencv_tracking"
