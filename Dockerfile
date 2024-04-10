FROM debian:bullseye-slim

ARG UID=101
ARG GID=101

ARG SNAPSHOT=20240409T084143Z

RUN groupadd --gid ${GID} bitcoin
RUN useradd --create-home --no-log-init -u ${UID} -g ${GID} bitcoin
RUN rm -f /etc/apt/sources.list.d/debian.sources
RUN echo "deb [check-valid-until=no] http://snapshot.debian.org/archive/debian/${SNAPSHOT}/ bullseye main" > /etc/apt/sources.list
RUN echo "deb [check-valid-until=no] http://snapshot.debian.org/archive/debian/${SNAPSHOT}/ bullseye-updates main" >> /etc/apt/sources.list
RUN echo "deb [check-valid-until=no] http://snapshot.debian.org/archive/debian-security/${SNAPSHOT}/ bullseye-security main" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y curl

VOLUME ["/home/bitcoin/.bitcoin"]

EXPOSE 8332 8333 18332 18333 18443 18444 38333 38332

ENTRYPOINT ["/entrypoint.sh"]

# RUN bitcoind -version | grep "Bitcoin Core version v${BITCOIN_VERSION}"

CMD ["bitcoind"]