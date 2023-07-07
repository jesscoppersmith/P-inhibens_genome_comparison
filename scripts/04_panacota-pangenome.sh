#!/bin/bash
#SBATCH --job-name="panacota-pangenome"
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

OUT_DIR=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/pangenome_out
LIST_FILE=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/annotation_out/LSTINFO-LSTINFO-NA-filtered-0.0001_0.06.lst
DBDIR=/data/marine_diseases_lab/jessica/src/phaeobacter_comparison_2023/panacota/annotation_out/Proteins/
THREADS=16

module purge
module load PanACoTA
module list

PanACoTA pangenome -l $LIST_FILE -n PHIN37 -d $DBDIR -o $OUT_DIR -i .8 --threads $THREADS

#-l <list_file>: the file containing the list of genomes to include in the pangenome, as described in input formats
#n <dataset_name>: name you want to give to your dataset for which you are generating a pangenome. For example, ESCO200 if you are doing a pangenome of 200 E. coli strains
#-d <path/to/dbdir>: path to the <dbdir>, containing all .prt files.
#-o <path/to/outdir>: path to the directory where you want to put the pangenome results (and temporary files)
#-i <min_id>: minimum percentage of identity required to put 2 proteins in the same family. When doing a pangenome at the species level, we commonly use a threshold of 80% of identity.

echo "script finished running at: "; date
