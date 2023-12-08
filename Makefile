deploy: compact upload-hosting

compact:
	@tar -czvf assinatura.tar.gz package* public index.js pm2.json Makefile

upload-hosting:
	@rsync -vah --progress ./assinatura.tar.gz root@vps50657.publiccloud.com.br:/apps/

ssh-hosting:
	@ssh root@vps50657.publiccloud.com.br

pm2-start:
	@pm2 start pm2.json

pm2-logs:
	@pm2 logs assinatura

pm2-del:
	@pm2 del assinatura

pm2-reload:
	@pm2 reload assinatura