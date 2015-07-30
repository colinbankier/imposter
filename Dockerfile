FROM trenpixster/elixir:1.0.5

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV MIX_ENV prod
ENV PORT 80

ADD . /usr/src/app
RUN mix local.hex --force
RUN mix do deps.get, compile, compile.protocols

EXPOSE 80

CMD ["mix", "phoenix.server"]
