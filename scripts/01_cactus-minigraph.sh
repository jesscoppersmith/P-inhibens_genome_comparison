#!/bin/bash
#SBATCH --job-name="cactus-minigraph"
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
jobStorePath=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/cactus/JobStore
outGFA=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/cactus/P-inhibens.gfa

module load Cactus
module list

cactus-minigraph $jobStorePath ./GenomeIDs.txt $outGFA --reference P54 --binariesMode=local

echo "script finished running at: "; date
