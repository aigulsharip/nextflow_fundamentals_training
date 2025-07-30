process echo {
  input:
  val x

  script:
  """
  echo "process job $x"
  """
}

process echo_env {
    input:
    env 'HELLO'

    script:
    '''
    echo "$HELLO world!"
    '''
}

process cat {
  input:
  stdin

  script:
  """
  cat -
  """
}

process cat_tuple {
    input:
    tuple val(x), path('input.txt')

    script:
    """
    echo "Processing $x"
    cat input.txt > copy
    """
}

process echo_output {
  input:
  each x

  output:
  val x

  script:
  """
  echo $x > file
  """
}

process split_letters {
    output:
    path 'chunk_*'

    script:
    """
    printf 'Hola' | split -b 1 - chunk_
    """
}
process seq {
    output:
    env 'RESULT'

    script:
    '''
    RESULT=$(seq 5)
    '''
}

process hello {
    output:
    stdout

    script:
    """
    echo "Hello world!"
    """
}

process echo_singleton {
  input:
  val greeting

  output:
  val greeting

  exec:
  true
}

process greet {
  input:
  val greeting
  val name

  output:
  val "$greeting, $name!"

  exec:
  true
}

process hello_bye {
    output:
    path 'hello.txt', emit: hello
    stdout emit: bye

    script:
    """
    echo "hello" > hello.txt
    echo "bye"
    """
}




workflow {
    //def num = channel.of(1,2,3)
    //echo(num)

    //channel.of(1,2,3) |echo


    // channel.of('hello', 'hola', 'bonjour', 'ciao') | echo_env
    // ? what is the difference between env and val and their usage and 
    //{} usage
    // ?how to output the results

    // channel.of('hello', 'hola', 'bonjour', 'ciao')
    // | map { v -> v + '\n' }
    // | cat

    //channel.of( [1, 'alpha.txt'], [2, 'beta.txt']) | cat_tuple
  // methods = ['prot', 'dna', 'rna']

  // received = echo_output(methods)
  // received.view { method -> "Received: $method" }

  // split_letters
  //       | flatten
  //       | view { chunk -> "File: ${chunk.name} => ${chunk.text}" }

  /// ?I dont understand env
  //seq | view

  //hello | view { message -> "I say... $message" }

  // names = channel.of( 'World', 'Mundo', 'Welt' )
  // greeting = echo_singleton('Hello')
  // result = greet(greeting, names)
  // result.view()

  hello_bye()
  hello_bye.out.hello.view()
  hello_bye.out.bye.view()


}
