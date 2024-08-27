vg-up:
	@vagrant up

vg-ssh:
	@vagrant ssh

vg-halt:
	@vagrant halt

dck-run:
	@docker container run -d -v $$(pwd):/app -w /app --name assinatura -p 24066:24066 python:3.11.1-bullseye bash -c "bash ./config-container.sh && python main.py"

dck-logs:
	@docker container logs -f assinatura

dck-rm:
	@docker container rm -f assinatura
