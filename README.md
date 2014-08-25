## docker-postgresql

Dockerfile for Postgresql

The environment PGDATA defaults to /var/lib/pgsql/9.3/data. Set the PGDATA if you prefer other location by using the -e during docker run.

### Usage:
```bash
docker run -d -p {port}:5432 \
    --name={container_name} \
    -v {path_to_local.conf}:/var/lib/pgsql/9.3/data/local.conf \
    -e PGDATA={path_to_pgdata} {the_image_name}
```
