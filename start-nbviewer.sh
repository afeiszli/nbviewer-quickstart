#!/bin/bash

set -x

set -eo pipefail

# Start the nbviewer instance.

if [ ! -z "$NBVIEWER_LOCALFILES" ]; then
    NBVIEWER_ARGS="$NBVIEWER_ARGS --localfiles=$NBVIEWER_LOCALFILES"
    NBVIEWER_ARGS="$NBVIEWER_ARGS --template_path=/opt/app-root/localfiles"
fi

if [ ! -z "$NBVIEWER_TEMPLATES" ]; then
    if [ `dirname "$NBVIEWER_TEMPLATES"/.` != "/opt/app-root/src" ]; then
        NBVIEWER_ARGS="$NBVIEWER_ARGS --template_path=$NBVIEWER_TEMPLATES"
    fi
fi

exec python -m nbviewer --port=8080  "$@" $NBVIEWER_ARGS
