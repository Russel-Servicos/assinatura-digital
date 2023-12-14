#!/bin/bash

docker container rm -f assinatura

docker container run -d -v /apps/assinatura_digital:/app -w /app --name assinatura -p 24066:24066 python:3.11.1-bullseye bash -c "bash ./config-container.sh && python main.py"
