ARG APP_PATH=/app
ARG APP_NANE=hello

FROM golang:alpine AS build

ENV CGO_ENABLED 0 \
    GOOS linux \
    GOPROXY https://goproxy.cn,direct

ARG APP_PATH
ARG APP_NANE
WORKDIR $APP_PATH

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -ldflags="-s -w" -o $APP_PATH/$APP_NANE ./main.go

FROM alpine

RUN apk update --no-cache && apk add --no-cache ca-certificates tzdata

ARG APP_PATH
ARG APP_NANE
WORKDIR $APP_PATH

COPY --from=build $APP_PATH/$APP_NANE $APP_PATH/$APP_NANE

CMD ["sh", "-c", "${APP_NANE}"]
