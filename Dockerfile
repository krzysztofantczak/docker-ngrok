FROM debian:8

MAINTAINER Yannick Pereira-Reis <yannick.pereira.reis@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV TUNNEL_ADDR :4443
ENV HTTP_ADDR :80
ENV HTTPS_ADDR :443

RUN apt-get update && apt-get install -y --force-yes --no-install-recommends \
        build-essential \
        ca-certificates \
        nano \
        git \
        curl \
        mercurial \
        ssh \
        openssl \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN curl -O https://storage.googleapis.com/golang/go1.7.4.linux-amd64.tar.gz
RUN tar xf go1.7.4.linux-amd64.tar.gz
RUN chown -R root:root ./go
RUN mv go /usr/local/
RUN cp /usr/local/go/bin/* /usr/bin/

RUN git clone https://github.com/inconshreveable/ngrok.git /root/ngrok

RUN mkdir /root/ngrok/certs

ADD ./startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

WORKDIR /root/ngrok

VOLUME /root/ngrok/certs

CMD ["/root/startup.sh"]

EXPOSE 80
EXPOSE 4443
EXPOSE 443
