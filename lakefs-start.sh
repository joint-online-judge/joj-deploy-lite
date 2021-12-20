#!/bin/sh

set -e
set -u

/app/wait-for postgres:5432
/app/wait-for minio:9000



/app/lakefs setup --user-name lakefs --access-key-id ${LAKEFS_ACCESS_KEY_ID} --secret-access-key ${LAKEFS_SECRET_ACCESS_KEY} || true
/app/lakefs run
