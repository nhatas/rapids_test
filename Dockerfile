# use RAPIDS AI Docker as base container
FROM rapidsai/rapidsai:21.06-cuda11.0-runtime-ubuntu18.04-py3.7

# set useful locale encodings
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# set important variable to install ubuntu packages without interaction (pressing yes)
ARG DEBIAN_FRONTEND=noninteractive

# install packages in ubuntu
RUN apt-get update --fix-missing && \
  apt-get install -y wget bzip2 build-essential \
  ca-certificates git libglib2.0-0 libxext6 libsm6 \
  libxrender1 git mercurial subversion python3-dev vim && \
  apt-get clean

# set PATH to include conda binaries
ENV PATH=/opt/conda/bin:$PATH

# install mamba
RUN conda install -n base -c conda-forge mamba

# install conda packages using mamba
RUN mamba install -y -n rapids -c conda-forge -c huggingface -c pytorch -c anaconda -c fastai \
    pip \
    tensorflow-gpu \
    nltk \
    gensim \
    jupyterlab \
    transformers \
    fastai

# example of installing packages in pip
# RUN pip install \
#    apt-select 

# RUN python3 -m pip install --no-cache-dir --upgrade pip && \
#     python3 -m pip install --no-cache-dir \
#     apt-select