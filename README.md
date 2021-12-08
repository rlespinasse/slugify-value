# Slugify

> Github Action to slugify a value

Produce some `slug`-ed environment variables based on the input one.

- `<env name>_SLUG`

  - put the variable content in lower case
  - replace any character by `-` except `0-9`, `a-z`, `.`, and `_`
  - remove leading and trailing `-` character
  - limit the string size to 63 characters

- `<env name>_SLUG_CS`

  - like `<env name>_SLUG` but the content is not put in lower case

- `<env name>_SLUG_URL` (or `<env name>_SLUG_URL_CS`)

  - like `<env name>_SLUG` (or `<env name>_SLUG_CS`) with the `.` character also replaced by `-`

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
