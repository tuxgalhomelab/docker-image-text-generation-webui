#!/usr/bin/env bash
set -E -e -o pipefail

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

start_text_generation_webui
