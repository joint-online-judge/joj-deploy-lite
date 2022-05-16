# JOJ2 Deploy

## Production

```bash
./start.sh prod
```

## Development

For ease of development, mount the source directory of horse into the container and auto reloading (DEBUG=true) is also enabled in `docker-compose-dev.yml`. You need to export the environment variable `HORSE_SRC`, `ELEPHANT_SRC`, and `TIGER_SRC`, then start development!

```bash
export HORSE_SRC=/path/to/horse/src # path of the git repo of horse
export ELEPHANT_SRC=/path/to/elephant/src # path of the git repo of elephant
export TIGER_SRC=/path/to/tiger/src # path of the git repo of tiger
# or put the environment variables to a .env file
```

### Develop with Local DB

```bash
./start.sh dev
```

### Develop with Stage DB

```bash
./start.sh stage
```
