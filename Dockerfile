FROM nginx:stable

ENV LANG C.UTF-8
ENV GALLERY_TITLE="Gallery"

WORKDIR /opt

RUN apt-get update && apt-get install -y \
    python3-pip cron \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install sigal

RUN "3,33 7,8,9,10,11,12,13,14,15,16,17,18 * * * cd /opt && /usr/local/bin/sigal build" | crontab - && service cron start

COPY run.sh sigal.conf.py auth.conf auth.htpasswd ./

CMD ["./run.sh"]
