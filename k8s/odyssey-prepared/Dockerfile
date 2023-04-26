FROM ubuntu:focal

RUN apt-get update -y && apt-get -y install wget gnupg2 lsb-release
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update -y && apt-get -y install git \
    make build-essential postgresql-server-dev-15
RUN cd /tmp && \
    wget https://github.com/Kitware/CMake/releases/download/v3.26.3/cmake-3.26.3.tar.gz && \
    tar -zxvf cmake-3.26.3.tar.gz && cd cmake-3.26.3 && \
    ./bootstrap && \
    make && \
    make install
#RUN unlink /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime
RUN cd /opt && git clone https://github.com/yandex/odyssey.git
WORKDIR /opt/odyssey
RUN make local_build && \
    rm odyssey.conf && \
    wget https://raw.githubusercontent.com/dimarudik/demo/minikube/k8s/odyssey.conf
RUN addgroup odyssey && \
    useradd odyssey -g odyssey && \
    chown -R odyssey: /opt/odyssey
USER odyssey:odyssey

#docker build . -t dimarudik/odyssey
