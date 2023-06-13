# Synteny analysis of Phaeobacter inhibens genomes
Using SibeliaZ, maf2synteny

# Get Genomes from NCBI
All Phaeobacter inhibens genomes were accessed from the S4Sm assembly page located here https://www.ncbi.nlm.nih.gov/genome/13044?genome_assembly_id=2187178 by clicking on RefSeq link for all related genomes

```bash
wget -r -e robots=off https://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/Phaeobacter_inhibens/latest_assembly_versions/
```
## Remove incomplete genomes from folder
There are currently (5/2023) 44 submissions on NCBI for Phaeobacter inhibens genome assemblies. All but three were complete. The three still at the scaffold level were excluded and are listed below.

| Strain              | Assembly               |
|---------------------|------------------------|
|        2-1005.fasta |        GCA_947489905.1 |
|           DSM 16374 |        GCA_000473105.1 |
|                S4Sm |        GCA_001559785.1 |

## Table of input genomes
These genomes were used in the analysis
| Strain           | Origin  | Total Length     | Assembly number        |
|------------------|---------|------------------|------------------------|
|              2.1 | unknown |        4,160,918 |        GCA_000154745.2 |
|             2.10 | unknown |        4,160,913 |        GCA_003443555.1 |
|            BS107 | unknown |        4,188,145 |        GCA_003443575.1 |
|           DOK1-1 | Dokdo   |        4,291,376 |        GCA_001969345.1 |
|        DSM 17395 | unknown |        4,227,134 |        GCA_000154765.2 |
|             M619 | China   |        4,178,771 |        GCA_025142455.1 |
|             M623 | China   |        4,314,694 |        GCA_025142595.1 |
|             M624 | China   |        4,204,626 |        GCA_025142675.1 |
|             M625 | China   |        4,281,685 |        GCA_025142695.1 |
|             M626 | China   |        4,163,548 |        GCA_025142715.1 |
|             M627 | China   |        4,244,751 |        GCA_025142735.1 |
|             M628 | China   |        4,301,253 |        GCA_025142755.1 |
|             M631 | China   |        4,314,012 |        GCA_025142775.1 |
|             M632 | China   |        4,139,108 |        GCA_025142795.1 |
|             M633 | China   |        4,402,211 |        GCA_025142815.1 |
|             M634 | China   |        4,089,150 |        GCA_025142835.1 |
|             M635 | China   |        4,301,151 |        GCA_025142855.1 |
|             M636 | China   |        4,283,941 |        GCA_025143105.1 |
|             M643 | China   |        4,114,628 |        GCA_025143215.1 |
|             M644 | China   |        4,284,518 |        GCA_025143325.1 |
|             M646 | China   |        4,182,712 |        GCA_025143405.1 |
|             M647 | China   |        4,266,684 |        GCA_025143505.1 |
|             M650 | China   |        4,202,636 |        GCA_025143665.1 |
|              P10 | France  |        4,237,605 |        GCA_002888685.1 |
|              P24 | Denmark |        4,398,636 |        GCA_002891665.1 |
|              P30 | Denmark |        4,320,988 |        GCA_002892205.1 |
|              P48 | Denmark |        4,109,120 |        GCA_002892265.1 |
|              P51 | Denmark |        4,124,503 |        GCA_002891985.1 |
|              P54 | Denmark |        4,248,079 |        GCA_002892185.1 |
|              P57 | Denmark |        4,021,447 |        GCA_002892005.1 |
|              P59 | Denmark |        4,103,784 |        GCA_002892165.1 |
|              P66 | Spain   |        4,777,546 |        GCA_002892065.1 |
|              P70 | Spain   |        4,479,933 |        GCA_002892125.1 |
|              P72 | Spain   |        4,429,187 |        GCA_002891945.1 |
|              P74 | Spain   |        4,481,611 |        GCA_002892045.1 |
|              P78 | Spain   |        4,268,701 |        GCA_002891965.1 |
|              P80 | Spain   |        4,695,825 |        GCA_002892145.1 |
|              P83 | Spain   |        4,648,923 |        GCA_002892225.1 |
|              P88 | Spain   |        4,844,543 |        GCA_002892085.1 |
|              P92 | Spain   |        4,479,935 |        GCA_002892025.1 |
|             S4Sm | RI USA  |        4,385,166 |        GCA_030060455.1 |

# Run SibeliaZ to create syntny blocks
Order of flags is important and should be entered in this order

[-k <odd integer>] [-b <integer>] [-m <integer>] [-a <integer>] [-t <integer>] [-f <integer>] [-o <output_directory>] [-n] <input file>

```bash
sibeliaz -k 15  -a 201 -t $threads -n $INPUT_DIR/*
```

# Run maf2synteny to align blocks from SibeliaZ output
```bash
maf2synteny sibeliaz_out/blocks_coords.gff
```
# Re-run SibeliaZ with a higher -a interger
Increasing the -a flag value to include a larger number of verticies. From the SibeliaZ page
"SibeliaZ removes all k-mers with frequency more than a threshold, which is controlled by the option: -a <integer> We recommend setting it to twice the maximum number of copies of a homologous block the underlying input genome collection has."

D * N * 2 = a
D=number of duplications
N=number of genomes
2=constant

Following this equation, an -a of 201 would suggest duplications of a little over 2. To cover a larger range we increased that value to 2000, for a duplication rate of just shy of 25.

```bash
sibeliaz -k 15  -a 2000 -t $threads -n $INPUT_DIR/*
```

## Output
SibeliaZ run with -a 201
Blocks found: 7120
Coverage: 0.98

SibeliaZ run with -a 2000
Blocks found: 7167
Coverage: 0.98
