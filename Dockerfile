FROM nginx:stable

ENV LANG C.UTF-8
ENV GALLERY_TITLE="Gallery"

WORKDIR /opt

RUN apt-get update && apt-get install -y \
    cron wget build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://www.python.org/ftp/python/3.7.16/Python-3.7.16.tar.xz \
    && tar -xf Python-3.7.16.tar.xz \
    && cd Python-3.7.16 \
    && ./configure --with-ensurepip=install \
    && make -j 8 \
    && make altinstall \
    && cd .. \
    && rm -rf Python-3.7.16 Python-3.7.16.tar.xz \
    && ln -s /usr/local/bin/python3.7 /usr/local/bin/python3 \
    && ln -s /usr/local/bin/pip3.7 /usr/local/bin/pip3

RUN pip3 install sigal

RUN "3,33 7,8,9,10,11,12,13,14,15,16,17,18 * * * cd /opt && /usr/local/bin/sigal build" | crontab - && service cron start

COPY run.sh sigal.conf.py auth.conf auth.htpasswd ./

COPY themes /usr/local/lib/python3.7/site-packages/sigal/themes

CMD ["./run.sh"]
