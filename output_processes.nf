reads_ch = Channel.fromFilePairs('data/ggal/*_{1,2}.fq')


process FOO {
    publishDir "results", pattern: "*.bam"


    input:
    tuple val(sample_id), path(sample_id_paths)

    output:
    tuple val(sample_id), path('sample.bam'), emit:bam
    tuple val(sample_id), path('sample.bai'), emit:bai

    script:
    """
    echo your_command_here --sample $sample_id_paths > sample.bam
    echo your_command_here --sample $sample_id_paths > sample.bai
    """
}

workflow {
    FOO(reads_ch)
    //FOO.out[0].view()
    FOO.out.bai.view()
}