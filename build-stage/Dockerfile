FROM golang:1.20.4-alpine3.18

LABEL maintainer="Denis Makogon. mail: lildee1991@gmail.com"
LABEL maintainer="Mahdi Imani. <imani.mahdi@gmail.com>"

ENV FFMPEG_VERSION=4.2.9

ENV FFMPEG_CORE="bash \
                 tzdata \
                 libass \
                 libstdc++ \
                 libpng \
                 libjpeg \
                 xvidcore \
                 x264-libs \
                 x265 \
                 libvpx \
                 libvorbis \
                 opus \
                 lame \
                 fdk-aac \
                 freetype \
                 libressl \
                 jasper-libs \
                 libavc1394 \
                 yasm"

ENV RUNTIME_DEPS="coreutils \
                  make \
                  cmake \
                  gcc \
                  g++ \
                  clang \
                  linux-headers \
                  git \
                  curl"

ENV BUILD_DEPS="fdk-aac-dev \
                freetype-dev \
                x264-dev \
                x265-dev \
                yasm-dev \
                libogg-dev \
                libvorbis-dev \
                opus-dev \
                libvpx-dev \
                lame-dev \
                xvidcore-dev \
                libass-dev \
                libressl-dev \
                musl-dev \
                build-base \
                libjpeg-turbo-dev \
                libpng-dev \
                jasper-dev \
                libavc1394-dev \
                libavc1394-dev \
                clang-dev"

# FFMPEG
RUN apk update && \
    apk add --no-cache apk-tools && \
    echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache --virtual .runtime-deps ${RUNTIME_DEPS} && \
    apk add --no-cache ${FFMPEG_CORE} && \
    apk add --no-cache --virtual .build-deps ${BUILD_DEPS} && \
    export SRC=/usr \
	DIR=$(mktemp -d) && cd ${DIR} && \
	curl -Os http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz && \
	tar xzvf ffmpeg-${FFMPEG_VERSION}.tar.gz && \
	cd ffmpeg-${FFMPEG_VERSION} && \
	./configure \
        --prefix="${SRC}" \
        --extra-cflags="-I${SRC}/include" \
        --extra-ldflags="-L${SRC}/lib" \
        --bindir="${SRC}/bin" \
        --extra-libs=-ldl \
        --enable-version3 \
        --enable-libmp3lame \
        --enable-pthreads \
        --enable-libx264 \
        --enable-libxvid \
        --enable-gpl \
        --enable-postproc \
        --enable-nonfree \
        --enable-avresample \
        --enable-libfdk-aac \
        --disable-debug \
        --enable-small \
        --enable-libtls \
        --enable-libx265 \
        --enable-libopus \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libfreetype \
        --enable-libass \
        --enable-shared \
        --enable-pic && \
    make && \
    make install && \
    make distclean && \
	hash -r && \
	cd /tmp && \
	rm -rf ${DIR} && \
	apk del .build-deps && \
	apk del .runtime-deps && \
    rm -rf /var/cache/apk/*


ENV OPENCV_VERSION=4.7.0
ENV BUILD="ca-certificates \
         git \
         build-base \
         musl-dev \
         alpine-sdk \
         make \
         gcc \
         g++ \
         libc-dev \
         linux-headers \
         libjpeg-turbo \
         libpng \
         libwebp \
         libwebp-dev \
         tiff \
         libavc1394 \
         jasper-libs \
         openblas \
         libgphoto2 \
         gstreamer \
         gst-plugins-base"

ENV DEV="clang clang-dev cmake pkgconf \
         openblas-dev gstreamer-dev gst-plugins-base-dev \
         libgphoto2-dev libjpeg-turbo-dev libpng-dev \
         tiff-dev jasper-dev libavc1394-dev"


RUN apk update && \
    apk add --no-cache ${BUILD} ${DEV}

RUN mkdir /tmp/opencv && \
    cd /tmp/opencv && \
    wget -O opencv.zip https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
    unzip opencv.zip && \
    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip && \
    unzip opencv_contrib.zip && \
    mkdir /tmp/opencv/opencv-${OPENCV_VERSION}/build && cd /tmp/opencv/opencv-${OPENCV_VERSION}/build && \
    cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv/opencv_contrib-${OPENCV_VERSION}/modules \
    -D WITH_FFMPEG=YES \
    -D INSTALL_C_EXAMPLES=NO \
    -D INSTALL_PYTHON_EXAMPLES=NO \
    -D BUILD_ANDROID_EXAMPLES=NO \
    -D BUILD_DOCS=NO \
    -D BUILD_TESTS=NO \
    -D BUILD_PERF_TESTS=NO \
    -D BUILD_EXAMPLES=NO \
    -D BUILD_opencv_java=NO \
    -D BUILD_opencv_python=NO \
    -D BUILD_opencv_python2=NO \
    -D BUILD_opencv_python3=NO \
    -D OPENCV_GENERATE_PKGCONFIG=YES .. && \
    make -j4 && \
    make install && \
    cd && rm -rf /tmp/opencv

RUN apk del ${DEV_DEPS} && \
    rm -rf /var/cache/apk/*

ENV PKG_CONFIG_PATH /usr/local/lib64/pkgconfig
ENV LD_LIBRARY_PATH /usr/local/lib64
ENV CGO_CPPFLAGS -I/usr/local/include
ENV CGO_CXXFLAGS "--std=c++1z"
ENV CGO_LDFLAGS "-L/usr/local/lib -lopencv_core -lopencv_face -lopencv_videoio -lopencv_imgproc -lopencv_highgui -lopencv_imgcodecs -lopencv_objdetect -lopencv_features2d -lopencv_video -lopencv_dnn -lopencv_xfeatures2d -lopencv_plot -lopencv_tracking"
