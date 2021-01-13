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
parsec-3.0/bin/parsecmgmt -a build -p ferret -c gcc-pthreads

ComDetective_path=/home/msasongko17/reusetracker/hpctoolkit-bin

parsec-3.0/bin/parsecmgmt -a run -c gcc-openmp -p bodytrack -i native -n 32
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" parsec-3.0/pkgs/apps/bodytrack/inst/amd64-linux.gcc-openmp/bin/bodytrack parsec-3.0/pkgs/apps/bodytrack/run/sequenceB_261 4 261 4000 5 0 32 2>&1 | tee bodytrack_log

/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ComDetective_path/bin/ComDetectiverun -o bodytrack_output parsec-3.0/pkgs/apps/bodytrack/inst/amd64-linux.gcc-openmp/bin/bodytrack parsec-3.0/pkgs/apps/bodytrack/run/sequenceB_261 4 261 4000 5 0 32 2>&1 | tee bodytrack_comdetective_log


parsec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p fluidanimate -i native -n 32
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" parsec-3.0/pkgs/apps/fluidanimate/inst/amd64-linux.gcc-pthreads/bin/fluidanimate 32 500 parsec-3.0/pkgs/apps/fluidanimate/run/in_500K.fluid parsec-3.0/pkgs/apps/fluidanimate/run/out.fluid 2>&1 | tee fluidanimate_log

/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ComDetective_path/bin/ComDetectiverun -o fluidanimate_output parsec-3.0/pkgs/apps/fluidanimate/inst/amd64-linux.gcc-pthreads/bin/fluidanimate 32 500 parsec-3.0/pkgs/apps/fluidanimate/run/in_500K.fluid parsec-3.0/pkgs/apps/fluidanimate/run/out.fluid 2>&1 | tee fluidanimate_comdetective_log


parsec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p facesim -i native -n 32 
cp -r parsec-3.0/pkgs/apps/facesim/run/* .
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" parsec-3.0/pkgs/apps/facesim/inst/amd64-linux.gcc-pthreads/bin/facesim -timing -threads 32 -lastframe 100 2>&1 | tee facesim_log

/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ComDetective_path/bin/ComDetectiverun -o facesim_output parsec-3.0/pkgs/apps/facesim/inst/amd64-linux.gcc-pthreads/bin/facesim -timing -threads 32 -lastframe 100 2>&1 | tee facesim_comdetective_log


parsec-3.0/bin/parsecmgmt -a run -c gcc-openmp -p blackscholes -i native -n 32
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M"  parsec-3.0/pkgs/apps/blackscholes/inst/amd64-linux.gcc-openmp/bin/blackscholes 32 parsec-3.0/pkgs/apps/blackscholes/run/in_10M.txt parsec-3.0/pkgs/apps/blackscholes/run/prices.txt 2>&1 | tee blackscholes_log

/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ComDetective_path/bin/ComDetectiverun -o blackscholes_output parsec-3.0/pkgs/apps/blackscholes/inst/amd64-linux.gcc-openmp/bin/blackscholes 32 parsec-3.0/pkgs/apps/blackscholes/run/in_10M.txt parsec-3.0/pkgs/apps/blackscholes/run/prices.txt 2>&1 | tee blackscholes_comdetective_log


parsec-3.0/bin/parsecmgmt -a run -c gcc-openmp -p freqmine -i native -n 32
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M"  parsec-3.0/pkgs/apps/freqmine/inst/amd64-linux.gcc-openmp/bin/freqmine parsec-3.0/pkgs/apps/freqmine/run/webdocs_250k.dat 11000 2>&1 | tee freqmine_log

/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ComDetective_path/bin/ComDetectiverun -o freqmine_output parsec-3.0/pkgs/apps/freqmine/inst/amd64-linux.gcc-openmp/bin/freqmine parsec-3.0/pkgs/apps/freqmine/run/webdocs_250k.dat 11000 2>&1 | tee freqmine_comdetective_log


#parsec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p raytrace -i native -n 32
parsec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p swaptions -i native -n 32
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" parsec-3.0/pkgs/apps/swaptions/inst/amd64-linux.gcc-pthreads/bin/swaptions -ns 128 -sm 1000000 -nt 32 2>&1 | tee swaptions_log

/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ComDetective_path/bin/ComDetectiverun -o swaptions_output parsec-3.0/pkgs/apps/swaptions/inst/amd64-linux.gcc-pthreads/bin/swaptions -ns 128 -sm 1000000 -nt 32  2>&1 | tee swaptions_comdetective_log



parsec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p vips -i native -n 32
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" parsec-3.0/pkgs/apps/vips/inst/amd64-linux.gcc-pthreads/bin/vips im_benchmark parsec-3.0/pkgs/apps/vips/run/orion_18000x18000.v parsec-3.0/pkgs/apps/vips/run/output.v 2>&1 | tee vips_log

/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ComDetective_path/bin/ComDetectiverun -o vips_output parsec-3.0/pkgs/apps/vips/inst/amd64-linux.gcc-pthreads/bin/vips im_benchmark parsec-3.0/pkgs/apps/vips/run/orion_18000x18000.v parsec-3.0/pkgs/apps/vips/run/output.v  2>&1 | tee vips_comdetective_log


#parsec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p canneal -i native -n 32
parsec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p dedup -i native -n 32
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" parsec-3.0/pkgs/kernels/dedup/inst/amd64-linux.gcc-pthreads/bin/dedup -c -p -v -t 32 -i parsec-3.0/pkgs/kernels/dedup/run/FC-6-x86_64-disc1.iso -o parsec-3.0/pkgs/kernels/dedup/run/output.dat.ddp 2>&1 | tee dedup_log

/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ComDetective_path/bin/ComDetectiverun -o dedup_output parsec-3.0/pkgs/kernels/dedup/inst/amd64-linux.gcc-pthreads/bin/dedup -c -p -v -t 32 -i parsec-3.0/pkgs/kernels/dedup/run/FC-6-x86_64-disc1.iso -o parsec-3.0/pkgs/kernels/dedup/run/output.dat.ddp 2>&1 | tee dedup_comdetective_log



parec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p streamcluster -i native -n 32
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" parsec-3.0/pkgs/kernels/streamcluster/inst/amd64-linux.gcc-pthreads/bin/streamcluster 10 20 128 1000000 200000 5000 none output.txt 32 2>&1 | tee streamcluster_log

/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ComDetective_path/bin/ComDetectiverun -o streamcluster_output parsec-3.0/pkgs/kernels/streamcluster/inst/amd64-linux.gcc-pthreads/bin/streamcluster 10 20 128 1000000 200000 5000 none output.txt 32 2>&1 | tee streamcluster_comdetective_log
