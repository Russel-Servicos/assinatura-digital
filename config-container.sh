#!/bin/bash

apt update -y && 
apt install -y curl net-tools && 
pip install -r requirements.txt &&
apt install -y libqt5webkit5-dev libqt5xmlpatterns5-dev libqt5svg5-dev && 
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb && 
dpkg -i wkhtmltox_0.12.6.1-2.bullseye_amd64.deb ; 
apt --fix-broken install -y && 
dpkg -i wkhtmltox_0.12.6.1-2.bullseye_amd64.deb