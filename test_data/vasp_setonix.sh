#!/bin/bash -l
#SBATCH --job-name=aIi02NEB1
#SBATCH --account=pawsey1141
#SBATCH --partition=work        #job queue
#SBATCH --ntasks=100				#total no. of cpus requested
#SBATCH --ntasks-per-node=100	#no. of cpus/node
##SBATCH --exclusive			#uncomment if using a full node (nstasks=128)
#SBATCH --cpus-per-task=1
#SBATCH --mem=100G				#memory limit per node (here 1GB per cpu)
#SBATCH --time=24:00:00          #walltime; max for work/highmem is 24h, 96h for long
#SBATCH --output=slurm.out      #slurm output file

# VASP.6.4.3
module load hdf5/1.14.3-api-v112 netlib-scalapack/2.2.0 fftw/3.3.10
export VASP=/software/projects/pawsey1141/cverdi/vasp.6.4.3-vtst/bin/vasp_std
# VASP.6.5.1 (comment above and uncomment below)
#module load hdf5/1.14.3-parallel-api-v112 netlib-scalapack/2.2.0 fftw/3.3.10
#export VASP=/software/projects/pawsey1141/cverdi/vasp.6.5.1/bin/vasp_std

# OpenMP settings
export OMP_NUM_THREADS=1   #To define the number of threads
#Settings for MPI jobs
export MPICH_OFI_STARTUP_CONNECT=1
export MPICH_OFI_VERBOSE=1
# Temporal workaround for avoiding Slingshot issues on shared nodes:
export FI_CXI_DEFAULT_VNI=$(od -vAn -N4 -tu < /dev/urandom)
# The ulimit command is required because VASP uses a large amount of stack memory in addition to heap memory. This does not unlock more physical memory.
ulimit -s unlimited

srun -N $SLURM_JOB_NUM_NODES -n $SLURM_NTASKS -c $OMP_NUM_THREADS -m block:block:block $VASP > vasp.out

echo "rsync -avzP --exclude={WAVECAR,CHGCAR,CHG} /scratch/pawsey1141/ctweedie/Calculations/ uqctwee1@bunya.rcc.uq.edu.au:/QRISdata/Q8655/Calculations/"
echo "rsync -avzP --exclude={WAVECAR,CHGCAR,CHG} /scratch/pawsey1141/ctweedie/Calculations/ uqctwee1@bunya.rcc.uq.edu.au:/scratch/project_mnt/S0204/connor/Calculations/"
echo "rsync -avzP --exclude={WAVECAR,CHGCAR,CHG} /scratch/pawsey1141/ctweedie/Calculations/ ct9450@gadi.nci.org.au:/scratch/im26/ct9450/Calculations/"