docker_compose = srcs/docker-compose.yml
volume_dir = /home/isidki/data

all: build logs

build:
	sudo mkdir -p $(volume_dir)/mariadb
	sudo mkdir -p $(volume_dir)/wordpress
	docker compose -f $(docker_compose) build
	docker compose -f $(docker_compose) up -d

up:
	docker compose -f $(docker_compose) up -d

down:
	docker stop $(shell docker ps -aq) || true
	docker container prune -f
	docker image prune -af
	docker volume rm $$(docker volume ls -q) || true
	docker network prune -f
	sudo rm -rf $(volume_dir)

logs:
	docker compose -f $(docker_compose) logs -f

re : down all
