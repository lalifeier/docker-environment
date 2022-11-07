#!/bin/sh

# 构建开源版
$ go build -tags "oss nolimit" github.com/drone/drone/cmd/drone-server

# 构建企业版
$ go build -tags "nolimit" github.com/drone/drone/cmd/drone-server
