# Slugify

> Github Action to slugify a value

Produce some `slug`-ed environment variables based on the input one.

- `<env name>_SLUG`

  - put the variable content in lower case
  - replace any character by `-` except `0-9`, `a-z`, `.`, and `_`
  - remove leading `-` character
  - limit the string size to 63 characters
  - remove trailing `-` character

- `<env name>_SLUG_CS`

  - like `<env name>_SLUG` but the content is not put in lower case

- `<env name>_SLUG_URL` (or `<env name>_SLUG_URL_CS`)

  - like `<env name>_SLUG` (or `<env name>_SLUG_CS`) with the `.`, and `_` characters also replaced by `-`

## Usage

- Slugify a value and store it using a key

  ```yaml
  - uses: rlespinasse/slugify-value@v1.x
    with:
      key: KEY_NAME
      value: value_to_slugify
  ```

  Will make available

  - `KEY_NAME`
  - `KEY_NAME_SLUG`
  - `KEY_NAME_SLUG_CS`
  - `KEY_NAME_SLUG_URL`
  - `KEY_NAME_SLUG_URL_CS`

- Slugify the value of an environment variable

  ```yaml
  - uses: rlespinasse/slugify-value@v1.x
    with:
      key: EXISTING_ENV_VAR
  ```

  Will make available

  - `EXISTING_ENV_VAR_SLUG`
  - `EXISTING_ENV_VAR_SLUG_CS`
  - `EXISTING_ENV_VAR_SLUG_URL`
  - `EXISTING_ENV_VAR_SLUG_URL_CS`

- Slugify the value of an environment variable with prefix

  ```yaml
  - uses: rlespinasse/slugify-value@v1.x
    with:
      key: EXISTING_ENV_VAR
      prefix: CI_
  ```

  Will make available

  - `CI_EXISTING_ENV_VAR`
  - `CI_EXISTING_ENV_VAR_SLUG`
  - `CI_EXISTING_ENV_VAR_SLUG_CS`
  - `CI_EXISTING_ENV_VAR_SLUG_URL`
  - `CI_EXISTING_ENV_VAR_SLUG_URL_CS`

- Slugify a value with a different slug length

  ```yaml
  - uses: rlespinasse/slugify-value@v1.x
    with:
      key: EXISTING_ENV_VAR
      slug-maxlength: 80
  ```

  Will produce SLUG variables with a 80-char length

- Slugify a value without length limit

  ```yaml
  - uses: rlespinasse/slugify-value@v1.x
    with:
      key: EXISTING_ENV_VAR
      slug-maxlength: "nolimit"
  ```

  Will produce SLUG variables without limiting the output length

- Slugify a value without publishing the environment variables

  ```yaml
  - uses: rlespinasse/slugify-value@v1.x
    with:
      key: KEY_NAME
      value: value_to_slugify
      publish-env: false
  ```

  Will **not** make available

  - `KEY_NAME`
  - `KEY_NAME_SLUG`
  - `KEY_NAME_SLUG_CS`
  - `KEY_NAME_SLUG_URL`
  - `KEY_NAME_SLUG_URL_CS`

## Inputs

| Input          | Description                                                                                           | Mandatory | Default |
| -------------- | ----------------------------------------------------------------------------------------------------- | --------- | ------- |
| key            | Environment variable that will hold the value and serve as prefix to slugified value                  | Yes       |         |
| value          | The value to slugify. If not set the value will be taken from the `key` input as environment variable | No        |         |
| prefix         | The value will be prepend to each generated variable                                                  | No        |         |
| slug-maxlength | The value is a number or `nolimit` to reflect the length of the slug outputs                          | No        | 63      |
| publish-env    | In addition of the action output, the slug values are publish as environment variables                | No        | true    |

## Outputs

| Output      | Description                     |
| ----------- | ------------------------------- |
| value       | The value to be slugify         |
| slug        | Value Slug                      |
| slug-cs     | Value Slug (Case-sensitive)     |
| slug-url    | Value Slug URL                  |
| slug-url-cs | Value Slug URL (Case-sensitive) |
