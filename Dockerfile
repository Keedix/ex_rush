FROM elixir:1.12.0-alpine AS build

    # install build dependencies
    RUN apk add --no-cache build-base npm git
    RUN node -v
    # prepare build dir
    WORKDIR /app

    # install hex + rebar
    RUN mix local.hex --force && \
        mix local.rebar --force

    # set build ENV
    ENV MIX_ENV=prod

    # install mix dependencies
    COPY mix.exs mix.lock ./
    COPY config config
    RUN mix do deps.get, deps.compile

    # build assets
    COPY assets/package.json assets/package-lock.json ./assets/
    RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

    COPY priv priv
    COPY assets assets
    RUN cd ./assets && npm run --prefix deploy
    RUN mix phx.digest

    # compile and build release
    COPY lib lib
    # uncomment COPY if rel/ exists
    # COPY rel rel
    RUN mix do compile, release

# prepare release image
FROM alpine:3.13 AS app
    ENV LANG=C.UTF-8
    
    # Install openssl
    RUN apk add --no-cache openssl ncurses-libs build-base
    RUN mkdir /target
    WORKDIR /target
    
    # Get ready release from releaser stage
    COPY --from=build /app/_build/prod/rel/ex_rush/ ./ex_rush

    # https://stackoverflow.com/a/49955098
    # Create a group and user to run application no as sudo
    RUN addgroup -S appgroup && adduser -S appuser -G appgroup
    
    RUN chown -R appuser: ./ex_rush
    # Tell docker that all future commands should run as the appuser user
    USER appuser

    # Run start command from release. Other possible commands:
    # https://elixir-lang.org/blog/2019/06/24/elixir-v1-9-0-released/ 
    CMD ["./ex_rush/bin/ex_rush", "start"]