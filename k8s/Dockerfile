FROM postgres:latest
#docker run --name my -e POSTGRES_USER=shard -e POSTGRES_PASSWORD=shard -e POSTGRES_DB=shard -d dimarudik/postgres

RUN apt-get update -y && apt-get -y install curl vim less bsdmainutils binutils
#RUN apt-get -y install --no-install-recommends wget gnupg ca-certificates lsb-release systemctl
#RUN wget -O - https://openresty.org/package/pubkey.gpg | apt-key add -

#RUN echo "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main" > openresty.list
#RUN cp openresty.list /etc/apt/sources.list.d/

#RUN apt-get update -y && apt-get -y install --no-install-recommends openresty luarocks
#RUN systemctl start openresty

#CMD ["openresty", "-g", "daemon off;"]
#CMD ["postgres"]
