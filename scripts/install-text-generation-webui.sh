#!/usr/bin/env bash
set -e -o pipefail

export PYENV_ROOT="/opt/pyenv"
export PATH="${PYENV_ROOT:?}/shims:${PYENV_ROOT:?}/bin:${PATH:?}"

echo "Installing text-generation-webui ..."

cd /opt/text-generation-webui
python3 -m venv .
source bin/activate

pip3 install \
    torch==${TORCH_VERSION:?} \
    torchvision==${TORCH_VISION_VERSION:?} \
    torchaudio==${TORCH_AUDIO_VERSION:?} \
    --index-url https://download.pytorch.org/whl/cpu
pip3 install -r requirements_cpu_only.txt

# TODO; Install extensions.
