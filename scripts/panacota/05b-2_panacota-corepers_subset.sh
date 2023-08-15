#!/bin/bash
#SBATCH --job-name="panacota-corepers-subset2"
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

OUT_DIR=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/corepers-subset_out
PANGENOME=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/pangenome_out/PanGenome-PHIN37.All.prt-clust-0.8-mode1-th16.lst
LSTINFO=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/pangenome_out/LSTINFO_Probionts_w-outgroup.lst

module purge
module load PanACoTA
module list

PanACoTA corepers -p $PANGENOME -o $OUT_DIR -l $LSTINFO


#-p output from previous PANGENOME step
#-o <path/to/outdir>: path to the directory where you want to put the corepers results (and temporary files)
#-l lstinfo_file indicates a subset of the data to run corepers on instead of the whole pangenome genomes

echo "script finished running at: "; date
