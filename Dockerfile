ARG BASE_IMAGE_NAME
ARG BASE_IMAGE_TAG
FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}

COPY scripts/start-text-generation-webui.sh scripts/install-text-generation-webui.sh /scripts/

SHELL ["/bin/bash", "-c"]

ARG USER_NAME
ARG GROUP_NAME
ARG USER_ID
ARG GROUP_ID
ARG TEXT_GENERATION_WEBUI_VERSION
ARG TEXT_GENERATION_WEBUI_SHA256_CHECKSUM
ARG TORCH_VERSION
ARG TORCH_VISION_VERSION
ARG TORCH_AUDIO_VERSION

RUN \
    set -E -e -o pipefail \
    # Install build dependencies. \
    && homelab install util-linux git build-essential \
    # Create the user and the group. \
    && homelab add-user \
        ${USER_NAME:?} \
        ${USER_ID:?} \
        ${GROUP_NAME:?} \
        ${GROUP_ID:?} \
        --create-home-dir \
    # Download and install the release. \
    && homelab install-tar-dist \
        https://github.com/oobabooga/text-generation-webui/archive/refs/tags/${TEXT_GENERATION_WEBUI_VERSION:?}.tar.gz \
        "${TEXT_GENERATION_WEBUI_SHA256_CHECKSUM:?}" \
        text-generation-webui \
        text-generation-webui-${TEXT_GENERATION_WEBUI_VERSION:?} \
        ${USER_NAME:?} \
        ${GROUP_NAME:?} \
    && chown -R ${USER_NAME:?}:${GROUP_NAME:?} /opt/text-generation-webui/ \
    && su --login --shell /bin/bash --command "TORCH_VERSION=${TORCH_VERSION:?} TORCH_VISION_VERSION=${TORCH_VISION_VERSION:?} TORCH_AUDIO_VERSION=${TORCH_AUDIO_VERSION:?} /scripts/install-text-generation-webui.sh" ${USER_NAME:?} \
    && ln -sf /scripts/start-text-generation-webui.sh /opt/bin/start-text-generation-webui \
    # Clean up. \
    && rm /scripts/install-text-generation-webui.sh \
    && homelab remove util-linux git build-essential \
    && homelab cleanup

EXPOSE 7860

ENV USER=${USER_NAME}
USER ${USER_NAME}:${GROUP_NAME}
WORKDIR /home/${USER_NAME}

CMD ["start-text-generation-webui"]
STOPSIGNAL SIGINT
