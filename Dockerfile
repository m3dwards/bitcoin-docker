FROM debian:bullseye-slim
ENV DEBIAN_FRONTEND=noninteractive

ARG UID=101
ARG GID=101

COPY downloader.sh /usr/local/bin/downloader.sh
RUN chmod +x /usr/local/bin/downloader.sh
# RUN downloader.sh https://bitcoincore.org/bin/bitcoin-core-26.0/bitcoin-26.0-x86_64-linux-gnu.tar.gz /tmp/bitcoin.tar.gz 

VOLUME ["/home/bitcoin/.bitcoin"]

EXPOSE 8332 8333 18332 18333 18443 18444 38333 38332

ENTRYPOINT ["/entrypoint.sh"]

# RUN bitcoind -version | grep "Bitcoin Core version v${BITCOIN_VERSION}"

CMD ["bitcoind"]