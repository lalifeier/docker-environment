ENV APP_PATH=/app \
    APP_NANE=hello

FROM golang:alpine AS build

ENV CGO_ENABLED 0 \
    GOOS linux \
    GOPROXY https://goproxy.cn,direct

WORKDIR $APP_PATH

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -ldflags="-s -w" -o $APP_PATH/$APP_NANE ./main.go

FROM alpine

RUN apk update --no-cache && apk add --no-cache ca-certificates tzdata

WORKDIR $APP_PATH

COPY --from=build $APP_PATH/$APP_NANE $APP_PATH/$APP_NANE

CMD ["sh", "-c", "${APP_NANE}"]
