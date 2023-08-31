FROM golang:alpine AS builder
WORKDIR /workspace/app

ENV CGO_ENABLED 0 \
    GOOS linux \
    GOPROXY https://goproxy.cn,direct

COPY go.mod go.sum ./

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=~/.cache/go-build \
    go mod download

COPY . .

RUN --mount=type=cache,target=/root/.cache/go-build CGO_ENABLED=0 go build -ldflags "-s -w" -o app .

FROM alpine
WORKDIR /workspace/app

RUN apk update --no-cache && apk add --no-cache ca-certificates tzdata

COPY --from=builder /workspace/app/app .

CMD ["sh", "-c", "./app"]




