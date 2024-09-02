# Assinatura Digital

> **OS VÍDEOS EXPLICATIVOS ESTÃO NA PASTA `docs`. Configurando e instalando (parte 1); configurando novamente o site que saiu do ar (parte 2)** 

Sobre: esse projeto funciona em abiente muito específico e controlado. É através do docker, python e as libs que consegui construir essa API.

## Como executar?

> Quando executar o comando `vagrant`, deve estar no na pasta onde o Vagrantfile está

- Instala o Vagrant e VirtualBox
- Baixe o Vagrantfile
- Abra o terminal e o arquivo deve está na mesma pasta onde está o Vagrantfile
- Execute `vagrant up`
- acesse `localhost:24066` no navegador

## Como reiniciar o site?

> Quando executar o comando `vagrant`, deve estar no na pasta onde o Vagrantfile está

Ou execute `vagrant destroy` e depois `vagrant up`, só que irá demorar mais para estar pronto. Ou acesse o site e reinicie seguindo os passos:

- `vagrant ssh`
- `docker container start assinatura`

## Como debugar?

- Mostra os logs do container, se deu erro ou não na instalação das dependências, se deu erro ou não ao subir o servidor`: docker container logs -f assinatura`
- Lista os containeres. Verifica se o container está sendo executado (Up), se saiu (Exited) ou se não existe`: docker container ls -a`
- Remove o container`: docker container rm -f assinatura`
- Caso o container esteja com o status 'Stopped' ou 'Exited': `docker container start assinatura`
