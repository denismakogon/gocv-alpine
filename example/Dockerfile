FROM denismakogon/golang-opencv-alpine:0.0.1 as build-stage

ENV PKG_CONFIG_PATH /usr/local/lib64/pkgconfig
ENV LD_LIBRARY_PATH /usr/local/lib64
ENV CGO_CPPFLAGS -I/usr/local/include
ENV CGO_CXXFLAGS "--std=c++1z"
ENV CGO_LDFLAGS "-L/usr/local/lib -lopencv_core -lopencv_face -lopencv_videoio -lopencv_imgproc -lopencv_highgui -lopencv_imgcodecs -lopencv_objdetect -lopencv_features2d -lopencv_video -lopencv_dnn -lopencv_xfeatures2d -lopencv_plot -lopencv_tracking"

RUN go get -u -d gocv.io/x/gocv
RUN cd $GOPATH/src/gocv.io/x/gocv && go build -o $GOPATH/bin/gocv-version ./cmd/version/main.go

FROM golang:1.10-alpine3.7

RUN apk add --no-cache libstdc++ ca-certificates wget
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/glibc-2.27-r0.apk
RUN apk add glibc-2.27-r0.apk

ENV PKG_CONFIG_PATH /usr/local/lib64/pkgconfig
ENV LD_LIBRARY_PATH /usr/local/lib64
ENV CGO_CPPFLAGS -I/usr/local/include
ENV CGO_CXXFLAGS "--std=c++1z"
ENV CGO_LDFLAGS "-L/usr/local/lib -lopencv_core -lopencv_face -lopencv_videoio -lopencv_imgproc -lopencv_highgui -lopencv_imgcodecs -lopencv_objdetect -lopencv_features2d -lopencv_video -lopencv_dnn -lopencv_xfeatures2d -lopencv_plot -lopencv_tracking"

COPY --from=build-stage /usr/local/lib /usr/local/lib
COPY --from=build-stage /usr/local/lib64 /usr/local/lib64
COPY --from=build-stage /usr/local/lib64/pkgconfig /usr/local/lib64/pkgconfig
COPY --from=build-stage /usr/local/include/opencv /usr/local/include/opencv
COPY --from=build-stage /usr/local/include/opencv2 /usr/local/include/opencv2

COPY --from=build-stage $GOPATH/bin/gocv-version $GOPATH/bin/gocv-version
RUN $GOPATH/bin/gocv-version
