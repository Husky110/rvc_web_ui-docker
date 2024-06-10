# syntax=docker/dockerfile:1

FROM python:3.10-bullseye
ARG REPO="https://github.com/fumiama/Retrieval-based-Voice-Conversion-WebUI"
ENV PUBLIC_KEY=''

#RVC itself
EXPOSE 7865

#Tensorboard
EXPOSE 7875

#SSH
EXPOSE 22

RUN git clone $REPO /app

WORKDIR /app

RUN mkdir dataset audios audio-outputs

RUN pip3 install -r requirements.txt

RUN apt-get update

RUN apt-get install -y ffmpeg supervisor

RUN pip install ffmpy --upgrade

RUN apt-get install openssh-server -y

RUN mkdir -p ~/.ssh

RUN chmod -R 700 ~/.ssh

RUN python tools/download_models.py

COPY /assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf"]