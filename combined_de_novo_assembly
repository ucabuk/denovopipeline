#!bin/bash

for i in d1
do
  cd $i
  idba-1.1.3/bin/fq2fa --merge R1_f_p.fq R2_r_p.fq $i.fa
  idba-1.1.3/bin/./idba_hybrid -r $i.fa -o $i'_idba' --reference reference_genomes/#
  cd ..
done

for i in d1
do
  cd $i/$i'_idba'
  SPAdes-3.11.0/bin/./spades.py -o $i_combined -1 R1_f_p.fq -2 R2_r_p.fq --trusted-contigs $i'_idba/contig.fa' -t 2 -m 12 -k 21,33,55,77,99,127 --cov-cutoff auto --only-assembler
  cd ..
done
