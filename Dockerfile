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
        git \
        less \
        libgl1-mesa-dev \
        libglib2.0-0 \
        libgtk2.0-dev \
        libjpeg-dev \
        libopenexr-dev \
        libpng-dev \
        libsm6 \
        libssl-dev \
        libtiff-dev \
        libwebp-dev \
        libxext-dev \
        libxrender1 \
        pkg-config \
        python3-dev \
        python3-pip \
        unzip \
        vim \
        wget && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/*

# CMake
WORKDIR /home
RUN wget -O - https://github.com/Kitware/CMake/releases/download/v3.22.3/cmake-3.23.1.tar.gz | tar zxvf -
WORKDIR /home/cmake-3.23.1/
RUN ./bootstrap && make && make install && rm -r /home/cmake-3.23.1

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install setuptools==62.2.0
RUN python3 -m pip install opencv-python==4.5.5.64
RUN python3 -m pip install wheel==0.37.1
RUN python3 -m pip install torch==1.11.0+cu113 torchvision==0.12.0+cu113 torchaudio==0.11.0+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
RUN python3 -m pip install pytorch-lightning==1.6.3

RUN python3 -m pip install albumentations==1.1.0
RUN python3 -m pip install ensemble-boxes==1.0.9
RUN python3 -m pip install faiss-gpu==1.7.2
RUN python3 -m pip install hydra-core==1.1.2
RUN python3 -m pip install optuna==2.10.0
RUN python3 -m pip install hydra-optuna-sweeper==1.1.2
RUN python3 -m pip install pandas==1.4.2
RUN python3 -m pip install pycocotools==2.0.4
RUN python3 -m pip install pytorch-metric-learning==1.3.0
RUN python3 -m pip install timm==0.5.4
RUN python3 -m pip install tqdm==4.64.0

RUN python3 -m pip install mlflow==1.25.1
RUN python3 -m pip install boto3==1.23.0
RUN python3 -m pip install wandb==0.12.16

RUN python3 -m pip install scikit-learn==1.1.0
RUN python3 -m pip install scikit-image==0.19.2
RUN python3 -m pip install scipy==1.8.0

RUN python3 -m pip install matplotlib==3.5.2
RUN python3 -m pip install seaborn==0.11.2

RUN python3 -m pip install kornia==0.6.4
RUN python3 -m pip install kornia-moons==0.1.9
RUN python3 -m pip install imutils==0.5.4
RUN python3 -m pip install loguru==0.6.0
RUN python3 -m pip install einops==0.4.1
RUN python3 -m pip install yacs==0.1.8
RUN python3 -m pip install h5py==3.6.0

WORKDIR /home