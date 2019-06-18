#!/bin/bash
#SBATCH --job-name=K80SEM6GPU
#SBATCH --account=br76
#SBATCH --time=03:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=7
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:K80:6
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

nvidia-smi -l 1 -q -x -f /home/userName/br76_scratch/relion21_tutorial/pMOSP/nvidiaLoggingSEM-m3e-6.xml &
# Get its PID
nvidiaPID=$!

bash /home/userName/scripts/motionCor2_1.1.0Cuda91SEM.sh "/home/userName/br76_scratch/relion21_tutorial/pMOSP/Micrographs/*.mrcs" "/home/userName/br76_scratch/relion21_tutorial/pMOSP/JMotionCor/job-m3e-SEM-6/" 0 600 6 6

kill $nvidiaPID

