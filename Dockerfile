FROM golang:alpine AS builder
RUN apk add git
WORKDIR $GOPATH/src/app
RUN go get -v -d 
RUN go build -o ran

FROM alpine
WORKDIR /app
COPY --from=builder /go/src/app/build/ ./
ENTRYPOINT ./ran
