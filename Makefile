NAME=staeco/pgbouncer:1.9.0-v2

all: docker

docker:
	docker build -t $(NAME) .

push:
	docker push $(NAME)
