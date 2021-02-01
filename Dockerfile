FROM golang:alpine AS builder
RUN apk add git
WORKDIR $GOPATH/src/app
RUN go get -v -d 
ADD . .
RUN go run main.go clean build
RUN go get -v -d
WORKDIR $GOPATH/src/abc
RUN go build -o ran
RUN echo "Tip: Copy binary from here: $GOPATH/src/app/build" 

FROM alpine
WORKDIR /app
COPY --from=builder /go/src/app/build/ ./
COPY --from=builder /go/src/abc  . 
ENTRYPOINT ./ran
