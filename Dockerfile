ARG cuda_version=11.8.0
ARG cudnn_version=8
ARG ubuntu=22.04
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel-ubuntu${ubuntu}

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
        libvips \
        libvips-dev \
        libvips-tools \
        libwebp-dev \
        libxext-dev \
        libxrender1 \
        pkg-config \
        python3-dev \
        python3-pip \
        python3-numpy \
        software-properties-common \
        unzip \
        vim \
        wget && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install setuptools==67.8.0
RUN python3 -m pip install wheel==0.40.0
RUN python3 -m pip install torch==2.0.1+cu118 torchvision==0.15.2+cu118 torchaudio==2.0.2+cu118 --index-url https://download.pytorch.org/whl/cu118
RUN python3 -m pip install lightning==2.0.3
RUN python3 -m pip install opencv-python==4.7.0.72

RUN python3 -m pip install albumentations==1.3.1
RUN python3 -m pip install hydra-core==1.3.2
RUN python3 -m pip install optuna==3.2.0
RUN python3 -m pip install tqdm==4.65.0

RUN python3 -m pip install pandas==2.0.2
RUN python3 -m pip install polars==0.18.2
RUN python3 -m pip install lightgbm==3.3.5

RUN python3 -m pip install scikit-learn==1.2.2
RUN python3 -m pip install scikit-image==0.21.0
RUN python3 -m pip install scipy==1.10.1

RUN python3 -m pip install matplotlib==3.7.1
RUN python3 -m pip install seaborn==0.12.2

#RUN python3 -m pip install mlflow
RUN python3 -m pip install boto3==1.26.153
RUN python3 -m pip install wandb==0.15.4

RUN python3 -m pip install grad-cam==1.4.6

RUN python3 -m pip install effdet==0.4.1
RUN python3 -m pip install ensemble-boxes==1.0.9
RUN python3 -m pip install pycocotools==2.0.6

RUN python3 -m pip install openmim==0.3.7
RUN mim install mmcv-full
RUN python3 -m pip install mmcls==0.25.0
RUN python3 -m pip install mmdet==3.0.0
RUN python3 -m pip install mmsegmentation==1.0.0

RUN python3 -m pip install faiss-gpu==1.7.2
RUN python3 -m pip install pytorch-metric-learning==2.1.2

RUN python3 -m pip install e2cnn==0.2.3
RUN python3 -m pip install einops==0.6.1
RUN python3 -m pip install h5py==3.8.0
RUN python3 -m pip install imutils==0.5.4
RUN python3 -m pip install kornia==0.6.12
RUN python3 -m pip install kornia-moons==0.2.6
RUN python3 -m pip install loguru==0.7.0
RUN python3 -m pip install yacs==0.1.8

RUN python3 -m pip install pyvips==2.2.1
RUN python3 -m pip install torchstain==1.3.0

RUN python3 -m pip install pydicom==2.4.0
RUN python3 -m pip install gdcm==1.1
RUN python3 -m pip install pylibjpeg==1.4.0
RUN python3 -m pip install python-gdcm==3.0.22
RUN python3 -m pip install pylibjpeg-libjpeg==1.3.4
RUN python3 -m pip install pylibjpeg-openjpeg==1.3.2
RUN python3 -m pip install pylibjpeg-rle==1.3.0
RUN python3 -m pip install dicomsdl==0.109.2
RUN python3 -m pip install --extra-index-url https://developer.download.nvidia.com/compute/redist/nightly --upgrade nvidia-dali-nightly-cuda110

RUN python3 -m pip install tensorrt==8.6.0
RUN python3 -m pip install onnxruntime==1.15.0
RUN python3 -m pip install onnxsim==0.4.31

RUN python3 -m pip install transformers==4.30.2
RUN python3 -m pip install datasets==2.13.0
RUN python3 -m pip install nltk==3.8.1
RUN python3 -m pip install gensim==4.3.1

RUN python3 -m pip install open-clip-torch==2.20.0
RUN python3 -m pip install clip-interrogator==0.6.0

RUN python3 -m pip install jsonschema==4.17.3

RUN python3 -m pip install monai==1.2.0
RUN python3 -m pip install segmentation-models-pytorch==0.3.3
RUN python3 -m pip install pip install itk==5.3.0
RUN python3 -m pip install pip install networkx==3.1
RUN python3 -m pip install pip install warmup_scheduler==0.3
RUN python3 -m pip install pip install cupy-cuda11x==12.1.0

RUN python3 -m pip install -U timm==0.9.2

WORKDIR /home