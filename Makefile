deploy: compact upload-hosting

compact:
	@tar -czvf assinatura.tar.gz requirements.txt main.py templates Makefile README.md pm2.json config.sh

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
	@python main.py

venv-config:
	@python -m venv env_assinatura

venv-act:
	@source env_assinatura/bin/activate

# svr:
# 	@flask --app main run -h "0.0.0.0" -p 24066 --debugger --reload

dck-start:
	@docker compose build --no-cache
	@docker compose up -d

dck-run:
	@docker container run -it -d -v $(pwd):/app -w /app --name assinatura -p 24066:24066 python:3.11.1-bullseye bash

dck-config:
	@docker container exec -it assinatura "bash /config.sh"

pm2-start:
	@pm2 start pm2.json

pm2-logs:
	@pm2 logs assinatura

pm2-del:
	@pm2 del assinatura

pm2-reload:
	@pm2 reload assinatura

pm2-down-up: pm2-del pm2-start
