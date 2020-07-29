#!/usr/bin/env bash

HUGO_FILE='https://github.com/gohugoio/hugo/releases/download/v0.74.1/hugo_extended_0.74.1_Linux-64bit.tar.gz'
CADDY_FILE='https://github.com/caddyserver/caddy/releases/download/v2.1.1/caddy_2.1.1_linux_amd64.tar.gz'

BIN_DIR="/home/runner/.apt/usr/bin"

if ! command -v hugo &> /dev/null; then
  (
    echo Installing hugo
    mkdir -p "$BIN_DIR"
    cd "$BIN_DIR"
    wget --quiet "$HUGO_FILE" -O - | tar -zxf - hugo
  ) &
fi

if ! command -v caddy &> /dev/null; then
  (
    echo Installing caddy
    mkdir -p "$BIN_DIR"
    cd "$BIN_DIR"
    wget --quiet "$CADDY_FILE" -O - | tar -zxf - caddy
  ) &
fi

if [ "$USE_EXTENDED" = true ] \
&& ! command -v postcss &> /dev/null \
&& [ -d site ]; then
  (
    echo Installing node modules
    cd site \
    && npm install postcss-cli 
  ) &
fi

wait