#!/usr/bin/make

SHELL = /bin/sh

LOCAL_UID := $(shell id -u)
LOCAL_GID := $(shell id -g)

export LOCAL_UID
export LOCAL_GID

up:

	docker-compose up -d

python:

	docker-compose up --build python
