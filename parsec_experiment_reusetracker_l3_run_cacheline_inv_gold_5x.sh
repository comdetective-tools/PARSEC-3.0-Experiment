#! /bin/bash

./parsec_experiment_reusetracker_l3_run_cacheline_inv_gold.sh
mkdir temporal_run1
mv *_rd_l3_output temporal_run1
rm -r *_output
./parsec_experiment_reusetracker_l3_run_cacheline_inv_gold.sh
mkdir temporal_run2
mv *_rd_l3_output temporal_run2
rm -r *_output
./parsec_experiment_reusetracker_l3_run_cacheline_inv_gold.sh
mkdir temporal_run3
mv *_rd_l3_output temporal_run3
rm -r *_output
./parsec_experiment_reusetracker_l3_run_cacheline_inv_gold.sh
mkdir temporal_run4
mv *_rd_l3_output temporal_run4
rm -r *_output
./parsec_experiment_reusetracker_l3_run_cacheline_inv_gold.sh
mkdir temporal_run5
mv *_rd_l3_output temporal_run5
rm -r *_output
