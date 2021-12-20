#!/usr/bin/env bash

USAGE="usage: $0 [prod|dev|stage]"

check_env_vars() {
    if [ -f .env ]; then
        export $(cat .env | sed 's/#.*//g' | xargs)
    fi
    if [[ -z $HORSE_SRC ]]; then
        echo "HORSE_SRC is not set"
        exit 1
    fi
    echo "HORSE_SRC=$HORSE_SRC"
}

build_horse_image_with_test() {
    cd $HORSE_SRC
    DOCKER_BUILDKIT=1 docker build --build-arg PYTEST=1 -t ghcr.io/joint-online-judge/horse:test .
    cd - >/dev/null
}

if [[ $1 == "prod" || $1 == "dev" || $1 == "stage" ]]; then
    docker-compose pull
    if [[ $1 != "prod" ]]; then
        check_env_vars
    fi
elif [[ $1 == "help" ]]; then
    echo $USAGE
    exit 0
else
    echo $USAGE
    exit 1
fi

case "$1" in
"prod")
    docker-compose -f docker-compose.yml -f docker-compose-ui.yml -p joj2 up -d
    ;;
"dev")
    build_horse_image_with_test
    docker-compose -f docker-compose.yml -f docker-compose-dev.yml -f docker-compose-ui.yml -p joj2 up -d
    ;;
"stage")
    build_horse_image_with_test
    docker-compose -f docker-compose-stage.yml -p joj2 up -d
    ;;
esac
