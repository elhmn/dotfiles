## build: build the dev container
.PHONY: build
build:
	docker build .  -t dev-container

## build-nocache: build-nocache the dev container without cache
.PHONY: build-nocache
build-nocache:
	docker build .  -t dev-container --no-cache

## run: run the dev container
.PHONY: run
run:
	docker run --rm -v "$$(echo $$HOME)/local-dev:/home/user/local-dev" -p 80:80 -p 8080:8080 -p 3000-3010:3000-3010 -P -dt dev-container
.DEFAULT_GOAL := help

## exec-nc: exec-nc exec inside a new container
.PHONY: exec-nc
exec-nc: stop run exec

## exec-ni: exec-ni exec inside a container ran from a newly built image
.PHONY: exec-ni
exec-ni: stop build run exec

## exec: exec into the dev container
.PHONY: exec
exec:
	docker exec -it $$(docker ps | grep dev-container | head -n1 | cut -d " " -f 1) /bin/zsh

## stop: stop dev containers
.PHONY: stop
stop:
	-docker rm $$(docker ps | grep dev-container | awk '{print $1}') -f

all: help
.PHONY: help
help: Makefile
	@echo " Choose a command..."
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
