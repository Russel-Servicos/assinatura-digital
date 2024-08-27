vg-up:
	@vagrant up

vg-ssh:
	@vagrant ssh

vg-halt:
	@vagrant halt

init-container:
	@docker container run -d -v $$(pwd):/app -w /app --name assinatura -p 24066:24066 python:3.11.1-bullseye bash -c "bash ./config-container.sh && python main.py"

logs-container:
	@docker container logs -f assinatura

remove-container:
	@docker container rm -f assinatura
