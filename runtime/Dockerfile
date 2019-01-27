FROM denismakogon/gocv-alpine:4.0.1-buildstage as build-stage
FROM denismakogon/ffmpeg-alpine:4.0

LABEL maintainer="Denis Makogon. mail: lildee1991@gmail.com"

# OpenCV 4.0.1 shared objects from build-stage
COPY --from=build-stage /usr/local/lib64 /usr/local/lib64
COPY --from=build-stage /usr/local/lib64/pkgconfig/opencv4.pc /usr/local/lib64/pkgconfig/opencv4.pc
COPY --from=build-stage /usr/local/include/opencv4/opencv2 /usr/local/include/opencv4/opencv2

ENV PKG="libstdc++ \
         ca-certificates \
         wget \
         libjpeg-turbo \
         libpng \
         libwebp \
         libwebp-dev \
         tiff \
         jasper-libs \
         libavc1394 \
         jasper-libs \
         openblas \
         libgphoto2 \
         gstreamer \
         gst-plugins-base "

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${PKG} && \
    # The gblic v2.28-r0 doesn't have sgerrand.rsa.pub.
    # Downloading it from previous version.
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk && \
    apk add --no-cache glibc-2.28-r0.apk && \
    rm -fr /glibc-2.28-r0.apk && \
    rm -rf /var/cache/apk/* && \
    apk del wget

ENV PKG_CONFIG_PATH /usr/local/lib64/pkgconfig
ENV LD_LIBRARY_PATH /usr/local/lib64
ENV CGO_CPPFLAGS -I/usr/local/include
ENV CGO_CXXFLAGS "--std=c++1z"
ENV CGO_LDFLAGS "-L/usr/local/lib -lopencv_core -lopencv_face -lopencv_videoio -lopencv_imgproc -lopencv_highgui -lopencv_imgcodecs -lopencv_objdetect -lopencv_features2d -lopencv_video -lopencv_dnn -lopencv_xfeatures2d -lopencv_plot -lopencv_tracking"
