#! /bin/bash

ReuseTracker_path=/home/msasongko17/reusetracker/hpctoolkit-bin

parsec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p fluidanimate -i native -n 32
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" parsec-3.0/pkgs/apps/fluidanimate/inst/amd64-linux.gcc-pthreads/bin/fluidanimate 32 500 parsec-3.0/pkgs/apps/fluidanimate/run/in_500K.fluid parsec-3.0/pkgs/apps/fluidanimate/run/out.fluid 2>&1 | tee fluidanimate_log

HPCRUN_WP_REUSE_PROFILE_TYPE="TEMPORAL" HPCRUN_PROFILE_L3=false HPCRUN_WP_REUSE_BIN_SCHEME=4000,2 HPCRUN_WP_CACHELINE_INVALIDATION=true HPCRUN_THREAD_LOCALITY_MAPPING=0,20%1,21%2,22%3,23%4,24%5,25%6,26%7,27#10,30%11,31%12,32%13,33%14,34%15,35%16,36%17,37 /usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ReuseTracker_path/bin/hpcrun --mapping 0,20,1,21,2,22,3,23,4,24,5,25,6,26,7,27,10,30,11,31,12,32,13,33,14,34,15,35,16,36,17,37 -e WP_REUSETRACKER -e MEM_LOAD_UOPS_RETIRED.L2_MISS@100000 -e MEM_UOPS_RETIRED:ALL_STORES@100000 -o fluidanimate_l1_output parsec-3.0/pkgs/apps/fluidanimate/inst/amd64-linux.gcc-pthreads/bin/fluidanimate 32 500 parsec-3.0/pkgs/apps/fluidanimate/run/in_500K.fluid parsec-3.0/pkgs/apps/fluidanimate/run/out.fluid 2>&1 | tee fluidanimate_reusetracker_log

TRACE_FILE=$(ls -lt | grep reuse.hpcrun | awk '{print $9}')

cat overhead.tmp | tee -a $TRACE_FILE >/dev/null

mkdir fluidanimate_rd_l1_output

mv *hpcrun fluidanimate_rd_l1_output

$ReuseTracker_path/bin/hpcstruct parsec-3.0/pkgs/apps/fluidanimate/inst/amd64-linux.gcc-pthreads/bin/fluidanimate

$ReuseTracker_path/bin/hpcprof -S ./fluidanimate.hpcstruct -o fluidanimate_l1_database fluidanimate_l1_output

mv fluidanimate.hpcstruct fluidanimate_rd_l1_output

mv fluidanimate_l1_database fluidanimate_rd_l1_output
