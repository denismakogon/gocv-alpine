FROM denismakogon/gocv-alpine:3.4.1-buildstage as build-stage

RUN go get -u -d gocv.io/x/gocv
RUN cd $GOPATH/src/gocv.io/x/gocv && go build -o $GOPATH/bin/gocv-version ./cmd/version/main.go

FROM denismakogon/gocv-alpine:3.4.1-runtime

COPY --from=build-stage /go/bin/gocv-version /gocv-version
ENTRYPOINT ["/gocv-version"]
