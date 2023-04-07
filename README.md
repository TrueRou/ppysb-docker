# Bancho.py + guccho w/ Nginx, MySQL, and Redis services
### Python/Flask with Nginx proxy and MySQL database

Project structure:
```
.
├── .env
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

## Use with Docker Development Environments

Attach to container which running in dev mode

