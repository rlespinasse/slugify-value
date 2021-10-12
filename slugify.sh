#!/usr/bin/env bash

KEY=${INPUT_KEY^^}
CS_VALUE=${INPUT_VALUE:-${!INPUT_KEY}}
VALUE=${CS_VALUE,,}

slug() {
  echo "$1" |
    sed -r 's#refs/[^\/]*/##;s/[^a-zA-Z0-9._]+/-/g;s/^-*//;s/-*$//' |
    cut -c1-63
}

slug_url() {
  echo "$1" |
    sed -r 's#refs/[^\/]*/##;s/[^a-zA-Z0-9_]+/-/g;s/^-//;s/-$//' |
    cut -c1-63
}

{
  echo "${KEY}=${CS_VALUE}"
  echo "${KEY}_SLUG=$(slug "$VALUE")"
  echo "${KEY}_SLUG_CS=$(slug "$CS_VALUE")"
  echo "${KEY}_SLUG_URL=$(slug_url "$VALUE")"
  echo "${KEY}_SLUG_URL_CS=$(slug_url "$CS_VALUE")"
} >>"$GITHUB_ENV"
