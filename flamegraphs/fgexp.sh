name="WaSH"
if [[ $1 == "sphexa" ]]; then
    perf record -F 99 -g -- ../../sph-exa-build/main/src/sphexa/sphexa --init sedov --prop std -w 0 -n 50 -t 100
    name="SPH-EXA"
else
    perf record -F 99 -g -- ../../wash/build/sedov_wone 50 100
    name="WaSH"
fi 

perf script > out.perf


../../fg/FlameGraph-master/stackcollapse-perf.pl out.perf > $name.folded


../../fg/FlameGraph-master/flamegraph.pl --bgcolors grey --title "$name Flame Graph" --flamechart --width 1600 --height 50 $name.folded > $name.svg