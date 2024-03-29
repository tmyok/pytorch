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
        libmpich-dev \
        libopenexr-dev \
        libopenmpi-dev \
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

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir \
        setuptools \
        wheel==0.41.2 && \
    python3 -m pip install --no-cache-dir \
        torch==2.0.1+cu118 \
        torchvision==0.15.2+cu118 \
        torchaudio==2.0.2+cu118 \
        --index-url https://download.pytorch.org/whl/cu118 && \
    python3 -m pip cache purge

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir \
        accelerate==0.23.0 \
        albumentations==1.3.1 \
        bitsandbytes==0.41.1 \
        boto3==1.28.50 \
        ctranslate2==3.20.0 \
        cupy-cuda11x==12.2.0 \
        datasets==2.14.5 \
        deepspeed==0.10.3 \
        e2cnn==0.2.3 \
        effdet==0.4.1 \
        einops==0.6.1 \
        ensemble-boxes==1.0.9 \
        evaluate==0.4.0 \
        faiss-gpu==1.7.2 \
        fire==0.5.0 \
        gdcm==1.1 \
        gensim==4.3.2 \
        googletrans==3.0.0 \
        google-trans-new==1.1.9 \
        grad-cam==1.4.8 \
        h5py==3.9.0 \
        hydra-core==1.3.2 \
        imutils==0.5.4 \
        jsonschema==4.19.0 \
        kornia==0.7.0 \
        kornia-moons==0.2.6 \
        langchain==0.0.294 \
        lightgbm==4.1.0 \
        lightning==2.0.6 \
        loguru==0.7.2 \
        matplotlib==3.8.0 \
        mpi4py==3.1.4 \
        networkx==3.1 \
        nltk==3.8.1 \
        onnxruntime==1.15.1 \
        onnxsim==0.4.33 \
        opencv-python==4.8.0.76 \
        optuna==3.3.0 \
        pandas==2.1.0 \
        peft==0.5.0 \
        polars==0.19.3 \
        pycocotools==2.0.7 \
        pylibjpeg==1.4.0 \
        pylibjpeg-libjpeg==1.3.4 \
        pylibjpeg-openjpeg==1.3.2 \
        pylibjpeg-rle==1.3.0 \
        pytorch-metric-learning==2.3.0 \
        pyvips==2.2.1 \
        PyYAML==6.0.1 \
        segmentation-models-pytorch==0.3.3 \
        sentencepiece==0.1.99 \
        sentence-transformers==2.2.2 \
        torchstain==1.3.0 \
        tqdm==4.66.1 \
        transformers==4.33.2 \
        translate==3.6.1 \
        scikit-learn==1.3.0 \
        scikit-image==0.21.0 \
        scipy==1.11.2 \
        seaborn==0.12.2 \
        warmup_scheduler==0.3 \
        wandb==0.15.10 \
        xformers==0.0.21 \
        yacs==0.1.8 && \
    python3 -m pip cache purge

RUN python3 -m pip install --no-cache-dir -U timm==0.9.7
RUN python3 -m pip install --no-cache-dir -U protobuf==3.20.2

RUN python3 -m pip cache purge

WORKDIR /home