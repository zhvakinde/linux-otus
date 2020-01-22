FROM golang:onbuild
RUN mkdir /app
WORKDIR /app
COPY myapp.go /app
RUN  go build -o myapp.go
CMD ["/app/myapp.go"]

