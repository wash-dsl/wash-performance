#!/bin/bash
#
#SBATCH --partition=cpu-batch  # Partition you wish to use (see above for list)
#SBATCH --mem=60000            # 60GB RAM
#SBATCH --exclusive=mcs        # Exclusive mode, only this job will run
#SBATCH --time=1-00:00:00      # Job time limit set to 2 days (48 hours)

#SBATCH --contiguous # Ensure nodes are allocated contiguously (not across multiple racks)
#SBATCH --nodes=5 # Number of compute nodes used by your job
#SBATCH --ntasks-per-node=1 # Number of tasks per node (used for MPI later)
#SBATCH --cpus-per-task=40 # Number of CPU cores used on each task (used for OpenMP)

#SBATCH --job-name=washperformance # Job name for tracking
#SBATCH --output=out/slurms/slurm-%j.out # Standard out from your job
#SBATCH --error=out/slurm_errs/slurm-%j.err  # Standard error from your job

program=$1
n_particles=$2
timestep=$3
numthreads=$4
nodes=$5

timenow=$(date +"%N")

export OMP_NUM_THREADS=$numthreads

module load cs402-mpi
module load CUDA/12.2
# Check sphexa in string
# timenow=$(date +"%Y-%m-%d-%H-%M-%S")
# outpath="./out/sphexa/dumps/$timenow/"
if [[ $program == *"sphexa"* ]]
then
    # If multiple nodes, mpirun. Otherwise, just run
    if [ $nodes -gt 1 ]
    then
    time_output=$(time -p (mpirun --bind-to none -np $nodes $program --init sedov --prop std -w 0 -o ./out/sphexa/dumps/$timenow.h5 -n $n_particles -s $timestep) 2>&1)
    else
        time_output=$(time -p ($program --init sedov --prop std -w 0 -o ./out/sphexa/dumps/$timenow.h5 -n $n_particles -s $timestep) 2>&1)
    fi
else 
    # If multiple nodes, mpirun. Otherwise, just run
    if [ $nodes -gt 1 ]
    then
        time_output=$(time -p (mpirun --bind-to none -np $nodes $program $n_particles $timestep) 2>&1)
    else
        time_output=$(time -p ($program $n_particles $timestep) 2>&1)
    fi
fi

real_time=$(echo "$time_output" | grep "real" | awk '{print $2}')
printf "%s\n\n" "$real_time"

printf "Params:"
printf "Program: %s\n" "$program"
printf "Particles: %s\n" "$n_particles"
printf "Timestep: %s\n" "$timestep"
printf "Numthreads: %s\n" "$numthreads"
printf "Nodes: %s\n" "$nodes"
printf "%s\n" "$time_output"
x=$(rm -rf ./out/sphexa/dumps/$timenow.h5)