#!/bin/bash

set -eo pipefail

# Start the nbviewer instance.

if [ ! -z "$NBVIEWER_LOCALFILES" ]; then
    NBVIEWER_ARGS="$NBVIEWER_ARGS --localfiles=${NBVIEWER_LOCALFILES}"
fi

exec python -m nbviewer --port=8080  "$@" ${NBVIEWER_ARGS}
