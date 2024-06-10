IMAGE_NAME := homelab-text-generation-webui
IMAGE_SUPPORTED_DOCKER_PLATFORMS := linux/amd64

include ./.bootstrap/makesystem.mk

ifeq ($(MAKESYSTEM_FOUND),1)
include $(MAKESYSTEM_BASE_DIR)/dockerfile.mk
endif
