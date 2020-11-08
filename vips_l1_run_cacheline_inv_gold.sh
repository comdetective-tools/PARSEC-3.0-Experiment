#! /bin/bash

ReuseTracker_path=/home/msasongko17/reusetracker/hpctoolkit-bin

parsec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p vips -i native -n 32
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" parsec-3.0/pkgs/apps/vips/inst/amd64-linux.gcc-pthreads/bin/vips im_benchmark parsec-3.0/pkgs/apps/vips/run/orion_18000x18000.v parsec-3.0/pkgs/apps/vips/run/output.v 2>&1 | tee vips_log

HPCRUN_WP_REUSE_PROFILE_TYPE="TEMPORAL" HPCRUN_PROFILE_L3=false HPCRUN_WP_REUSE_BIN_SCHEME=4000,2 HPCRUN_WP_CACHELINE_INVALIDATION=true OMP_NUM_THREADS=32 HPCRUN_THREAD_LOCALITY_MAPPING=0%2%4%6%8%10%12%14%16%18%20%22%24%26%28%30#1%3%5%7%9%11%13%15%17%19%21%23%25%27%29%31 /usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ReuseTracker_path/bin/hpcrun --mapping 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31 -e WP_REUSETRACKER -e MEM_UOPS_RETIRED:ALL_LOADS@100000 -e MEM_UOPS_RETIRED:ALL_STORES@100000 -o vips_l1_output parsec-3.0/pkgs/apps/vips/inst/amd64-linux.gcc-pthreads/bin/vips im_benchmark parsec-3.0/pkgs/apps/vips/run/orion_18000x18000.v parsec-3.0/pkgs/apps/vips/run/output.v  2>&1 | tee vips_reusetracker_log

TRACE_FILE=$(ls -lt | grep reuse.hpcrun | awk '{print $9}')

cat overhead.tmp | tee -a $TRACE_FILE >/dev/null

mkdir vips_rd_l1_output

mv *hpcrun vips_rd_l1_output

$ReuseTracker_path/bin/hpcstruct parsec-3.0/pkgs/apps/vips/inst/amd64-linux.gcc-pthreads/bin/vips

$ReuseTracker_path/bin/hpcprof -S ./vips.hpcstruct -o vips_l1_database vips_l1_output

mv vips.hpcstruct vips_rd_l1_output

mv vips_l1_database vips_rd_l1_output
