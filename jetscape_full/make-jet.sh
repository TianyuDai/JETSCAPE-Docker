#!/bin/bash

git clone https://github.com/TianyuDai/JETSCAPE.git
cd JETSCAPE
mkdir build
cd build
cmake ..
make -j 8
cd ..
chmod +x work.sh
./work.sh
