# Assinatura Digital

Sobre: esse projeto funciona em abiente muito específico e controlado. É através do docker, python e as libs que consegui construir essa API.

## Como executar?

- Instala o Vagrant e VirtualBox
- `git clone`
- `cd assinatura-digital`
- `vagrant up`
- `vagrant ssh`
    - `cd /app`
    - `make dck-run`
- acesse `localhost:24066` no navegador

## Como debugar?

- Mostra os logs do container, se deu erro ou não na instalação das dependências, se deu erro ou não ao subir o servidor`: docker container logs -f assinatura`
- Lista os containeres. Verifica se o container está sendo executado (Up), se saiu (Exited) ou se não existe`: docker container ls -a`
- Remove o container`: docker container rm -f assinatura`
- Caso o container esteja com o status 'Stopped' ou 'Exited': `docker container start assinatura`