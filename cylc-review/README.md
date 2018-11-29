# Cylc Review

This setup provides Cylc Review running on an Alpine image as WSGI service,
reverse proxied through another image running nginx with Alpine too.

Not intended for production use, but rather for development and testing.
Running it will start Cylc Review, **running WSGI as root** and while the
Cylc Review UI will be displayed correctly, there is no data and Cylc
installation is also incomplete. Only for demonstration and testing
purposes.

## Running it

```bash
$ docker-compose build
$ docker-compose up
```
