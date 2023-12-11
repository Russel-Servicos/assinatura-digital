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

# apt --fix-broken install -y && \
# apt install -y libqt5webkit5-dev libqt5xmlpatterns5-dev libqt5svg5-dev && \
# wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb && \
# dpkg -i wkhtmltox_0.12.6.1-2.bullseye_amd64.deb   

CMD tail -f /dev/null

# USER python