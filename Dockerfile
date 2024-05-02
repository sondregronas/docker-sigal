FROM nginx:stable

ENV LANG C.UTF-8
ENV GALLERY_TITLE="Gallery"

WORKDIR /opt

RUN apt-get update && apt-get install -y \
    cron python3.10 python3-pip ffmpeg \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install setuptools wheel sigal
RUN crontab -l | { cat; echo "3,33 7,8,9,10,11,12,13,14,15,16,17,18 * * * cd /opt && /usr/local/bin/sigal build -n 1 --title \"\$GALLERY_TITLE\""; } | crontab -

COPY run.sh sigal.conf.py auth.conf auth.htpasswd ./
COPY themes/ /usr/local/lib/python3.9/dist-packages/sigal/themes/

CMD ["sh", "run.sh"]
