#!/bin/bash
#SBATCH --job-name=K80GNU3GPU
#SBATCH --account=br76
#SBATCH --time=01:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:K80:3
#SBATCH --partition=m3e
#SBATCH --mem=228GB
# To receive an email when job completes or fails
#SBATCH --mail-user=firstname.lastname@monash.edu
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

# Set the file for output (stdout)
#SBATCH --output=MyJob-%j.out

# Set the file for error log (stderr)
#SBATCH --error=MyJob-%j.err

export CUDA_CACHE_DISABLE=1

nvidia-smi -l 1 -q -x -f /home/userName/br76_scratch/relion21_tutorial/pMOSP/nvidiaLogging-m3e-GNU-3.xml &
# Get its PID
nvidiaPID=$!

module load gnuparallel/20190122
module load motioncor2/2.1.10-cuda9.1

#--link
#parallel -j2 --link echo " -InSuffix {1} -Gpu {2}"  ::: *0_movie.mrcs *1_movie.mrcs ::: 0 1
#-InSuffix *0_movie.mrcs -Gpu 0
#-InSuffix *1_movie.mrcs -Gpu 1
parallel -j3 --link MotionCor2_1.1.0-Cuda91 -InMrc /projects/m3home/userName/br76_scratch/relion21_tutorial/pMOSP/Micrographs/ -InSuffix {1} -OutMrc /projects/m3home/userName/br76_scratch/relion21_tutorial/pMOSP/JMotionCor/job-m3e-GNU-3/ -Patch 3 3 -Gpu {2} -Serial 1 -FmRef 1 -RotGain 0 -FlipGain 0 -Iter 7 -Tol 0.5 -Bft 150 -StackZ 0 -FtBin 1.0 -InitDose 0 -FmDose 1.0 -PixSize 0.97 -kV 300 -Throw 0 -Trunc 0 -Group 0 ::: 0_movie.mrcs 1_movie.mrcs 2_movie.mrcs ::: 0 1 2

parallel -j3 --link MotionCor2_1.1.0-Cuda91 -InMrc /projects/m3home/userName/br76_scratch/relion21_tutorial/pMOSP/Micrographs/ -InSuffix {1} -OutMrc /projects/m3home/userName/br76_scratch/relion21_tutorial/pMOSP/JMotionCor/job-m3e-GNU-3/ -Patch 3 3 -Gpu {2} -Serial 1 -FmRef 1 -RotGain 0 -FlipGain 0 -Iter 7 -Tol 0.5 -Bft 150 -StackZ 0 -FtBin 1.0 -InitDose 0 -FmDose 1.0 -PixSize 0.97 -kV 300 -Throw 0 -Trunc 0 -Group 0 ::: 3_movie.mrcs 4_movie.mrcs 5_movie.mrcs ::: 0 1 2

parallel -j3 --link MotionCor2_1.1.0-Cuda91 -InMrc /projects/m3home/userName/br76_scratch/relion21_tutorial/pMOSP/Micrographs/ -InSuffix {1} -OutMrc /projects/m3home/userName/br76_scratch/relion21_tutorial/pMOSP/JMotionCor/job-m3e-GNU-3/ -Patch 3 3 -Gpu {2} -Serial 1 -FmRef 1 -RotGain 0 -FlipGain 0 -Iter 7 -Tol 0.5 -Bft 150 -StackZ 0 -FtBin 1.0 -InitDose 0 -FmDose 1.0 -PixSize 0.97 -kV 300 -Throw 0 -Trunc 0 -Group 0 ::: 6_movie.mrcs 7_movie.mrcs 8_movie.mrcs ::: 0 1 2

#1 task - 3 GPUs
parallel -j1 --link MotionCor2_1.1.0-Cuda91 -InMrc /projects/m3home/userName/br76_scratch/relion21_tutorial/pMOSP/Micrographs/ -InSuffix {1} -OutMrc /projects/m3home/userName/br76_scratch/relion21_tutorial/pMOSP/JMotionCor/job-m3e-GNU-3/ -Patch 3 3 -Gpu {2} -Serial 1 -FmRef 1 -RotGain 0 -FlipGain 0 -Iter 7 -Tol 0.5 -Bft 150 -StackZ 0 -FtBin 1.0 -InitDose 0 -FmDose 1.0 -PixSize 0.97 -kV 300 -Throw 0 -Trunc 0 -Group 0 ::: 9_movie.mrcs ::: "0 1 2"

kill $nvidiaPID
