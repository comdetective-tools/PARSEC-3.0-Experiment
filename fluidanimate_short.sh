#! /bin/bash

mkdir fluidanimate_rd_200K_output

mv *hpcrun fluidanimate_rd_200K_output

$ReuseTracker_path/bin/hpcstruct parsec-3.0/pkgs/apps/fluidanimate/inst/amd64-linux.gcc-pthreads/bin/fluidanimate

$ReuseTracker_path/bin/hpcprof -S ./fluidanimate.hpcstruct -o fluidanimate_database fluidanimate_output

mv fluidanimate.hpcstruct fluidanimate_rd_200K_output

mv fluidanimate_database fluidanimate_rd_200K_output
