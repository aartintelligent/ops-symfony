# Symfony

---

### Composer usage

```shell
docker run -it --rm \
  --name composer \
  -v $(pwd):/var/www \
  -w /var/www \
  aartintelligent/php:8.3-composer install
```

```shell
docker run -it --rm \
  --name composer \
  -v $(pwd):/var/www \
  -w /var/www \
  aartintelligent/php:8.3-composer update
```

---

### Webpack usage

```shell
docker run -it --rm \
  --name nodejs \
  -v $(pwd):/var/www \
  -w /var/www \
  node:lts-bookworm npm install
```

```shell
docker run -it --rm \
  --name nodejs \
  -v $(pwd):/var/www \
  -w /var/www \
  node:lts-bookworm npm run build
```

```shell
docker run -it --rm \
  --name nodejs \
  -v $(pwd):/var/www \
  -w /var/www \
  node:lts-bookworm npm run dev
```

```shell
docker run -it --rm \
  --name nodejs \
  -v $(pwd):/var/www \
  -w /var/www \
  node:lts-bookworm npm run watch
```

---

### Docker compose

```yaml
services:

  database:
    image: postgres:${POSTGRES_VERSION:-16}-bookworm
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-app}
      POSTGRES_USER: ${POSTGRES_USER:-usr}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-!ChangeMe!}
    volumes:
      - database_data:/var/lib/postgresql/data:rw,delegated
      # if you develop on Linux, you may use a bind-mounted host directory instead
      # - /opt/postgres:/var/lib/postgresql/data:rw,delegated

  webapp:
    build:
      context: .
      target: webapp
    environment:
      PHP_OPCACHE__ENABLE: 0
      PHP_OPCACHE__ENABLE_CLI: 0
      PHP_XDEBUG__MODE: debug
    volumes:
      - ./:/var/www:rw,delegated
    ports:
      - 8080:8080

volumes:
  database_data:
```