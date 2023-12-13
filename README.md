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
