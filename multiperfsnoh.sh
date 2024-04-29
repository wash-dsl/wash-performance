
# 3 repeats
# Each of 4 versions
# 3 different timesteps
# Sedov types:
# "sedov_wone" "sedov_cstone" "sedov_west" "sedov_wisb" "sedov_wser" 

# cpu-batch
# for rep in 1
# do
#     for size in 300
#     do 
#         for version in "sphexa" #"sphexa" "sedov_wone" "sedov_cstone" "sedov_west" "sedov_wser" "sedov_wisb"
#         do
#             for timestep in 100
#             do
#                 for numthreads in 8 4 2 1
#                 do
#                     for nodes in 1
#                         do
#                         ./perftest.sh $version $size $timestep $numthreads $nodes
#                     done
#                 done
#             done
#         done
#     done
# done


for rep in 1 2
do
    for size in 200
    do 
        for version in "sphexa" "noh_wone" #"sedov_cstone" # #"sedov_wone" "sedov_cstone" "sedov_wser"
        do
            for timestep in 100
            do
                for numthreads in 40 16
                do
                    for nodes in 1 4 2 3 5
                        do
                        ./perftestnoh.sh $version $size $timestep $numthreads $nodes
                    done
                done
            done
        done
    done
done