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

MAX_LENGTH=""
if [ -z "${INPUT_SLUG_MAXLENGTH}" ]; then
  echo "::error ::slug-maxlength cannot be empty"
  exit 1
elif [ "${INPUT_SLUG_MAXLENGTH}" -eq "${INPUT_SLUG_MAXLENGTH}" ] 2>/dev/null; then
  MAX_LENGTH="${INPUT_SLUG_MAXLENGTH}"
elif [ "${INPUT_SLUG_MAXLENGTH}" == "nolimit" ]; then
  MAX_LENGTH="${INPUT_SLUG_MAXLENGTH}"
else
  echo "::error ::slug-maxlength must be a number or equals to 'nolimit'"
  exit 1
fi

slug() {
  output=$(sed -E 's#refs/[^\/]*/##;s/[^a-zA-Z0-9._-]+/-/g;s/-+/-/g;s/^-*//;s/-*$//' <<<"$1")
  reduce "$output"
}

slug_url() {
  output=$(sed -E 's#refs/[^\/]*/##;s/[^a-zA-Z0-9-]+/-/g;s/-+/-/g;s/^-*//;s/-*$//' <<<"$1")
  reduce "$output"
}

reduce() {
  if [ "${MAX_LENGTH}" == "nolimit" ]; then
    echo "$1"
  else
    cut -c1-"${MAX_LENGTH}" <<<"$1"
  fi
}

{
  echo "${PREFIX}${KEY}=${CS_VALUE}"
  echo "${PREFIX}${KEY}_SLUG=$(slug "$VALUE")"
  echo "${PREFIX}${KEY}_SLUG_CS=$(slug "$CS_VALUE")"
  echo "${PREFIX}${KEY}_SLUG_URL=$(slug_url "$VALUE")"
  echo "${PREFIX}${KEY}_SLUG_URL_CS=$(slug_url "$CS_VALUE")"
} >>"$GITHUB_ENV"
