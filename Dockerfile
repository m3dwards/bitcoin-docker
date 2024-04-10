FROM debian:bullseye-slim

ARG UID=101
ARG GID=101

RUN groupadd --gid ${GID} bitcoin \
  && useradd --create-home --no-log-init -u ${UID} -g ${GID} bitcoin \
  && echo "deb [check-valid-until=no] http://snapshot.debian.org/archive/debian/20240409T084143Z/ bullseye main" > /etc/apt/sources.list

VOLUME ["/home/bitcoin/.bitcoin"]

EXPOSE 8332 8333 18332 18333 18443 18444 38333 38332

ENTRYPOINT ["/entrypoint.sh"]

# RUN bitcoind -version | grep "Bitcoin Core version v${BITCOIN_VERSION}"

CMD ["bitcoind"]