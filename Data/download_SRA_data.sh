#!bin/bash

count = 0

input="SRA_ID_list.txt"

while IFS=read -r line
do
  count=$((count+1))
  fastq-dump --split-files $line
done < "$input"
