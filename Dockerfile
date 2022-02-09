ARG cuda_version=11.2.2
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
        libgtk2.0-dev \
        libpng-dev \
        libjpeg-dev \
        libopenexr-dev \
        libtiff-dev \
        libwebp-dev \
        libgl1-mesa-dev \
        pkg-config \
        libglib2.0-0 \
        python3-dev \
        python3-numpy \
        python3-pip \
        unzip \
        vim \
        wget && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/*

# OpenCV
WORKDIR /home
RUN wget -O - https://github.com/opencv/opencv/archive/4.5.0.tar.gz | tar zxvf -
WORKDIR /home/opencv-4.5.0/build
RUN cmake -D WITH_CUDA=OFF \
          -D BUILD_DOCS=OFF \
          -D BUILD_TESTS=OFF .. && \
    make -j $(nproc) && \
    make install && \
    rm -r /home/opencv-4.5.0

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install setuptools==60.8.1
RUN python3 -m pip install wheel==0.37.1
RUN python3 -m pip install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install pytorch-lightning==1.5.9
RUN python3 -m pip install pytorch-metric-learning==1.1.0

RUN python3 -m pip install albumentations==1.1.0
RUN python3 -m pip install ensemble-boxes==1.0.8
RUN python3 -m pip install hydra-core==1.1.1
RUN python3 -m pip install optuna==2.10.0
RUN python3 -m pip install pandas==1.4.0
RUN python3 -m pip install pycocotools==2.0.4
RUN python3 -m pip install tqdm==4.62.3

RUN python3 -m pip install mlflow==1.23.1
RUN python3 -m pip install boto3==1.20.51
RUN python3 -m pip install wandb==0.12.10

RUN python3 -m pip install scikit-learn==1.0.2
RUN python3 -m pip install scikit-image==0.19.1
RUN python3 -m pip install scipy==1.8.0

RUN python3 -m pip install matplotlib==3.5.1
RUN python3 -m pip install seaborn==0.11.2

WORKDIR /home
