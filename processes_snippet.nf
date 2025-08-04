#!/usr/bin/env nextflow
params.compress = 'gzip'
params.file2compress = "$projectDir/data/ggal/transcriptome.fa"
//reads = Channel.fromPath('data/ggal/*.fq')
ch1 = Channel.of(1, 2, 3)
ch2 = Channel.of('a', 'b', 'c')

params.reads = "$projectDir/data/ggal/*_1.fq"
params.transcriptome_file = "$projectDir/data/ggal/transcriptome.fa"

Channel
    .fromPath(params.reads)
    .set { read_ch }

process COMMAND {
    debug true

    input:
    path reads
    path transcriptome

    script:
    """
    echo $reads $transcriptome
    """
}

process COMBINE {
    debug true

    input:
    val x
    val y

    script:
    """
    echo $x and $y
    """
  
}

process FOO {
    debug true

    input:
    path file

    script:
    if (params.compress == 'gzip')
        """
        echo "gzip -c $file > ${file}.gz"
        """
    else if (params.compress == 'bzip2')
        """
        echo "bzip2 -c $file > ${file}.bz2"
        """
    else
        throw new IllegalArgumentException("Unknown compressor $params.compress")
}


process PATH_FIND {
    debug true

    input:
    //path 'sample.fastq'
    path sample

    script:
    """
    #ls sample.fastq
    ls $sample
    """
}

workflow {
    //FOO(params.file2compress)
    //PATH_FIND(reads.collect())
    //COMBINE(ch1, ch2)
     COMMAND(read_ch, params.transcriptome_file)
}