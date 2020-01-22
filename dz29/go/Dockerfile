FROM golang:latest
RUN mkdir /app
WORKDIR /app
COPY myapp.go /app
RUN go build -o main /app/myapp.go
CMD ["/app/main"]


