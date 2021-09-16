#! /bin/bash

ReuseTracker_path=/home/msasongko17/Documents/hpctoolkit-bin

parsec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p fluidanimate -i native -n 32
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" parsec-3.0/pkgs/apps/fluidanimate/inst/amd64-linux.gcc-pthreads/bin/fluidanimate 32 500 parsec-3.0/pkgs/apps/fluidanimate/run/in_500K.fluid parsec-3.0/pkgs/apps/fluidanimate/run/out.fluid 2>&1 | tee fluidanimate_log

HPCRUN_WP_REUSE_PROFILE_TYPE="TEMPORAL" HPCRUN_PROFILE_L3=true HPCRUN_WP_REUSE_BIN_SCHEME=4000,2 HPCRUN_WP_CACHELINE_INVALIDATION=true HPCRUN_THREAD_LOCALITY_MAPPING=0%2%4%6%8%10%12%14%16%18%20%22%24%26%28%30#1%3%5%7%9%11%13%15%17%19%21%23%25%27%29%31 /usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ReuseTracker_path/bin/hpcrun --mapping 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31 -e WP_REUSETRACKER -e MEM_UOPS_RETIRED:ALL_LOADS@5000000 -e MEM_UOPS_RETIRED:ALL_STORES@5000000 -o fluidanimate_l3_output parsec-3.0/pkgs/apps/fluidanimate/inst/amd64-linux.gcc-pthreads/bin/fluidanimate 32 500 parsec-3.0/pkgs/apps/fluidanimate/run/in_500K.fluid parsec-3.0/pkgs/apps/fluidanimate/run/out.fluid 2>&1 | tee fluidanimate_reusetracker_log

TRACE_FILE=$(ls -lt | grep reuse.hpcrun | awk '{print $9}')

cat overhead.tmp | tee -a $TRACE_FILE >/dev/null

mkdir fluidanimate_rd_l3_output

mv *hpcrun fluidanimate_rd_l3_output

$ReuseTracker_path/bin/hpcstruct parsec-3.0/pkgs/apps/fluidanimate/inst/amd64-linux.gcc-pthreads/bin/fluidanimate

$ReuseTracker_path/bin/hpcprof -S ./fluidanimate.hpcstruct -o fluidanimate_l3_database fluidanimate_l3_output

mv fluidanimate.hpcstruct fluidanimate_rd_l3_output

mv fluidanimate_l3_database fluidanimate_rd_l3_output
