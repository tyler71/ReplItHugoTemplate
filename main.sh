#!/usr/bin/env bash
#title           :HugoTemplate
#description     :Create a site with Hugo and proxy it with Caddy
#author		       :@tyler71
#date            :2020
#version         :v1.1
#==============================================================================

DEMO=true

USE_EXTENDED=false
DEV=true

# Change this if using a custom domain
# URL=https://example.com
URL="https://${REPL_SLUG}.${REPL_OWNER}.repl.co"


source ./config/setup/install_deps.sh
source ./config/setup/init.sh

if [ "$USE_EXTENDED" = true ] \
&& [ -d site ]; then
    cd site
    export PATH="$PATH:$(npm bin)"
    cd -
fi

if [ "$DEV" = true ]; then
  (
    cd site
    hugo serve -w \
      --baseUrl="$URL" \
      --buildDrafts \
      --buildFuture \
      --port=4443 \
      --liveReloadPort=443 \
      --appendPort=false \
      --bind="0.0.0.0"
  )
else
  (
    cd site
    hugo \
      --baseUrl="$URL" \
      --minify
  )
  caddy run --config config/Caddyfile
fi
