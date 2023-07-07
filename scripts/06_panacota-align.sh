#!/bin/bash
#SBATCH --job-name="panacota-align"
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

OUT_DIR=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/align_out
DB_DIR=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/annotation_out/
PERS_GENOME=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/corepers_out/PersGenome_PanGenome-PHIN37.All.prt-clust-0.8-mode1-th16.lst-all_1.lst
LIST_FILE=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/annotation_out/LSTINFO-LSTINFO-NA-filtered-0.0001_0.06.lst
THREADS=16

module purge
module load PanACoTA
module list

PanACoTA align -c $PERS_GENOME -l $LIST_FILE -n PHIN37_0.9 -d $DB_DIR -o $OUT_DIR --threads $THREADS

#-c <pers_genome>: persistent genome file whose families must be aligned from previous step
#-l <list_file>: list of all genomes, can be from the annotate step
#-n <dataset_name>: name of the dataset to align. For example, you can put ESCO200-0.9-mixed for the alignment of the mixed persistent genome of 200 E. coli strains, where mixed persistent genome was generated such that there are at least 90% of the genomes in each family.
#-d <dbdir>: directory containing the Proteins and Genes folders, with files corresponding to list_file
#-o <resdir>: directory where you want to have the temporary and result files

echo "script finished running at: "; date
