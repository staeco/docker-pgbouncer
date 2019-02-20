VERSION=$(shell git describe --always --long)
TAG=1.9.0
USER=staeco
NAME=$(USER)/pgbouncer:$(TAG)-$(VERSION)

all: docker

docker:
	docker build -t $(NAME) .

push:
	docker push $(NAME)
