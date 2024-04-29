#!/bin/bash
#
#SBATCH --job-name=wash-performance # Job name for tracking
#SBATCH --partition=cpu-batch  # Partition you wish to use (see above for list)
#SBATCH --cpus-per-task=40     # Number of CPU threads used by your job, set this upto 40 as required.
#SBATCH --mem=32000            # 60GB RAM
#SBATCH --exclusive=mcs        # Exclusive mode, only this job will run
#SBATCH --time=2-00:00:00      # Job time limit set to 2 days (48 hours)
#
#SBATCH --output=moreparticles_%j.out # Standard out from your job
#SBATCH --error=moreparticles_%j.err  # Standard error from your job

export OMP_NUM_THREADS=32

module load cs402-mpi
module load CUDA/11.4.4

./sedov_test.sh "$@"