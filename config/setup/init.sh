#!/usr/bin/env bash

DEMO_THEME_URL="https://github.com/zwbetz-gh/vanilla-bootstrap-hugo-theme.git"
DEMO_THEME_LOCATION="vanilla-bootstrap-hugo-theme"
DEMO_THEME_CONFIG="${DEMO_THEME_LOCATION}/exampleSite/config.yaml"

# Init a new hugo site and theme
if [ ! -d site ]; then
  hugo new site site
  cp config/setup/gitignore site/.gitignore

  if [ "$DEMO" = true ]; then
    (
      cd site
      git init
      git submodule add "$DEMO_THEME_URL" themes/"$DEMO_THEME_LOCATION"
      rm config.toml; cp "themes/$DEMO_THEME_CONFIG" ./
    )
  fi
  if [ "$USE_EXTENDED" = true ]; then
    source config/setup/install_deps.sh
  fi
fi