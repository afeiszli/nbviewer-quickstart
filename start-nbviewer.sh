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

if [ -z "$CACHE_EXPIRY_MIN" ]; then
    CACHE_EXPIRY_MIN="120"
fi

if [ -z "$CACHE_EXPIRY_MAX" ]; then
    CACHE_EXPIRY_MAX="300"
fi

if [ -n "$NO_CACHE" ]; then
    NO_CACHE="--no-cache"
fi

if [ -z $NBVIEWER_PORT ]; then
    NBVIEWER_PORT=8080
fi

if echo $JUPYTERHUB_SERVICE_PREFIX | grep -q '{username}'; then
    USER_NAME=$(echo $HOSTNAME | sed 's/.*-nb-//')
#    if [ -n "$JUPYTERHUB_USER_NAME" ]; then
#        USER_NAME=$JUPYTERHUB_USER_NAME
#    fi

    JUPYTERHUB_SERVICE_PREFIX=$(echo $JUPYTERHUB_SERVICE_PREFIX | sed 's/{username}/'$USER_NAME'/')
fi

exec python -m nbviewer --port=$NBVIEWER_PORT --cache-expiry-min=$CACHE_EXPIRY_MIN --cache-expiry-max=$CACHE_EXPIRY_MAX $NO_CACHE "$@" $NBVIEWER_ARGS
