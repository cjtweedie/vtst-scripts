#!/bin/bash
dir=$(pwd)/..
#echo $dir
#cd $dir
#pwd

# sets read/write/execute permissions on all script files for user, if need be
# NOTE: CHANGE THIS TO BE AN IF STATEMENT TO ONLY RUN IF PERMISSIONS ARE NOT SET
#chmod -R 755 $dir

# generates the N image POSCARs by linear interpolation between initial/final structures
#perl /scratch/pawsey1141/ctweedie/vtstscripts_v2/nebmake.pl POSCAR_i POSCAR_f 5
#python /scratch/pawsey1141/ctweedie/vtstscripts_v2/nebmake.py POSCAR_i POSCAR_f 5 -NOIDPP

# NOTE: FIND A WAY TO DO BOTH THESE COMMANDS SEQUENTIALLY IN ONE RUN WITHOUT USER COMMENTING/UNCOMMENTING

# cleans up results and puts output files into output folder for further analysis
# make sure to name output folder "output"
#perl /scratch/pawsey1141/ctweedie/vtstscripts_v2/vfin.pl output

# runs all the analysis scripts on the cleaned up data
# need to place this into the output dir created by vfin.pl
# nebconverge.pl - monitors convergence of each image calc during job run
# nebef.pl - extracts total energies, forces of all images
# nebbarrier.pl - generates neb.dat file containing image distances, image energy, force along entire band
# nebspline.pl - reads neb.dat to generate splines to fit curve to image energy data
# nebmovie.pl - creates animation of the minimum energy path in xyz files
cd ./output
perl $dir/nebresults.pl
cd ..

# calculates average distance between two images (in Angstroms)
#perl /scratch/pawsey1141/ctweedie/vtstscripts_v2/dist.pl ./00/POSCAR ./04/POSCAR