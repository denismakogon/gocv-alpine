# ビルド環境で gocv-app をビルドする
FROM denismakogon/gocv-alpine:4.0.1-buildstage as build-stage

RUN mkdir -p $GOPATH/src/github.com/aiinside/gocv-application
COPY ./src $GOPATH/src/github.com/aiinside/gocv-application/src
RUN go build -o $GOPATH/bin/app $GOPATH/src/github.com/aiinside/gocv-application/src/main.go

# 実行環境にビルドした gocv-app をコピーする
FROM denismakogon/gocv-alpine:4.0.1-runtime

COPY --from=build-stage /go/bin/app /app
RUN chmod +x /app
ENTRYPOINT ["/app"]
