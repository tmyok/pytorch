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
RUN python3 -m pip install --no-cache-dir setuptools==68.0.0
RUN python3 -m pip install --no-cache-dir wheel==0.41.1
RUN python3 -m pip install --no-cache-dir torch==2.0.1+cu118 torchvision==0.15.2+cu118 torchaudio==2.0.2+cu118 --index-url https://download.pytorch.org/whl/cu118
RUN python3 -m pip install --no-cache-dir lightning==2.0.6
RUN python3 -m pip install --no-cache-dir opencv-python==4.8.0.74

RUN python3 -m pip install --no-cache-dir albumentations==1.3.1
RUN python3 -m pip install --no-cache-dir hydra-core==1.3.2
RUN python3 -m pip install --no-cache-dir optuna==3.2.0
RUN python3 -m pip install --no-cache-dir tqdm==4.65.0

RUN python3 -m pip install --no-cache-dir pandas==2.0.3
RUN python3 -m pip install --no-cache-dir polars==0.18.12
RUN python3 -m pip install --no-cache-dir lightgbm==4.0.0

RUN python3 -m pip install --no-cache-dir scikit-learn==1.3.0
RUN python3 -m pip install --no-cache-dir scikit-image==0.21.0
RUN python3 -m pip install --no-cache-dir scipy==1.11.1

RUN python3 -m pip install --no-cache-dir matplotlib==3.7.2
RUN python3 -m pip install --no-cache-dir seaborn==0.12.2

#RUN python3 -m pip install --no-cache-dir mlflow
RUN python3 -m pip install --no-cache-dir boto3==1.28.20
RUN python3 -m pip install --no-cache-dir wandb==0.15.8

RUN python3 -m pip install --no-cache-dir grad-cam==1.4.8

RUN python3 -m pip install --no-cache-dir effdet==0.4.1
RUN python3 -m pip install --no-cache-dir ensemble-boxes==1.0.9
RUN python3 -m pip install --no-cache-dir pycocotools==2.0.6

RUN python3 -m pip install --no-cache-dir openmim==0.3.9
RUN mim install mmcv-full
RUN python3 -m pip install --no-cache-dir mmpretrain==1.0.1
RUN python3 -m pip install --no-cache-dir mmdet==3.1.0
RUN python3 -m pip install --no-cache-dir mmsegmentation==1.1.1

RUN python3 -m pip install --no-cache-dir faiss-gpu==1.7.2
RUN python3 -m pip install --no-cache-dir pytorch-metric-learning==2.3.0

RUN python3 -m pip install --no-cache-dir e2cnn==0.2.3
RUN python3 -m pip install --no-cache-dir einops==0.6.1
RUN python3 -m pip install --no-cache-dir h5py==3.9.0
RUN python3 -m pip install --no-cache-dir imutils==0.5.4
RUN python3 -m pip install --no-cache-dir kornia==0.7.0
RUN python3 -m pip install --no-cache-dir kornia-moons==0.2.6
RUN python3 -m pip install --no-cache-dir loguru==0.7.0
RUN python3 -m pip install --no-cache-dir yacs==0.1.8

RUN python3 -m pip install --no-cache-dir pyvips==2.2.1
RUN python3 -m pip install --no-cache-dir torchstain==1.3.0

RUN python3 -m pip install --no-cache-dir pydicom==2.4.2
RUN python3 -m pip install --no-cache-dir gdcm==1.1
RUN python3 -m pip install --no-cache-dir pylibjpeg==1.4.0
RUN python3 -m pip install --no-cache-dir python-gdcm==3.0.22
RUN python3 -m pip install --no-cache-dir pylibjpeg-libjpeg==1.3.4
RUN python3 -m pip install --no-cache-dir pylibjpeg-openjpeg==1.3.2
RUN python3 -m pip install --no-cache-dir pylibjpeg-rle==1.3.0
RUN python3 -m pip install --no-cache-dir dicomsdl==0.109.2
RUN python3 -m pip install --no-cache-dir --extra-index-url https://developer.download.nvidia.com/compute/redist/nightly --upgrade nvidia-dali-nightly-cuda110

RUN python3 -m pip cache purge

RUN python3 -m pip install --no-cache-dir tensorrt==8.6.1
RUN python3 -m pip install --no-cache-dir onnxruntime==1.15.1
RUN python3 -m pip install --no-cache-dir onnxsim==0.4.33

RUN python3 -m pip install --no-cache-dir transformers==4.31.0
RUN python3 -m pip install --no-cache-dir datasets==2.14.3
RUN python3 -m pip install --no-cache-dir nltk==3.8.1
RUN python3 -m pip install --no-cache-dir gensim==4.3.1

RUN python3 -m pip install --no-cache-dir open-clip-torch==2.20.0
RUN python3 -m pip install --no-cache-dir clip-interrogator==0.6.0

RUN python3 -m pip install --no-cache-dir jsonschema==4.18.6

RUN python3 -m pip install --no-cache-dir monai==1.2.0
RUN python3 -m pip install --no-cache-dir segmentation-models-pytorch==0.3.3
RUN python3 -m pip install --no-cache-dir itk==5.3.0
RUN python3 -m pip install --no-cache-dir networkx==3.1
RUN python3 -m pip install --no-cache-dir warmup_scheduler==0.3
RUN python3 -m pip install --no-cache-dir cupy-cuda11x==12.1.0

RUN python3 -m pip install --no-cache-dir googletrans==3.0.0
RUN python3 -m pip install --no-cache-dir google-trans-new==1.1.9
RUN python3 -m pip install --no-cache-dir translate==3.6.1
RUN python3 -m pip install --no-cache-dir ctranslate2==3.18.0
RUN python3 -m pip install --no-cache-dir sentencepiece==0.1.99
RUN python3 -m pip install --no-cache-dir sentence-transformers==2.2.2
RUN python3 -m pip install --no-cache-dir xformers==0.0.20
RUN python3 -m pip install --no-cache-dir peft==0.4.0
RUN python3 -m pip install --no-cache-dir bitsandbytes==0.41.1
RUN python3 -m pip install --no-cache-dir deepspeed==0.10.0

RUN python3 -m pip install --no-cache-dir -U timm==0.9.5
RUN python3 -m pip install --no-cache-dir -U protobuf==3.20.2

RUN python3 -m pip cache purge

WORKDIR /home