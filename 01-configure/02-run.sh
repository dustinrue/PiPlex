#!/bin/bash

install -m 755 files/arm_wrapper.sh   "${ROOTFS_DIR}/opt/arm/scripts/arm_wrapper.sh"
install -m 644 files/arm.yaml         "${ROOTFS_DIR}/opt/arm/arm.yaml"
