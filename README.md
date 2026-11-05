# Discourse Docker Container Image

[![Build Status](https://github.com/wodby/discourse/workflows/Build%20docker%20image/badge.svg)](https://github.com/wodby/discourse/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/discourse.svg)](https://hub.docker.com/r/wodby/discourse)

Ready-to-run [Discourse](https://www.discourse.org/) releases for Kubernetes on [Wodby](https://wodby.com). Each image
holds one Discourse release, built on the official `discourse/base` web-only image of its release line, with its
frontend and compressed assets included. Nginx, Unicorn and Sidekiq run in one container.

## Tags

| Discourse line         | Tags                         | Base image                           |
|------------------------|------------------------------|--------------------------------------|
| 2026.10 (monthly)      | `2026.10`, `latest`          | `discourse/base` web-only            |
| 2026.7 (ESR)           | `2026.7`                     | `discourse/base` web-only, stable    |

Releases are published as `<line>-rN`, such as `2026.10-r0`, with full-version aliases such as `2026.10.0-r0`. Images
are built for `linux/amd64` and `linux/arm64`.

## Plugins and themes

The image runs Discourse as released, including the plugins bundled with it, such as chat, AI, solved, assign,
reactions and voting. Themes and theme components can be installed from the admin panel. Other plugins need a custom
build and are not supported by this image.

## Environment variables

Discourse reads its settings from `DISCOURSE_*` variables, which the container writes to `config/discourse.conf` on
start. The main ones:

| Variable                     | Description                                                       |
|------------------------------|-------------------------------------------------------------------|
| `DISCOURSE_HOSTNAME`         | The site's host name                                              |
| `DISCOURSE_DEVELOPER_EMAILS` | Comma-separated emails that get administrator access on sign-up   |
| `DISCOURSE_DB_HOST`          | PostgreSQL host; `DISCOURSE_DB_PORT`, `_NAME`, `_USERNAME`, `_PASSWORD` |
| `DISCOURSE_REDIS_HOST`       | Redis host; `DISCOURSE_REDIS_PORT`, `DISCOURSE_REDIS_PASSWORD`    |
| `DISCOURSE_SMTP_ADDRESS`     | SMTP host; `DISCOURSE_SMTP_PORT` and other `DISCOURSE_SMTP_*`     |
| `DISCOURSE_FORCE_HTTPS`      | `true` behind an HTTPS gateway                                    |
| `MIGRATE_ON_BOOT`            | Migrate the database on start, `1` by default                     |
| `PRECOMPILE_ON_BOOT`         | Compile the stylesheets and update themes on start, `1` by default |
| `UNICORN_WORKERS`            | Unicorn workers, `3` by default                                   |

PostgreSQL needs the `hstore`, `pg_trgm`, `unaccent` and `vector` extensions.

## Data

`/shared` holds uploads, backups, logs and runtime state. Mount a persistent volume there.

## Actions

Usage:

```shell
make COMMAND [params ...]

commands:
    check-ready [host port max_try wait_seconds delay_seconds]
    check-live [host port max_try wait_seconds delay_seconds]
    backup filepath

default params values:
    host 127.0.0.1
    port 80
    max_try 1
    wait_seconds 1
    delay_seconds 0
```

`backup` writes Discourse's own backup, the database and local uploads in one `tar.gz` file, to `filepath`. Run
`discourse <command>` for Discourse's own command-line tasks.

## Upgrades

Discourse is upgraded by moving to a newer image. Do not install `docker_manager` or upgrade from the admin panel.
