#!/bin/bash

docker run \
    --device=/dev/nvhost-ctrl \
    --device=/dev/nvhost-ctrl-gpu \
    --device=/dev/nvhost-prof-gpu \
    --device=/dev/nvmap \
    --device=/dev/nvhost-gpu \
    --device=/dev/nvhost-as-gpu \
    --device=/dev/nvhost-vic \
    --device=/dev/tegra_dc_ctrl \
    -d \
    --network host \
    --runtime nvidia \
    --name tx2-pytorch \
    devbar/tx2-pytorch
