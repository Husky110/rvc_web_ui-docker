# syntax=docker/dockerfile:1

FROM python:3.10-bullseye
ARG REPO="https://github.com/fumiama/Retrieval-based-Voice-Conversion-WebUI"

#RVC itself
EXPOSE 7865

#Tensorboard
EXPOSE 7875

#Filebrowser
EXPOSE 7895

#SSH
EXPOSE 22

RUN git clone $REPO /app

WORKDIR /app

RUN mkdir dataset audios audio-outputs

RUN pip install -r requirements.txt

RUN apt-get update

RUN apt-get install -y ffmpeg supervisor

RUN apt-get install -y openssh-server

RUN pip install ffmpy --upgrade

RUN pip install filebrowser tensorflow

RUN python tools/download_models.py

ENV PUBLIC_KEY=""

COPY /assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir /root/.ssh

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]