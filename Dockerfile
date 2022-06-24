ARG cuda_version=11.6.2
ARG cudnn_version=8
ARG ubuntu=20.04
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-runtime-ubuntu${ubuntu}

LABEL maintainer "Tomoya Okazaki"

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt -y update && apt -y upgrade && \
    apt -y install --no-install-recommends \
        build-essential \
        cmake \
        git \
        less \
        libavcodec-dev \
        libavformat-dev \
        libgl1-mesa-dev \
        libglib2.0-0 \
        libgtk2.0-dev \
        libjpeg-dev \
        libopenexr-dev \
        libpng-dev \
        libsm6 \
        libssl-dev \
        libswscale-dev \
        libtiff-dev \
        libtbb2 \
        libtbb-dev \
        libwebp-dev \
        libxext-dev \
        libxrender1 \
        pkg-config \
        python3-dev \
        python3-pip \
        python3-numpy \
        unzip \
        vim \
        wget && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install setuptools==62.6.0
RUN python3 -m pip install wheel==0.37.1
RUN python3 -m pip install torch==1.11.0 torchvision==0.12.0 torchaudio==0.11.0 torchmetrics==0.9.1 --extra-index-url https://download.pytorch.org/whl/cu113
RUN python3 -m pip install pytorch-lightning==1.6.4
RUN python3 -m pip install opencv-python==4.6.0.66

RUN python3 -m pip install albumentations==1.2.0
RUN python3 -m pip install hydra-core==1.2.0
RUN python3 -m pip install optuna==2.10.1
RUN python3 -m pip install hydra-optuna-sweeper==1.2.0
RUN python3 -m pip install pandas==1.4.3
RUN python3 -m pip install timm==0.5.4
RUN python3 -m pip install tqdm==4.64.0

RUN python3 -m pip install scikit-learn==1.1.1
RUN python3 -m pip install scikit-image==0.19.3
RUN python3 -m pip install scipy==1.8.1

RUN python3 -m pip install matplotlib==3.5.2
RUN python3 -m pip install seaborn==0.11.2

RUN python3 -m pip install mlflow==1.26.1
RUN python3 -m pip install boto3==1.24.16
RUN python3 -m pip install wandb==0.12.19

RUN python3 -m pip install ensemble-boxes==1.0.9
RUN python3 -m pip install pycocotools==2.0.4

RUN python3 -m pip install faiss-gpu==1.7.2
RUN python3 -m pip install pytorch-metric-learning==1.4.0

RUN python3 -m pip install e2cnn==0.2.1
RUN python3 -m pip install einops==0.4.1
RUN python3 -m pip install h5py==3.7.0
RUN python3 -m pip install imutils==0.5.4
RUN python3 -m pip install kornia==0.6.5
RUN python3 -m pip install kornia-moons==0.2.0
RUN python3 -m pip install loguru==0.6.0
RUN python3 -m pip install yacs==0.1.8

WORKDIR /home