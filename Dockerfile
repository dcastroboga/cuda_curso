FROM nvidia/cuda:12.0.1-cudnn8-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instalar herramientas y OpenCV sin prompts
RUN apt-get update && apt-get install -y \
    build-essential cmake git libopencv-dev tzdata vim && \
    ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

WORKDIR /workspace


COPY . /workspace

RUN make

CMD ["bash"]
