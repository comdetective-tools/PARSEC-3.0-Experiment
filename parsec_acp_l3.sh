#! /bin/bash

./streamcluster_l3_run_cacheline_inv_gold.sh
./streamcluster_l3_run_cacheline_inv_gold_spatial.sh
./freqmine_l3_run_cacheline_inv_gold.sh
./freqmine_l3_run_cacheline_inv_gold_spatial.sh
mkdir run1
mv *_rd*_l*_output run1
./streamcluster_l3_run_cacheline_inv_gold.sh
./streamcluster_l3_run_cacheline_inv_gold_spatial.sh
./freqmine_l3_run_cacheline_inv_gold.sh
./freqmine_l3_run_cacheline_inv_gold_spatial.sh
mkdir run2
mv *_rd*_l*_output run2
