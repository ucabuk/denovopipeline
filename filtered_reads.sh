#sliding window:4:15
#d2 is the directory containing the data for which we use slidingwindow 4:15 parameter in trimmomatic.

for i in d1/*
do
  cd $i
  java -jar trimmomatic-0.39.jar PE -phred33 $i_1.fastq $i_2.fastq R1_f_p.fq R1_f_un.fq R2_r_p.fq R2_r_un.fq LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50
  cd ..
done

#d2 is the directory containing the data for which we use slidingwindow 4:20 parameter in trimmomatic.

for i in d2
do
  cd $i
  java -jar trimmomatic-0.39.jar PE -phred33 $i_1.fastq $i_2.fastq R1_f_p.fq R1_f_un.fq R2_r_p.fq R2_r_un.fq LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:50
  cd ..
done

#move data into d2 to d1 to go downstream analysis

mv d2/* d1/.
