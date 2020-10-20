#! /bin/bash

ReuseTracker_path=/home/msasongko17/reusetracker/hpctoolkit-bin

parsec-3.0/bin/parsecmgmt -a run -c gcc-pthreads -p dedup -i native -n 32
/usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" parsec-3.0/pkgs/kernels/dedup/inst/amd64-linux.gcc-pthreads/bin/dedup -c -p -v -t 32 -i parsec-3.0/pkgs/kernels/dedup/run/FC-6-x86_64-disc1.iso -o parsec-3.0/pkgs/kernels/dedup/run/output.dat.ddp 2>&1 | tee dedup_log

HPCRUN_WP_REUSE_PROFILE_TYPE="TEMPORAL" HPCRUN_PROFILE_L3=true HPCRUN_WP_REUSE_BIN_SCHEME=4000,2 HPCRUN_THREAD_LOCALITY_MAPPING=0,20%1,21%2,22%3,23%4,24%5,25%6,26%7,27#10,30%11,31%12,32%13,33%14,34%15,35%16,36%17,37 /usr/bin/time -f "Elapsed Time , %e, system, %S, user, %U, memory, %M" $ReuseTracker_path/bin/hpcrun --mapping 0,20,1,21,2,22,3,23,4,24,5,25,6,26,7,27,10,30,11,31,12,32,13,33,14,34,15,35,16,36,17,37 -e WP_REUSETRACKER -e MEM_LOAD_UOPS_RETIRED.L2_MISS@25000 -e MEM_UOPS_RETIRED:ALL_STORES@25000 -o dedup_output parsec-3.0/pkgs/kernels/dedup/inst/amd64-linux.gcc-pthreads/bin/dedup -c -p -v -t 32 -i parsec-3.0/pkgs/kernels/dedup/run/FC-6-x86_64-disc1.iso -o parsec-3.0/pkgs/kernels/dedup/run/output.dat.ddp 2>&1 | tee dedup_reusetracker_log

TRACE_FILE=$(ls -lt | grep reuse.hpcrun | awk '{print $9}')

cat overhead.tmp | tee -a $TRACE_FILE >/dev/null

mkdir dedup_rd_25K_output

mv *hpcrun dedup_rd_25K_output

$ReuseTracker_path/bin/hpcstruct parsec-3.0/pkgs/kernels/dedup/inst/amd64-linux.gcc-pthreads/bin/dedup

$ReuseTracker_path/bin/hpcprof -S ./dedup.hpcstruct -o dedup_database dedup_output

mv dedup.hpcstruct dedup_rd_25K_output

mv dedup_database dedup_rd_25K_output
