#!/usr/bin/env bash

# Starts the image against PostgreSQL with the vector extension and Redis, as
# the Discourse stack runs it, then checks the site, its assets, the reported
# version and the backup action.

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

network="${NAME}-net"
postgres="${NAME}-postgres"
redis="${NAME}-redis"
shared="${NAME}-shared"
web="${NAME}-web"
job="${NAME}-job"

cleanup() {
    local status=$?
    if [[ "${status}" -ne 0 ]]; then
        docker logs --tail 50 "${web}" 2>&1 || true
    fi
    docker rm -vf "${job}" "${web}" "${postgres}" "${redis}" > /dev/null 2>&1 || true
    docker volume rm -f "${shared}" > /dev/null 2>&1 || true
    docker network rm "${network}" > /dev/null 2>&1 || true
    exit "${status}"
}
trap cleanup EXIT

# Requests from inside the container, as the gateway sends them.
request() {
    docker exec "${web}" curl -sS -H 'Host: discourse.example.com' -H 'X-Forwarded-Proto: https' "${@}"
}

status() {
    request -o /dev/null -w '%{http_code}' "http://localhost$1"
}

expect() {
    local description=$1 actual=$2 expected=$3
    echo -n "${description}... "
    if [[ "${actual}" != *"${expected}"* ]]; then
        echo "Error: expected ${expected}, got: ${actual}"
        exit 1
    fi
    echo "OK"
}

docker network create "${network}" > /dev/null
docker volume create "${shared}" > /dev/null
docker run -d --name "${postgres}" --network "${network}" \
    -e POSTGRES_DB=discourse -e POSTGRES_USER=discourse -e 'POSTGRES_PASSWORD=discourse p@ss/w:rd#1' \
    pgvector/pgvector:pg17 > /dev/null
docker run -d --name "${redis}" --network "${network}" redis:7-alpine > /dev/null
for _ in $(seq 1 60); do
    docker exec "${postgres}" pg_isready -U discourse -d discourse > /dev/null 2>&1 && break
    sleep 2
done
# The Wodby PostgreSQL service creates these for the Discourse stack.
docker exec "${postgres}" psql -U discourse -d discourse -qc \
    'CREATE EXTENSION IF NOT EXISTS hstore; CREATE EXTENSION IF NOT EXISTS pg_trgm; CREATE EXTENSION IF NOT EXISTS unaccent; CREATE EXTENSION IF NOT EXISTS vector;'

env_args=(
    -e DISCOURSE_HOSTNAME=discourse.example.com
    -e DISCOURSE_DEVELOPER_EMAILS=admin@example.com
    -e DISCOURSE_FORCE_HTTPS=true
    -e DISCOURSE_DB_HOST="${postgres}"
    -e DISCOURSE_DB_PORT=5432
    -e DISCOURSE_DB_NAME=discourse
    -e DISCOURSE_DB_USERNAME=discourse
    -e 'DISCOURSE_DB_PASSWORD=discourse p@ss/w:rd#1'
    -e DISCOURSE_REDIS_HOST="${redis}"
    -e DISCOURSE_REDIS_PORT=6379
    -e DISCOURSE_SMTP_ADDRESS=localhost
    -e DISCOURSE_SMTP_PORT=25
)

docker run -d --name "${web}" --network "${network}" "${env_args[@]}" -v "${shared}:/shared" "${IMAGE}" > /dev/null

# The first start migrates the database and compiles the stylesheets.
echo -n "Starting Discourse... "
docker exec "${web}" make check-ready max_try=90 wait_seconds=10 -f /usr/local/bin/actions.mk > /dev/null 2>&1
echo "OK"

expect "Reporting healthy" "$(request http://localhost/srv/status)" "ok"
expect "Serving the home page" "$(status /)" "200"
expect "Reporting the release" "$(request http://localhost/about.json)" "\"version\":\"${DISCOURSE_VER}"

# Until an administrator registers, every page leads to finishing the installation.
expect "Asking to finish the installation" "$(request http://localhost/)" "/finish-installation/register"

stylesheet=$(request http://localhost/ | grep -o -E '/stylesheets/[^"]+\.css[^"]*' | head -n 1)
expect "Serving stylesheets compiled on start" "$(status "${stylesheet}")" "200"

# Scripts compiled and compressed into the image.
asset=$(docker exec "${web}" sh -c 'ls /var/www/discourse/public/assets | grep -E "^message-bus-[0-9a-f]+\.js$" | head -n 1')
if [[ -z "${asset}" ]]; then
    echo "Error: the image has no compiled scripts"
    exit 1
fi
expect "Serving compiled scripts" "$(status "/assets/${asset}")" "200"
expect "Serving compressed scripts" \
    "$(request -o /dev/null -D - -H 'Accept-Encoding: br, gzip' "http://localhost/assets/${asset}" | tr 'A-Z' 'a-z')" "content-encoding: br"

echo -n "Creating a backup... "
docker exec "${web}" make backup filepath=/shared/backups/test.tar.gz -f /usr/local/bin/actions.mk > /dev/null
docker exec "${web}" test -s /shared/backups/test.tar.gz
echo "OK"

# Wodby runs backups and cron jobs as separate containers of the same image, with the command as
# arguments. They must run it and exit, not boot a second Discourse.
echo -n "Creating a backup in a job container... "
docker run -d --name "${job}" --network "${network}" "${env_args[@]}" -v "${shared}:/shared" "${IMAGE}" \
    make -f /usr/local/bin/actions.mk backup filepath=/shared/backups/job.tar.gz > /dev/null
for _ in $(seq 1 60); do
    [[ "$(docker inspect -f '{{.State.Running}}' "${job}")" == false ]] && break
    sleep 5
done
if [[ "$(docker inspect -f '{{.State.Running}} {{.State.ExitCode}}' "${job}")" != "false 0" ]]; then
    echo "Error: the job did not finish in 5 minutes or failed"
    docker logs --tail 20 "${job}"
    exit 1
fi
docker exec "${web}" test -s /shared/backups/job.tar.gz
echo "OK"
