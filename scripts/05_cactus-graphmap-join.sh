#!/bin/bash
#SBATCH --job-name="cactus-join"
#SBATCH --time 100:00:00  # walltime limit (HH:MM:SS) # Upped from 4 -- 2023-04-18
#SBATCH --array=0
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=16
#SBATCH --mem=24G   # maximum memory used per node # upped from 6G -- 2021-06-01
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=jcoppersmith@uri.edu
#SBATCH --output="slurm-%x-%j.out"

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
outDIR=data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/cactus/join
chromALIGN=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/cactus/chrom-alignments
chromHAL=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/cactus/chrom-alignments


module purge
module load Cactus
module list

cactus-graphmap-join $jobStorePath --vg $chromALIGN/*.vg --hal $chromHAL/*.hal \
--outDir $outDIR --outName P-inhibens-pg --reference P54 --vcf --giraffe clip --binariesMode=local


echo "script finished running at: "; date
