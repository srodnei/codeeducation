# syntax=docker/dockerfile:1

##
## Build
##
FROM golang:1.16-buster AS build
ENV GO111MODULE=off
WORKDIR /app

COPY *.go ./

RUN go build -o /codeeducation

##
## Deploy
##
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /codeeducation /codeeducation

EXPOSE 8080
USER nonroot:nonroot

ENTRYPOINT ["/codeeducation"]