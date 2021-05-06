###PREPROCESSING PART###
#Trimming and filtered reads

java -jar trimmomatic-0.39.jar PE -phred33 SRR8617823_1.fastq SRR8617823_2.fastqR1_f_p.fq R1_f_un.fq R2_r_p.fq R2_r_un.fq LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50

#creating a temporary assembly for predicting closely related organism  

SPAdes-3.11.0/bin/./spades.py -o temp_assembly -1 R1_f_p.fq -2 R2_r_p.fq -t 2 -m 12 -k 21,33,55,77,99,1271

barrnap temp_assembly/contigs.fasta > rRNAs.out #predicted rRNAs into the assembly

grep 16S_rRNA rRNAs.out > 16S_rRNA.out #Only 16srRNA description is extracted from the file

bedtools getfasta -fi contigs.fasta 16s_rRNA.out -fo 16s_rRNA.fa #16srRNA fasta file is extracted from the assembly file

#We recommend that It would be good to do manually blast checks via website. However, you can download all refseq genomes from NCBI using ftp to build a local database
#and search predicted 16srRNA into refseq genomes.

#NOTICE THAT selected refseq genomes should be the complete genome, not draft genome. 

###ASSEMBLY PART###

#creating a second draft assembly using IDBA for SPAdes trusted-contigs input
idba-1.1.3/bin/fq2fa --merge R1_f_p.fq R2_r_p.fq merged.fa #merged reads into one file

idba-1.1.3/bin/./idba_hybrid -r $i.fa -o out_idba --reference reference_genomes/d9_ref.fna #with default parameters, similarity threshould val.:0.95

#produce the final draft assembly to go downstream analysis (Final Draft Genome)
SPAdes-3.11.0/bin/./spades.py -o out_combined -1 R1_f_p.fq -2 R2_r_p.fq --trusted-contigs $i'_idba/contig.fa' -t 2 -m 12 -k 21,33,55,77,99,127 \
 --cov-cutoff auto --only-assembler
 
###EVALUATES###

#QUAST

python /home/manager/Downloads/quast-5.0.2/quast.py --pe1 R1_f_p.fq --pe2 R2_r_p.fq out_combined/contigs.fasta -u -o o_quast_report

#BUSCO

busco -i out_combined/contigs.fasta -f --mode genome --lineage pseudomonadales_odb10 --out out_pseudomonadales_db 

