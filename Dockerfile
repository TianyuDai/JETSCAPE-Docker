FROM ubuntu:latest
MAINTAINER wf39@duke.edu

ENV workdir=/global/homes/w/wf39

ENV PACKAGES wget git ca-certificates rsync ssh\
             make gcc g++ cmake \
             libboost-all-dev \
             gsl-bin libgsl0-dbg libgsl0-dev libgsl23 \
             zlib1g-dev libcr-dev mpich mpich-doc 

RUN apt-get update && \
    apt-get install -y --no-install-recommends ${PACKAGES}

RUN mkdir /home/downloads

RUN wget -P /home/downloads http://home.thep.lu.se/~torbjorn/pythia8/pythia8235.tgz &&\
    cd /home/downloads &&\
    tar xvfz pythia8235.tgz &&\
    cd pythia8235 &&\
    ./configure --prefix=/usr/local &&\
    make -j8 &&\
    make install  

RUN wget -P /home/downloads http://hepmc.web.cern.ch/hepmc/releases/hepmc3.0.0.tgz &&\
    cd /home/downloads &&\
    tar -xvzf hepmc3.0.0.tgz &&\
    cd hepmc3.0.0/cmake &&\
    cmake --prefix=/usr/local .. &&\
    make -j16 &&\
    make install 

RUN wget -P /home/downloads https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.4/src/hdf5-1.10.4.tar.gz &&\
    cd home/downloads &&\
    tar -xvzf hdf5-1.10.4.tar.gz &&\  
    cd hdf5-1.10.4 &&\
    ./configure --prefix=/usr/local --enable-cxx &&\
    make -j8 &&\
    make install

RUN rm -rf /home/downloads

ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

COPY JETSCAPE-COMP home/JETSCAPE-COMP

RUN cd home/JETSCAPE-COMP &&\
    mkdir build && cd build &&\
    cmake -Dmusic=on -DiSS=on .. &&\
    make -j8 &&\
    cp -r home/JETSCAPE-COMP/build $workdir

WORKDIR $workdir

#CMD ["./PythiaBrickTest"]
