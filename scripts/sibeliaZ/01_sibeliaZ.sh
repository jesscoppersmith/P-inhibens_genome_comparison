#!/bin/bash
#SBATCH --job-name="sibeliaZ"
#SBATCH --time 100:00:00  # walltime limit (HH:MM:SS) # Upped from 4 -- 2023-04-18
#SBATCH --array=0
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=16
#SBATCH --mem=24G   # maximum memory used per node # upped from 6G -- 2021-06-01
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=jcoppersmith@uri.edu

####################
# BEFORE YOU BEGIN #
####################
#########
# Setup #
#########

echo "script started running at: "; date
echo "Running on host:"; hostname

# Change as appropriate for your system and genome:
threads=16
INPUT_DIR=/home/jcoppersmith/data/src/phaeobacter_comparison_2023/genomes/genomicfna

module load SibeliaZ
module list

 # [-k <odd integer>] [-b <integer>] [-m <integer>] [-a <integer>] [-t <integer>] [-f <integer>] [-o <output_directory>] [-n] <input file>
sibeliaz -k 15  -a 201 -t $threads -n $INPUT_DIR/*
maf2synteny sibeliaz_out/blocks_coords.gff

echo "script finished running at: "; date
