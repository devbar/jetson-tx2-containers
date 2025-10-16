# MIT License

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

FROM docker.io/arm64v8/ubuntu:20.04

ENV LD_LIBRARY_PATH=/usr/lib/aarch64-linux-gnu/tegra

# Prepare Apt repository for TX2

ADD --chown=root:root https://repo.download.nvidia.com/jetson/jetson-ota-public.asc /etc/apt/trusted.gpg.d/jetson-ota-public.asc

ARG SOC=t186

RUN chmod 644 /etc/apt/trusted.gpg.d/jetson-ota-public.asc \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends ca-certificates \
    && echo "deb https://repo.download.nvidia.com/jetson/common r32.7 main" > /etc/apt/sources.list.d/nvidia-l4t-apt-source.list \
    && echo "deb https://repo.download.nvidia.com/jetson/${SOC} r32.7 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list \
	&& mkdir -p /opt/nvidia/l4t-packages/ && touch /opt/nvidia/l4t-packages/.nv-l4t-disable-boot-fw-update-in-preinstall \
	&& rm -rf /var/lib/apt/lists/*

ADD libffi6_3.2.1-9_arm64.deb /opt/

RUN dpkg -i /opt/libffi6_3.2.1-9_arm64.deb

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
	python3 \
	python3-pip \
    nvidia-l4t-core \
	nvidia-l4t-wayland \
    nvidia-l4t-3d-core \
    nvidia-l4t-cuda \
	cuda-libraries-10-2 \
	cuda-nvtx-10-2 \
	libcudnn8 \
	libopenblas-base \
	libopenmpi3 \
	libomp-dev \
	cuda-toolkit-10-2 \
	libjpeg8 \
	libpng16-16 \
	libgomp1 && \
    ln -s /usr/lib/aarch64-linux-gnu/libcuda.so /usr/lib/aarch64-linux-gnu/libcuda.so.1

ADD torch-1.13.0a0+git7c98e70-cp38-cp38-linux_aarch64.whl /opt/
ADD torchvision-0.14.0a0+5ce4506-cp38-cp38-linux_aarch64.whl /opt/

RUN python3 -m pip install /opt/torch-1.13.0a0+git7c98e70-cp38-cp38-linux_aarch64.whl
RUN python3 -m pip install /opt/torchvision-0.14.0a0+5ce4506-cp38-cp38-linux_aarch64.whl
RUN python3 -m pip install huggingface_hub==0.30
RUN python3 -m pip install transformers[torch]==4.46.3

CMD ["/bin/bash", "-c", "echo 'No DRADIS contacts'; sleep infinity"]
