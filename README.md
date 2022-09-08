### Documentation

[Document](https://joaoulian.notion.site/Husky-Challenge-81339c7a1f5a430aaf8374c7bec2ff5d)
[Backend README](https://github.com/joaoulian/husky-challenge/blob/main/api/README.md)
[Frontend README](https://github.com/joaoulian/husky-challenge/blob/main/client/README.md)

### Folder structure

Root structure

```
├── client/                          - frontend code
├── api/                             - backend code
```

## Requirements:

- docker >= 17.12.0+
- docker-compose
- ruby 3.1.2
- node 16.15.1

### How to run

Run in the local machine

```bash
docker-compose up -d
```

Follow "How to run" in the API and Client

## Environments

This Compose file contains the following environment variables:

- `POSTGRES_USER` the default value is **postgres**
- `POSTGRES_PASSWORD` the default value is **changeme**
- `PGADMIN_PORT` the default value is **5050**
- `PGADMIN_DEFAULT_EMAIL` the default value is **pgadmin4@pgadmin.org**
- `PGADMIN_DEFAULT_PASSWORD` the default value is **admin**

## Access backend:

- `localhost:5000`

## Access frontend:

- `localhost:3000`

## Access to postgres:

- `localhost:5432`
- **Username:** postgres (as a default)
- **Password:** changeme (as a default)

## Access to PgAdmin:

- **URL:** `http://localhost:5050`
- **Username:** pgadmin4@pgadmin.org (as a default)
- **Password:** admin (as a default)

## Add a new server in PgAdmin:

- **Host name/address** `postgres`
- **Port** `5432`
- **Username** as `POSTGRES_USER`, by default: `postgres`
- **Password** as `POSTGRES_PASSWORD`, by default `changeme`
