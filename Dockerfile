##
## Build
##

FROM golang:1.16-buster AS build

WORKDIR /app

COPY . .

RUN go mod download


RUN go build -o /go-webserver-kubernetes

##
## Deploy
##

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /go-webserver-kubernetes /go-webserver-kubernetes

USER nonroot:nonroot

ENTRYPOINT ["/go-webserver-kubernetes"]