deploy: compact upload-hosting

compact:
	@tar -czvf assinatura.tar.gz package* public index.js pm2.json Makefile

upload-hosting:
	@rsync -vah --progress ./assinatura.tar.gz root@vps50657.publiccloud.com.br:/apps/

ssh-hosting:
	@ssh root@vps50657.publiccloud.com.br

vg-up:
	@vagrant up

vg-ssh:
	@vagrant ssh

vg-halt:
	@vagrant halt

svr:
	@flask --app main run -h "0.0.0.0" -p 24066 --debugger --reload

dck-start:
	@docker compose build --no-cache
	@docker compose up -d

dck-open:
	@docker compose exec -it assinatura bash

dck-reset-and-up:
	@echo "===== REMOVE TODOS OS CONTAINERS"
	@docker container rm -f $$(docker container ls -a -q) 
	@echo "===== BUILDA"
	@HOST_UID=$$(id -u) HOST_GID=$$(id -g) docker compose build --no-cache
	@echo "===== EXECUTA CONTAINERS"
	@docker compose up -d

dck-build-up:
	@echo "===== BUILDA"
	@HOST_UID=$$(id -u) HOST_GID=$$(id -g) docker compose build --no-cache
	@echo "===== EXECUTA CONTAINERS"
	@docker compose up -d

pm2-start:
	@pm2 start pm2.json

pm2-logs:
	@pm2 logs assinatura

pm2-del:
	@pm2 del assinatura

pm2-reload:
	@pm2 reload assinatura

pm2-down-up: pm2-del pm2-start
