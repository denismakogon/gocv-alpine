FROM golang:1.10-alpine3.7 as build-stage

LABEL maintainer="Denis Makogon. mail: lildee1991@gmail.com"

ENV PKG="ca-certificates \
        git \
        build-base \
        musl-dev \
        alpine-sdk \
        cmake \
        clang \
        clang-dev \
        make \
        gcc \
        g++ \
        libc-dev \
        linux-headers \
        ffmpeg-libs \
        ffmpeg-dev \
        libavc1394 \
        libavc1394-dev \
        gstreamer \
        gstreamer-dev \
        gst-plugins-base \
        gst-plugins-base-dev \
        libgphoto2 \
        libgphoto2-dev"

RUN apk add --no-cache ${PKG}

RUN mkdir /tmp/opencv
WORKDIR /tmp/opencv
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.1.zip && \
    unzip opencv.zip && \
    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.1.zip && \
    unzip opencv_contrib.zip && \
    mkdir /tmp/opencv/opencv-3.4.1/build

WORKDIR /tmp/opencv/opencv-3.4.1/build
RUN cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv/opencv_contrib-3.4.1/modules \
    -D BUILD_DOCS=OFF BUILD_EXAMPLES=OFF \
    -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF \
    -D INSTALL_PYTHON_EXAMPLES=NO \
    -D INSTALL_C_EXAMPLES=NO \
    # Support
    -D WITH_IPP=NO \
    -D WITH_1394=NO \
    -D WITH_LIBV4L=NO \
    -D WITH_V4l=YES \
    -D WITH_TBB=YES \
    -D WITH_FFMPEG=YES \
    -D WITH_GPHOTO2=YES \
    -D WITH_GSTREAMER=YES \
    -D BUILD_opencv_java=OFF \
    -D BUILD_opencv_python=OFF \
    -D BUILD_opencv_python2=OFF \
    -D BUILD_opencv_python3=OFF .. && \
    make -j4 && \
    make install && \
    rm -rf /tmp/opencv
RUN apk del --purge build-base clang clang-dev cmake pkgconf wget openblas-dev \
                    openexr-dev gstreamer-dev gst-plugins-base-dev libgphoto2-dev \
                    libtbb-dev libjpeg-turbo-dev libpng-dev tiff-dev jasper-dev \
                    ffmpeg-dev libavc1394-dev py-numpy-dev; \
    rm -vrf /var/cache/apk/*

ENV PKG_CONFIG_PATH /usr/local/lib64/pkgconfig
ENV LD_LIBRARY_PATH /usr/local/lib64
ENV CGO_CPPFLAGS -I/usr/local/include
ENV CGO_CXXFLAGS "--std=c++1z"
ENV CGO_LDFLAGS "-L/usr/local/lib -lopencv_core -lopencv_face -lopencv_videoio -lopencv_imgproc -lopencv_highgui -lopencv_imgcodecs -lopencv_objdetect -lopencv_features2d -lopencv_video -lopencv_dnn -lopencv_xfeatures2d -lopencv_plot -lopencv_tracking"
