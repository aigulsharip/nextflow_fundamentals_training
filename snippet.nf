#!/usr/bin/env nextflow

ch1 = Channel.of(1, 2, 3)
ch2 = Channel.of(100)
ch3 = Channel.value([1, 2, 3, 4, 5])

process SUM {
    input:
    val x
    val y

    output:
    stdout

    script:
    """
    echo \$(($x+$y))
    """
}

workflow {
    SUM(ch1, ch2).view()
    ch3.view()
    Channel.of(1, 3, 5, 7).view()
    list = ['hello', 'world']

    Channel.fromList(list).view()

    //Channel.fromPath('./data/meta/*.csv').view()
    //Channel.fromPath('./data/ggal/**.fq', hidden:true).view()

    Channel
    .fromFilePairs('./data/ggal/*_{1,2}.fq', flat:true)
    .view()


}