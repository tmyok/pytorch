ARG cuda_version=10.2
ARG cudnn_version=7
ARG ubuntu=18.04
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
        software-properties-common \
        unzip \
        vim \
        wget && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y install --no-install-recommends \
        python3.7 && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y install --no-install-recommends \
        python3-pip && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

# CMake
WORKDIR /home
RUN wget -O - https://github.com/Kitware/CMake/releases/download/v3.23.1/cmake-3.23.1.tar.gz | tar zxvf -
WORKDIR /home/cmake-3.23.1/
RUN ./bootstrap && make && make install && rm -r /home/cmake-3.23.1

# OpenCV
WORKDIR /home
RUN wget -O - https://github.com/opencv/opencv/archive/4.5.5.tar.gz | tar zxvf -
RUN wget -O - https://github.com/opencv/opencv_contrib/archive/refs/tags/4.5.5.tar.gz | tar zxvf -
WORKDIR /home/opencv-4.5.5/build

RUN cmake -D WITH_CUDA=OFF \
        -D CMAKE_BUILD_TYPE=RELEASE \
        -D OPENCV_ENABLE_NONFREE=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.5.5/modules \
        -D WITH_GTK=ON \
        -D WITH_EIGEN=ON \
        -D EIGEN_INCLUDE_PATH=/usr/include/eigen3 \
        -D BUILD_DOCS=OFF \
        -D BUILD_TESTS=OFF .. && \
    make -j $(nproc) && \
    make install && \
    rm -r /home/opencv-4.5.5 && \
    rm -r /home/opencv_contrib-4.5.5

RUN python3.7 -m pip install --upgrade pip
RUN python3.7 -m pip install setuptools
RUN python3.7 -m pip install wheel
RUN python3.7 -m pip install numpy

WORKDIR /home