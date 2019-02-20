FROM debian:jessie AS build_stage

WORKDIR /
RUN apt update && apt -y --no-install-recommends install \
        automake \
        build-essential \
        ca-certificates \
        git \
        python-pip python-dev \
        python-docutils \
        libc-ares2 \
        libc-ares-dev \
        libev4 \
        libev-dev \
        libevent-2.0-5 \
        libevent-dev \
        libssl1.0.0 \
        libssl-dev \
        libtool \
        pkg-config \
        psmisc

RUN pip install docutils
RUN git clone https://github.com/pgbouncer/pgbouncer.git src

WORKDIR /bin

WORKDIR /src
RUN mkdir /pgbouncer
RUN git submodule init
RUN git submodule update
RUN ./autogen.sh
RUN	./configure --prefix=/pgbouncer --with-libevent=/usr/lib --enable-evdns=no
RUN make
RUN make install
RUN ls -R /pgbouncer

FROM debian:jessie
RUN apt update && apt install libevent-2.0-5 openssl libc-ares2 -y
WORKDIR /
COPY --from=build_stage /pgbouncer /pgbouncer
ADD entrypoint.sh ./
ENTRYPOINT ["./entrypoint.sh"]
