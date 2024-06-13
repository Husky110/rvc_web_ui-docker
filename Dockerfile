# syntax=docker/dockerfile:1

FROM python:3.10-bullseye
ARG REPO="web_ui-fumiama"
ENV BUILDREPO=${REPO}

# Gradio-Standards. DO NOT MODIFY!
ENV GRADIO_SERVER_NAME="0.0.0.0"
ENV GRADIO_SERVER_PORT=7865

#RVC itself
EXPOSE 7865

#Tensorboard
EXPOSE 7875

#Filebrowser
EXPOSE 7895

RUN apt-get update

RUN apt-get install -y ffmpeg supervisor

RUN apt-get install -y php zip unzip

# Install Filegator
RUN cd / && wget https://github.com/filegator/static/raw/master/builds/filegator_latest.zip && unzip filegator_latest.zip && rm /filegator_latest.zip && mv filegator /filemanager

COPY /assets/filegatorusers.json /filemanager/private/users.json

COPY /assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf


RUN case "$BUILDREPO" in \
        web_ui-rvc_boss) \
          git clone https://github.com/RVC-Project/Retrieval-based-Voice-Conversion-WebUI /app && \
          cd /app && mkdir dataset audios audio-outputs && pip install -r requirements.txt && python tools/download_models.py && \
          sed -i 's|command=python3 !!!StartCommand!!!|command=python3 /app/infer-web.py|' /etc/supervisor/conf.d/supervisord.conf \
          ;; \
        web_ui-fumiama) \
          git clone https://github.com/fumiama/Retrieval-based-Voice-Conversion-WebUI /app && \
          cd /app && mkdir dataset audios audio-outputs && pip install -r requirements.txt && python tools/download_models.py && \
          sed -i 's|command=python3 !!!StartCommand!!!|command=python3 /app/infer-web.py|' /etc/supervisor/conf.d/supervisord.conf \
          ;; \
        applio) \
          git clone https://github.com/IAHispano/Applio /app && \
          cd /app && pip install -r requirements.txt && python core.py prerequisites && \
          sed -i 's|command=python3 !!!StartCommand!!!|command=python3 /app/app.py --port 7865|' /etc/supervisor/conf.d/supervisord.conf \
          ;; \
        *) \
          echo "Unknown build-repo: $BUILDREPO"; \
          exit 1; \
          ;; \
    esac

RUN cd /filemanager && rm -rf repository && ln -s /app repository

WORKDIR /app

RUN pip install ffmpy --upgrade

RUN pip install tensorflow

ENV PUBLIC_KEY=""

RUN mkdir /root/.ssh

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]