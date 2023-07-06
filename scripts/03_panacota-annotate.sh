#!/bin/bash
#SBATCH --job-name="panacota-annotate"
#SBATCH --time 100:00:00  # walltime limit (HH:MM:SS) # Upped from 4 -- 2023-04-18
#SBATCH --array=0
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=16
#SBATCH --mem=24G   # maximum memory used per node # upped from 6G -- 2021-06-01
#SBATCH --mail-type=FAIL,END
#SBATCH --output="slurm-%x-%j.out"
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

RESULTS_DIR=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/annotation_out
INFO_FILE=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/QC_out/LSTINFO-NA-filtered-0.0001_0.06.txt

module purge
module load PanACoTA
module list

PanACoTA annotate --info $INFO_FILE -r $RESULTS_DIR -n PHIN 

echo "script finished running at: "; date
