FROM debian:bullseye-20230109
ARG SOURCE_DATE_EPOCH
RUN touch /hello
RUN echo "hello ${SOURCE_DATE_EPOCH}" >/hello
