# Cylc Review

This setup provides Cylc Review running on an Ubuntu image as WSGI service,
reverse proxied through another image running nginx with Alpine too.

Users are able to run suites in the backend container, while following up the
logs using the frontend one.

## Running it

```bash
host$ docker-compose up --build
host$ docker exec -t -i cylcreview_backend_1 /bin/bash
docker$ cylc register five /opt/cylc/etc/examples/tutorial/cycling/five/
docker$ cylc run --no-detach --debug five
```

Then it should be possible to browse [http://localhost:8080](http://localhost:8080) and
check the logs while the suite is still running.
