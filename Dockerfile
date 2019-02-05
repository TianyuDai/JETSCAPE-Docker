FROM ubuntu:latest
MAINTAINER td115@duke.edu

ENV workdir /usr
WORKDIR ${workdir}

ENV PACKAGES wget git ca-certificates rsync ssh\
             make gcc g++ cmake \
             libboost-all-dev \
             gsl-bin libgsl0-dbg libgsl0-dev libgsl23 \
             zlib1g-dev libcr-dev mpich mpich-doc 

RUN apt-get update && \
    apt-get install -y --no-install-recommends ${PACKAGES}

#RUN mkdir -p ${workdir} && cd ${workdir}

RUN mkdir ${workdir}/downloads
RUN mkdir ${workdir}/output

RUN wget -P ${workdir}/downloads http://home.thep.lu.se/~torbjorn/pythia8/pythia8235.tgz &&\
    cd ${workdir}/downloads &&\
    tar xvfz pythia8235.tgz &&\
    cd pythia8235 &&\
    ./configure --prefix=/usr/local &&\
    make -j8 &&\
    make install  

RUN wget -P ${workdir}/downloads http://hepmc.web.cern.ch/hepmc/releases/hepmc3.0.0.tgz &&\
    cd ${workdir}/downloads &&\
    tar -xvzf hepmc3.0.0.tgz &&\
    cd hepmc3.0.0/cmake &&\
    cmake --prefix=/usr/local .. &&\
    make -j16 &&\
    make install 

RUN wget -P ${workdir}/downloads https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.4/src/hdf5-1.10.4.tar.gz &&\
    cd ${workdir}/downloads &&\
    tar -xvzf hdf5-1.10.4.tar.gz &&\  
    cd hdf5-1.10.4 &&\
    ./configure --prefix=/usr/local --enable-cxx &&\
    make -j8 &&\
    make install

RUN rm -rf ${workdir}/downloads

ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

COPY JETSCAPE ${workdir}/JETSCAPE

RUN cd ${workdir}/JETSCAPE &&\
    mkdir ${workdir}/JETSCAPE/build &&\
    cd ${workdir}/JETSCAPE/build &&\
    cmake .. &&\
    make -j8

COPY work.sh ${workdir}
RUN chmod +x ${workdir}/work.sh


