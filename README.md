## docker-postgresql

Dockerfile for Postgresql

Usage:
docker run -d -p <port>:5432 --name=<container_name> -v <path_to_local.conf>:/var/lib/pgsql/9.3/data/local.conf:ro nusapro/postgresql
