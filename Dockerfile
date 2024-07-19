FROM golang:1.22-alpine AS build-stage

WORKDIR /usr/src/app

COPY . .

RUN go mod download && go mod verify

RUN go build -v -o /usr/local/bin/app ./...

FROM scratch

COPY --from=build-stage /usr/local/bin/app /usr/local/bin/app

ENTRYPOINT ["/usr/local/bin/app"]