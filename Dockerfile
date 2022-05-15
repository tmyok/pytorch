FROM ubuntu:20.04

LABEL maintainer "Tomoya Okazaki"

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENV PYTHON_VERSION 3.7.12
ENV HOME /root
ENV PYTHON_ROOT $HOME/local/python-$PYTHON_VERSION
ENV PATH $PYTHON_ROOT/bin:$PATH
ENV PYENV_ROOT $HOME/.pyenv


RUN apt -y update && apt -y upgrade && \
    apt -y install --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    less \
    libavcodec-dev \
    libavformat-dev \
    libbz2-dev \
    libffi-dev \
    libgl1-mesa-dev \
    libglib2.0-0 \
    libgtk2.0-dev \
    liblzma-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
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
    llvm \
    make \
    pkg-config \
    tk-dev \
    unzip \
    vim \
    wget \
    xz-utils \
    zlib1g-dev \
 && apt -y clean \
 && rm -rf /var/lib/apt/lists/*

# pyenv
WORKDIR $PYENV_ROOT
RUN wget -O - https://github.com/pyenv/pyenv/archive/refs/tags/v2.3.0.tar.gz | tar zxvf -
RUN $PYENV_ROOT/pyenv-2.3.0/plugins/python-build/install.sh
RUN /usr/local/bin/python-build -v $PYTHON_VERSION $PYTHON_ROOT
RUN rm -rf $PYENV_ROOT

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