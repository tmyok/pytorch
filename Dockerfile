RG cuda_version=11.5.1
ARG cudnn_version=8
ARG ubuntu=20.04
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-runtime-ubuntu${ubuntu}

LABEL maintainer "Tomoya Okazaki"

ENV DEBIAN_FRONTEND noninteractive

RUN apt -y update && apt -y upgrade && \
    apt -y install --no-install-recommends \
        build-essential \
        git \
        libgl1-mesa-dev \
        libglib2.0-0 \
        python3-dev \
        python3-numpy \
        python3-pip \
        unzip \
        vim \
        wget && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install setuptools==60.7.0
RUN python3 -m pip install wheel==0.37.1
RUN python3 -m pip install torch==1.10.2+cu113 torchvision==0.11.3+cu113 torchaudio==0.10.2+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
RUN python3 -m pip install pytorch-lightning==1.5.9
RUN python3 -m pip install pytorch-metric-learning==1.1.0

RUN python3 -m pip install albumentations==1.1.0
RUN python3 -m pip install ensemble-boxes==1.0.8
RUN python3 -m pip install hydra-core==1.1.1
RUN python3 -m pip install opencv-python==4.5.5.62
RUN python3 -m pip install optuna==2.10.0
RUN python3 -m pip install pandas==1.4.0
RUN python3 -m pip install tqdm==4.62.3
RUN python3 -m pip install wandb==0.12.10

RUN python3 -m pip install scikit-learn==1.0.2
RUN python3 -m pip install scikit-image==0.19.1
RUN python3 -m pip install scipy==1.7.3

RUN python3 -m pip install matplotlib==3.5.1
RUN python3 -m pip install seaborn==0.11.2

WORKDIR /home
