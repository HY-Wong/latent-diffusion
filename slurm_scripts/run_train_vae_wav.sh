#!/bin/bash
#SBATCH -p gpu17
#SBATCH --gres gpu:2
#SBATCH --nodes 8
#SBATCH --ntasks-per-node 2
#SBATCH -t 0-08:00:0
#SBATCH -o train_vae_wav_output_%j.log
#SBATCH -e train_vae_wav_error_%j.log

# activate Conda environment
source ~/.bashrc
conda activate ldm-new  

cd ..

cmd="python3 main_wav.py --base configs/autoencoder/autoencoder_kl-wav_16x16x16.yaml \
 --num_nodes $SLURM_JOB_NUM_NODES --max_ep 150 \
 --name ch1-2-4_baseline \
 --resume logs/ch1-2-4_baseline/last.ckpt --wandb_id zkrbwrm6"

# print start time and command to log
echo $(date)
echo $cmd

# start command
srun $cmd
