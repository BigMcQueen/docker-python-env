FROM ubuntu:18.04

RUN apt-get -y update && apt-get install -y \
sudo \
wget \
libgl1-mesa-dev

#install miniconda3
WORKDIR /opt

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-aarch64.sh && \
sh /opt/Miniconda3-py39_4.9.2-Linux-aarch64.sh -b -p /opt/conda && \
rm -f Miniconda3-py39_4.9.2-Linux-aarch64.sh
# set path
ENV PATH /opt/conda/bin:$PATH

# update pip and conda
RUN pip install --upgrade pip && \
    conda update conda
RUN pip install tensorflow-aarch64 opencv-python japanize-matplotlib
RUN conda install jupyterlab matplotlib pandas scipy scikit-learn seaborn

WORKDIR /
RUN mkdir /work

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]