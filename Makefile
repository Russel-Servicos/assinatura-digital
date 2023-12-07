compact:
	@tar -czvf assinatura.tar.gz package* public index.js

upload-hosting: compact
	@rsync -vah --progress ./assinatura.tar.gz root@vps50657.publiccloud.com.br:/apps/

ssh-hosting:
	@ssh root@vps50657.publiccloud.com.br