FROM denismakogon/gocv-build-stage:edge as build-stage

LABEL maintainer="Denis Makogon. mail: lildee1991@gmail.com"

RUN go get -u -d gocv.io/x/gocv
RUN cd $GOPATH/src/gocv.io/x/gocv && go build -o $GOPATH/bin/gocv-version ./cmd/version/main.go

FROM denismakogon/gocv-runtime:edge

COPY --from=build-stage /go/bin/gocv-version /gocv-version
ENTRYPOINT ["/gocv-version"]
