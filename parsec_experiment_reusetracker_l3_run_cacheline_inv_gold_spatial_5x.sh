#! /bin/bash

./parsec_experiment_reusetracker_l3_run_cacheline_inv_gold_spatial.sh
mkdir run1
mv *_rd_l3_output run1
rm -r *_output
./parsec_experiment_reusetracker_l3_run_cacheline_inv_gold_spatial.sh
mkdir run2
mv *_rd_l3_output run2
rm -r *_output
./parsec_experiment_reusetracker_l3_run_cacheline_inv_gold_spatial.sh
mkdir run3
mv *_rd_l3_output run3
rm -r *_output
./parsec_experiment_reusetracker_l3_run_cacheline_inv_gold_spatial.sh
mkdir run4
mv *_rd_l3_output run4
rm -r *_output
./parsec_experiment_reusetracker_l3_run_cacheline_inv_gold_spatial.sh
mkdir run5
mv *_rd_l3_output run5
rm -r *_output
