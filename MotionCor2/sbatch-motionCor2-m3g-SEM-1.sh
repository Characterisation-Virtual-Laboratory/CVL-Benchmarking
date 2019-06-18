#!/bin/bash
#SBATCH --job-name=V100SEM1GPU
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

nvidia-smi -l 1 -q -x -f /home/userName/br76_scratch/relion21_tutorial/pMOSP/nvidiaLogging-m3g-SEM-1.xml &
# Get its PID
nvidiaPID=$!

bash /home/userName/scripts/motionCor2_1.1.0Cuda91SEM.sh "/home/userName/br76_scratch/relion21_tutorial/pMOSP/Micrographs/*.mrcs" "/home/userName/br76_scratch/relion21_tutorial/pMOSP/JMotionCor/job-m3g-SEM-1/" 0 600 1 1

kill $nvidiaPID

