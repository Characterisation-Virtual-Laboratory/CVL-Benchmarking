#!/bin/bash
#SBATCH --job-name=V100MPI3GPU
#SBATCH --account=br76
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:V100:3
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

nvidia-smi -l 1 -q -x -f /home/userName/br76_scratch/relion21_tutorial/pMOSP/nvidiaLogging-m3g-MPI-3.xml &
# Get its PID
nvidiaPID=$!

module load relion/3.0-stable-cuda91
module load motioncor2/2.1.10-cuda9.1

srun -n 3 `which relion_run_motioncorr_mpi` --i Import/job001/movies.star --o JMotionCor/job-m3g-MPI-3/ --save_movies  --first_frame_sum 1 --last_frame_sum 0 --use_motioncor2 --bin_factor 1 --motioncor2_exe /usr/local/motioncor2/2.1.10-cuda9.1/bin/MotionCor2_1.1.0-Cuda91 --bfactor 150 --angpix 1 --patch_x 3 --patch_y 3 --other_motioncor2_args " -PixSize 0.97 " --gpu "" --dose_weighting --voltage 300 --dose_per_frame 1 --preexposure 0

kill $nvidiaPID

