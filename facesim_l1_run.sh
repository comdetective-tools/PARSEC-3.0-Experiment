#! /bin/bash

ReuseTracker_path=/home/msasongko17/reusetracker/hpctoolkit-bin

parsec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p facesim -i native -n 32
cp -r parsec-3.0/pkgs/apps/facesim/run/* .
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" parsec-3.0/pkgs/apps/facesim/inst/amd64-linux.gcc-pthreads/bin/facesim -timing -threads 32 -lastframe 100 2>&1 | tee facesim_log

HPCRUN_WP_REUSE_PROFILE_TYPE="TEMPORAL" HPCRUN_PROFILE_L3=false HPCRUN_WP_REUSE_BIN_SCHEME=4000,2 HPCRUN_THREAD_LOCALITY_MAPPING=0,20%1,21%2,22%3,23%4,24%5,25%6,26%7,27#10,30%11,31%12,32%13,33%14,34%15,35%16,36%17,37 /usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ReuseTracker_path/bin/hpcrun --mapping 0,20,1,21,2,22,3,23,4,24,5,25,6,26,7,27,10,30,11,31,12,32,13,33,14,34,15,35,16,36,17,37 -e WP_REUSETRACKER -e MEM_LOAD_UOPS_RETIRED.L2_MISS@100000 -e MEM_UOPS_RETIRED:ALL_STORES@100000 -o facesim_l1_output parsec-3.0/pkgs/apps/facesim/inst/amd64-linux.gcc-pthreads/bin/facesim -timing -threads 32 -lastframe 100 2>&1 | tee facesim_reusetracker_log

TRACE_FILE=$(ls -lt | grep reuse.hpcrun | awk '{print $9}')

cat overhead.tmp | tee -a $TRACE_FILE >/dev/null

mkdir facesim_rd_l1_output

mv *hpcrun facesim_rd_l1_output

$ReuseTracker_path/bin/hpcstruct parsec-3.0/pkgs/apps/facesim/inst/amd64-linux.gcc-pthreads/bin/facesim

$ReuseTracker_path/bin/hpcprof -S ./facesim.hpcstruct -o facesim_l1_database facesim_l1_output

mv facesim.hpcstruct facesim_rd_l1_output

mv facesim_l1_database facesim_rd_l1_output
