#!/usr/bin/env bash

USAGE="usage: $0 [lite|dev|stage]"

check_env_vars() {
    if [ -f .env ]; then
        export $(cat .env | sed 's/#.*//g' | xargs)
    fi
    if [[ -z $HORSE_SRC ]] || [[ -z $ELEPHANT_SRC ]] || [[ -z $TIGER_SRC ]]; then
        echo "HORSE_SRC or ELEPHANT_SRC or TIGER_SRC is not set"
        exit 1
    fi
    echo "HORSE_SRC=$HORSE_SRC"
    echo "ELEPHANT_SRC=$ELEPHANT_SRC"
    echo "TIGER_SRC=$TIGER_SRC"
}

if [[ $1 == "lite" || $1 == "dev" || $1 == "stage" ]]; then
    if [[ $1 != "lite" ]]; then
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
"lite")
    docker-compose -f docker-compose.yml -f docker-compose-lite.yml pull
    docker-compose -f docker-compose.yml -f docker-compose-lite.yml up -d
    ;;
"dev")
    docker-compose -f docker-compose.yml -f docker-compose-dev.yml -f docker-compose-ui.yml pull
    docker-compose -f docker-compose.yml -f docker-compose-dev.yml -f docker-compose-ui.yml -p joj2 up -d --force-recreate
    ;;
"stage")
    docker-compose -f docker-compose-stage.yml pull
    docker-compose -f docker-compose-stage.yml -p joj2 up -d
    ;;
esac
