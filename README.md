# JOJ2 Deploy

<!-- First you need to build the docker image for horse

```bash
git clone git@github.com:joint-online-judge/horse.git
cd horse
docker buildx build -t jioj/horse:latest .
``` -->

## Production

```bash
./start.sh prod
```

## Development

For ease of development, mount the source directory of horse into the container and auto reloading (DEBUG=true) is also enabled in `docker-compose-dev.yml`. You need to export the environment variable `HORSE_SRC` , then start development!

```bash
export HORSE_SRC=/path/to/horse/src # path of the git repo of horse
# or put the environment variables to a .env file
```

### Development in local machine

```bash
./start.sh dev
```

### Development in stage server

```bash
./start.sh stage
```

