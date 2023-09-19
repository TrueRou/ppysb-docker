# Bancho.py + guccho w/ Nginx, MySQL, and Redis services
### Python/Flask with Nginx proxy and MySQL database

Project structure:
```
.
├── .env.sample
├── .env (you have  configure this yourself)
├── compose.yaml
├── app
│   ├── bancho.py
│   │   └── *
│   ├── guccho
│   │   └── *
│   └── Dockerfile
├── mysql
│   ├── init
│   │   └── *.sql
│   └── Dockerfile
└── nginx
    ├── nginx.conf
    └── Dockerfile
```

The compose file defines an application with three services `proxy`, `backend` and `db`.
When deploying the application, docker compose maps port 80 of the proxy service container to port 80 of the host as specified in the file.
Make sure port 80 on the host is not already being in use.

> ℹ️ **_INFO_**  
> For compatibility purpose between `AMD64` and `ARM64` architecture, we use a MariaDB as database instead of MySQL.  
> You still can use the MySQL image by uncommenting the following line in the Compose file   
> `#image: mysql:8`

## Deploy with docker compose

```
$ docker compose up -d
```

Stop and remove the containers
```
$ docker compose down
```

Deploy with no cache
```
$ docker compose build --no-cache
$ docker compose up -d
```

## Use with Docker Development Environments

Attach to container which running in dev mode

## Hint about running with Docker Desktop in some network situation

Due to the difficulty when configuring proxy in Wsl, we suggest you not to use Wsl2 based engine.

Global proxy of windows will automatically configured if docker desktop is running in legacy mode.

## How to connect to bancho.py

1. Import the certificate (cert.crt) as trusted root certificate.
2. Attach to the container of bancho.py.
3. Terminal: $ python3.11 main.py
4. Run osu!client with "-devserver dev.ppy.sb" (dev.ppy.sb will resolve to localhost)

## How to apply to the newest repository

- cp bancho.py/migrations/base.sql ppysb-docker/mysql/init/base.sql
- cp bancho.py/manual.env.example ppysb-docker/app/.env
- cp gulag/config.sample.py ppysb-docker/app/guweb/config.py
- cp gulag/config.sample.js ppysb-docker/app/guweb/config.js
- cp guccho/.env.example ppysb-docker/guccho/.env

