FROM golang:latest
RUN mkdir /app
WORKDIR /app
COPY myapp.go /app
RUN go get -d -v
ENTRYPOINT ["/app/myapp.go"]


