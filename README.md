# Bancho.py + guccho w/ Nginx, MySQL, and Redis services

## Project structures
```
.
├── .env.example
├── .env (you have to configure this by yourself)
├── compose.yaml
├── bancho.py
│   ├── run-on-start.sh
│   └── Dockerfile
├── mysql
│   ├── init
│   │   └── *.sql
│   └── Dockerfile
└── nginx
    ├── nginx.conf
    ├── cert.pem
    ├── key.pem
    └── Dockerfile
```

When deploying the application, docker compose maps port **80**, **443**, **3307** of the proxy service container to host machine.

Make sure these ports on the host is not already being in use.

> ℹ️ **_INFO_**  
> For Chinese developers under **Windows** and **Docker Desktop** environment, we **STRONGLY** recommended that:
>
> **DO NOT USE WSL2-mode** (WSL2 based engine), WSL2 owns a complex networking strategy, causing it difficult to configuring proxy in some cases.
> 
> **Use legacy mode** (Hyper-V mode), the system proxy will automatically configured and applied to every containers.

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

## How to dive into development

1. Create and edit the .env file, assign the values.
2. If you only focus on backend / frontend dev, edit PROD_MODE in .env in your case.
3. Attach to bancho.py / guccho containers with VSCode `Dev Containers`.

## How to connect to bancho.py

1. Import the certificate (cert.crt) as trusted root certificate.
2. Attach to the container of bancho.py.
3. Terminal: $ python3.11 main.py
4. Run osu!client with "-devserver dev.ppy.sb" (dev.ppy.sb will resolve to localhost)

## Possible problems

- Got an error when pushing to Github: Try to disable `Copy Git Config` in `Dev Containers` plugin

