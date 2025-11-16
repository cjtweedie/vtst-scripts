#!/bin/bash -l
#SBATCH --job-name=NEB_analysis
#SBATCH --account=pawsey1141
#SBATCH --partition=debug        #job queue
#SBATCH --ntasks=1				#total no. of cpus requested
#SBATCH --ntasks-per-node=1	#no. of cpus/node
##SBATCH --exclusive			#uncomment if using a full node (nstasks=128)
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G				#memory limit per node (here 1GB per cpu)
#SBATCH --time=00:30:00          #walltime; max for work/highmem is 24h, 96h for long
#SBATCH --output=slurm.out      #slurm output file
ulimit -s unlimited

module load perl/5.40.0
module load gcc-native/14.2
module load gnuplot/6.0.0
module load hdf5/1.14.3-api-v112 netlib-scalapack/2.2.0 fftw/3.3.10
export VASP=/software/projects/pawsey1141/cverdi/vasp.6.4.3-vtst/bin/vasp_std


# generates the N image POSCARs by linear interpolation between initial/final structures
#perl /scratch/pawsey1141/ctweedie/vtstscripts_v2/nebmake.pl POSCAR_i POSCAR_f 5
#python /scratch/pawsey1141/ctweedie/vtstscripts_v2/nebmake.py POSCAR_i POSCAR_f 5 -NOIDPP

# cleans up results and puts output files into output folder for further analysis
# make sure to name output folder "output"
#perl /scratch/pawsey1141/ctweedie/vtstscripts_v2/vfin.pl output2

# runs all the analysis scripts on the cleaned up data
# need to place this into the output dir created by vfin.pl
# nebconverge.pl - monitors convergence of each image calc during job run
# nebef.pl - extracts total energies, forces of all images
# nebbarrier.pl - generates neb.dat file containing image distances, image energy, force along entire band
# nebspline.pl - reads neb.dat to generate splines to fit curve to image energy data
# nebmovie.pl - creates animation of the minimum energy path in xyz files
cd ./output2
perl /scratch/pawsey1141/ctweedie/vtstscripts_v2/nebresults.pl
cd ..

# calculates average distance between two images (in Angstroms)
#perl /scratch/pawsey1141/ctweedie/vtstscripts_v2/dist.pl ./00/POSCAR ./04/POSCAR