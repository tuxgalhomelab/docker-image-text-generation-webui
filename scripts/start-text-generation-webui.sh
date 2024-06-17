#!/usr/bin/env bash
set -E -e -o pipefail

set_umask() {
    # Configure umask to allow write permissions for the group by default
    # in addition to the owner.
    umask 0002
}

start_text_generation_webui() {
    echo "Starting text-generation-webui ..."
    echo
    cd /opt/text-generation-webui
    source bin/activate

    export PYTHONUNBUFFERED=1
    export PYTHONIOENCODING=UTF-8

    exec python3 server.py \
        --listen \
        --listen-port 7860 \
        --api \
        --cpu \
        --mlock
}

set_umask
start_text_generation_webui
