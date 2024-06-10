#!/usr/bin/env bash
set -e -o pipefail

start_text_generation_webui() {
    echo "Starting text-generation-webui ..."
    echo
    cd /opt/text-generation-webui
    source bin/activate
    exec python3 /opt/text-generation-webui/server.py --listen --listen-port 7860 --api --cpu --mlock
}

start_text_generation_webui
