# syntax=docker/dockerfile:1

##
## Build
##
FROM golang:1.16-buster AS build

ENV GO111MODULE=off
WORKDIR /app

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /codeeducation -ldflags="-w -s" .

##
## Deploy
##

FROM scratch
WORKDIR /
COPY --from=build /codeeducation /codeeducation

ENTRYPOINT ["/codeeducation"]