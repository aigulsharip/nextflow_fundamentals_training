#!/bin/bash -ue
// mkdir fastqc_gut_logs
// fastqc -o fastqc_gut_logs -f fastq -q gut_1.fq gut_2.fq
fastqc.sh "gut" "gut_1.fq gut_2.fq"
