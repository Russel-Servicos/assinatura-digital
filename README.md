# Assinatura Digital

tar -czvf assinatura.tar.gz requirements.txt main.py templates Makefile

apt install -y libqt5webkit5-dev libqt5xmlpatterns5-dev libqt5svg5-dev && \
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb && \
dpkg -i wkhtmltox_0.12.6.1-2.bullseye_amd64.deb ; && \
apt --fix-broken install -y && \
dpkg -i wkhtmltox_0.12.6.1-2.bullseye_amd64.deb

make pm2-del

make pm2-logs

make pm2-start

## Execução na VPS

systemd
nginx
iptables

- docker container rm -f $(docker container ls -a -q)
- docker container rm -f assinatura
- docker container run -d -v $(pwd):/app -w /app --name assinatura -p 24066:24066 python:3.11.1-bullseye bash -c "./config.sh && python main.py"
- docker container ls -a

joga o script em /usr/local/bin
assinatura-digital.sh (limpa o docker, sobe o docker, baixa e instala as dependencias dentro do container, roda a aplicacao, verificacao de healthcheck, se der falha por mt tempo manda msg no slack)

###

pasta do app assinatura digital é "/apps/assinatura_digital"

mkdir -p /apps/assinatura_digital
chmod +x /apps/assinatura_digital/assinatura-digital.sh
chmod +x /apps/assinatura_digital/assinatura-digital-stop.sh
cp -v /apps/assinatura_digital/assinatura-digital.sh /usr/local/bin
cp -v /apps/assinatura_digital/assinatura-digital-stop.sh /usr/local/bin
cp -v /apps/assinatura_digital/assinatura-digital.service /etc/systemd/system/
systemctl daemon-reload
systemctl status assinatura-digital
systemctl enable assinatura-digital
systemctl start assinatura-digital
systemctl restart assinatura-digital
