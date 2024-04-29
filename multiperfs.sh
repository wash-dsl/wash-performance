
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


for rep in 1 2 3 4
do
    for size in 100
    do 
        for version in "sphexa" "sedov_wone" #"sedov_cstone" # #"sedov_wone" "sedov_cstone" "sedov_wser"
        do
            for timestep in 100
            do
                for numthreads in 1
                do
                    for nodes in 12 11 1 10 2 9 3 8 4 7 5 6
                        do
                        ./perftestviper.sh $version $size $timestep $numthreads $nodes
                    done
                done
            done
        done
    done
done