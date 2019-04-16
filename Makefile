VERSION=$(shell git describe --always --long)
TAG=1.9.0
USER=staeco
IMAGE=$(USER)/pgbouncer:$(TAG)-$(VERSION)

all: docker

docker:
	docker build -t $(IMAGE) .

push:
	docker push $(IMAGE)

clean:
	docker rmi $(IMAGE)
