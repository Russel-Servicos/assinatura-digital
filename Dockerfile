FROM python:3.11.1-bullseye

WORKDIR /app

COPY ./requirements.txt /app

ENV USER=python
ARG GID
ARG UID

RUN apt update -y && \
    apt install -y curl net-tools sudo && \
    addgroup --gid $GID $USER && \
    adduser --uid $UID --gid $GID --disabled-password --gecos "" $USER && \
    pip install -r requirements.txt

RUN apt install -y libqt5webkit5-dev libqt5xmlpatterns5-dev libqt5svg5-dev && \
    wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb && \
    dpkg -i wkhtmltox_0.12.6.1-2.bullseye_amd64.deb ; \
    apt --fix-broken install -y && \
    dpkg -i wkhtmltox_0.12.6.1-2.bullseye_amd64.deb

# apt install -y ca-certificates fontconfig libc6 libfreetype6 libjpeg-turbo8 libpng16-16 libssl1.1 libstdc++6 libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base zlib1g 

CMD tail -f /dev/null

USER python