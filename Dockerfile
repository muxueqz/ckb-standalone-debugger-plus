FROM muxueqz/ckb-standalone-debugger as orig
FROM ruby:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN gem install rbnacl

COPY --from=orig /opt/debugger/ /opt/debugger
WORKDIR /app
COPY ./ /opt/debugger/

ENTRYPOINT ["/opt/debugger/runner.sh"]

