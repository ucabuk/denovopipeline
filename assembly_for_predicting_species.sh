
for i in d1*
do
  cd $i
  SPAdes-3.11.0/bin/./spades.py -o $i'_temp_assembly' -1 R1_f_p.fq -2 R2_r_p.fq -t 2 -m 12 -k 21,33,55,77,99,127
  cd $i'_temp_assembly'
  barrnap contigs.fasta > rRNAs.out #predicted rRNAs into the assembly
  grep 16S_rRNA rRNAs.out > 16S_rRNA.out #Only 16srRNA description is extracted from the file
  bedtools getfasta -fi contigs.fasta 16s_rRNA.out -fo 16s_rRNA.fa #16srRNA fasta file is extracted from the assembly file
  cd ../..
done

#We recommend that It would be good to do manually blast checks via website. However, you can download all refseq genomes from NCBI using ftp to build a local database and
#search predicted 16srRNA into refseq genomes.
#NOTICE THAT selected refseq genomes should be the complete genome, not draft genome. 

#OPTIONAL (Downloading bacteria refseq db from NCBI to build a local database and searching):


