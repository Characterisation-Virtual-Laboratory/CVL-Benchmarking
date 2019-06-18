#!/bin/bash
#SBATCH --job-name=V100GNU1GPU
#SBATCH --account=br76
#SBATCH --time=03:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:V100:1
#SBATCH --partition=rtqp
#SBATCH --qos=rtq
#SBATCH --mem=256GB
# To receive an email when job completes or fails
#SBATCH --mail-user=firstname.lastname@monash.edu
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

# Set the file for output (stdout)
#SBATCH --output=MyJob-%j.out

# Set the file for error log (stderr)
#SBATCH --error=MyJob-%j.err

nvidia-smi -l 1 -q -x -f /home/userName/br76_scratch/relion21_tutorial/pMOSP/nvidiaLogging-m3g-GNU-1.xml &
# Get its PID
nvidiaPID=$!

module load gnuparallel/20190122
module load motioncor2/2.1.10-cuda9.1

parallel -j1 MotionCor2_1.1.0-Cuda91 -InMrc /projects/m3home/userName/br76_scratch/relion21_tutorial/pMOSP/Micrographs/ -InSuffix {} -OutMrc /projects/m3home/userName/br76_scratch/relion21_tutorial/pMOSP/JMotionCor/job-m3g-GNU-1/ -Patch 3 3 -Gpu 0 -Serial 1 -FmRef 1 -RotGain 0 -FlipGain 0 -Iter 7 -Tol 0.5 -Bft 150 -StackZ 0 -FtBin 1.0 -InitDose 0 -FmDose 1.0 -PixSize 0.97 -kV 300 -Throw 0 -Trunc 0 -Group 0 ::: _movie.mrcs

kill $nvidiaPID

