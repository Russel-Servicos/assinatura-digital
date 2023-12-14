deploy: compact upload-hosting

compact:
	@tar -czvf assinatura.tar.gz requirements.txt main.py templates Makefile README.md pm2.json *.sh assinatura-digital.service

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
	@docker container run -d -v /apps/assinatura_digital:/app -w /app --name assinatura -p 24066:24066 python:3.11.1-bullseye bash -c "bash ./config-container.sh && python main.py"

dck-logs:
	@docker container logs -f assinatura

dck-rm:
	@docker container rm -f assinatura

# pm2-start:
# 	@pm2 start pm2.json

# pm2-logs:
# 	@pm2 logs assinatura

# pm2-del:
# 	@pm2 del assinatura

# pm2-reload:
# 	@pm2 reload assinatura

# pm2-down-up: pm2-del pm2-start
