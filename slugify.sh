#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
  # On MacOS,
  # bash don't support substitution, so we use 'tr'
  KEY=$(echo "$INPUT_KEY" | tr '[:lower:]' '[:upper:]')
  CS_VALUE=${INPUT_VALUE:-${!INPUT_KEY}}
  VALUE=$(echo "$CS_VALUE" | tr '[:upper:]' '[:lower:]')
  PREFIX=$(echo "$INPUT_PREFIX" | tr '[:lower:]' '[:upper:]')
else
  KEY=${INPUT_KEY^^}
  CS_VALUE=${INPUT_VALUE:-${!INPUT_KEY}}
  VALUE=${CS_VALUE,,}
  PREFIX=${INPUT_PREFIX^^}
fi

slug() {
  echo "$1" |
    sed -E 's#refs/[^\/]*/##;s/[^a-zA-Z0-9._]+/-/g;s/-+/-/g;s/^-*//;s/-*$//' |
    cut -c1-63
}

slug_url() {
  echo "$1" |
    sed -E 's#refs/[^\/]*/##;s/[^a-zA-Z0-9_]+/-/g;s/-+/-/g;s/^-*//;s/-*$//' |
    cut -c1-63
}

{
  echo "${PREFIX}${KEY}=${CS_VALUE}"
  echo "${PREFIX}${KEY}_SLUG=$(slug "$VALUE")"
  echo "${PREFIX}${KEY}_SLUG_CS=$(slug "$CS_VALUE")"
  echo "${PREFIX}${KEY}_SLUG_URL=$(slug_url "$VALUE")"
  echo "${PREFIX}${KEY}_SLUG_URL_CS=$(slug_url "$CS_VALUE")"
} >>"$GITHUB_ENV"
