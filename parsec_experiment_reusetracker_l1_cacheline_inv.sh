#! /bin/bash
wget https://parsec.cs.princeton.edu/download/3.0/parsec-3.0.tar.gz
tar xvfz parsec-3.0.tar.gz

parsec-3.0/bin/parsecmgmt -a build -p bodytrack -c gcc-openmp
parsec-3.0/bin/parsecmgmt -a build -p fluidanimate -c gcc-pthreads
patch -p0 -f < parsec-3.0-facesim.patch
parsec-3.0/bin/parsecmgmt -a build -p facesim -c gcc-pthreads
parsec-3.0/bin/parsecmgmt -a build -p blackscholes -c gcc-openmp
parsec-3.0/bin/parsecmgmt -a build -p freqmine -c gcc-openmp
parsec-3.0/bin/parsecmgmt -a build -p raytrace -c gcc-pthreads
parsec-3.0/bin/parsecmgmt -a build -p swaptions -c gcc-pthreads
parsec-3.0/bin/parsecmgmt -a build -p vips -c gcc-pthreads
parsec-3.0/bin/parsecmgmt -a build -p x264 -c gcc-pthreads
parsec-3.0/bin/parsecmgmt -a build -p canneal -c gcc-pthreads
./fix_dedup_error.sh
parsec-3.0/bin/parsecmgmt -a build -p dedup -c gcc-pthreads
parsec-3.0/bin/parsecmgmt -a build -p streamcluster -c gcc-pthreads

./blackscholes_l1_run_cacheline_inv.sh
./bodytrack_l1_run_cacheline_inv.sh
./dedup_l1_run_cacheline_inv.sh
./facesim_l1_run_cacheline_inv.sh
./fluidanimate_l1_run_cacheline_inv.sh
./freqmine_l1_run_cacheline_inv.sh
./streamcluster_l1_run_cacheline_inv.sh
./swaptions_l1_run_cacheline_inv.sh
./vips_l1_run_cacheline_inv.sh
