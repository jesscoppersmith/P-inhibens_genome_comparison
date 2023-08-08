#!/bin/bash
#SBATCH --job-name="panacota-tree"
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

OUT_DIR=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/tree-subset_out
ALIGN_FILE=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/align-subset_out/Phylo-PHIN37_0.9/PHIN37_0.9.nucl.grp.STRAINS.aln
threads=16

module purge
module load PanACoTA
module list

PanACoTA tree -a $ALIGN_FILE -o $OUT_DIR --boot 1000 --threads $threads

#-a alignment file from align step
#-o <resdir>: directory where you want to have the temporary and result files
#--boot number of bootstraps to compute, default is none, minimum is 1000

echo "script finished running at: "; date
