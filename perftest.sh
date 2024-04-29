# Usage:    ./perftest.sh <version> <n_particles> <timestep> <numthreads>
# Example:  ./perftest.sh sedov_cstone 20 0.5 16 
#           ./perftest.sh sphexa 20 0.5 16      

version=$1
n_particles=$2
timestep=$3
numthreads=$4
nodes=$5

# if version is sphexa or sphexa-cuda

if [ $version == "sphexa" ] || [ $version == "sphexa-cuda" ]
then
    sourcedir="../sph-exa-build/main/src/sphexa"
else
    sourcedir="../wash/build"
fi

# sbatch save output to var
# echo "sbatch oneperf.sbatch --job-name=$1 --output=out/$1/$1_$2_$3_$i_%j.out $sourcedir/$1 $n_particles $timestep'"
# jobname=$(sbatch oneperf.sbatch --job-name=$1 --output=out/$1/$1_$2_$3_$i_%j.out $sourcedir/$1 $n_particles $timestep)    

# if mpi argument is passed
# if [ $5 == "mpi" ]
# then
#     jobname=$(sbatch oneperfmpi.sbatch $sourcedir/$1 $n_particles $timestep $numthreads $5)
# else
#     jobname=$(sbatch oneperfmpi.sbatch $sourcedir/$1 $n_particles $timestep $numthreads)
# fi
if [ $version == "sphexa" ]
then
    jobname=$(sbatch oneperfmpi$nodes.sbatch $sourcedir/$version $n_particles $timestep $numthreads $nodes)
else
    jobname=$(sbatch oneperfmpi$nodes.sbatch $sourcedir/$version $n_particles $timestep $numthreads $nodes)
fi
# jobname=$(sbatch oneperf.sbatch $sourcedir/$1 $n_particles $timestep $numthreads)
# change version if it's sphexa-cuda

# if [ $version == "sphexa" ]
# then
#     version="sphexa_cuda_nogpu"
# fi
jobname=$(echo $jobname | grep -oP '(?<=\s)\d+')
mkdir -p out/$version
echo "slurm-$jobname.out" >> out/$version/$2-$3-$4-$5-no-out-jobs.txt
echo $jobname