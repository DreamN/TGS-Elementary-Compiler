# TGS-Elementary-Compiler
Assignment #4 "Elementary Compiler"
this project is submitted to the "01076262 Compiler Construction" subject, CE KMITL 2016
## Getting Started  

- Install required packages (GCC, Flex, Bison)

```shell
  $ sudo apt-get install gcc flex bison
```

- Compile program

```shell
  $ ./compile <Your file name>
  Ex. $ ./compile example/Fibonacci.tgs
```
*Noted that test.tgs is your tgs file

- Run program
```shell
  $ nasm -felf64 <Your compiled file(.asm)>
  $ gcc <Your compiled file(.o)>
  $ ./a.out
```
## Grammars
Look at the documents of yacc file

## Tasks

"#" | Status | Task
--- | --- | ---
0 | :heavy_check_mark: | Lexer (Lexical analysis)
1 | :heavy_check_mark: | Ignore tap and space(Lexical)
2 | :heavy_check_mark: | Documents
3 | :heavy_check_mark: | Installing the required tools {'Flex', 'Bison', 'GCC'}
4 | :heavy_check_mark: | Num Value(Grammars)
5 | :heavy_check_mark: | Hex -> Dec Num Value
6 | :heavy_check_mark: | Value Assignment
7 | :heavy_check_mark: | String Value(Grammars)
8 | :heavy_check_mark: | Print values (Grammars)
9 | :heavy_check_mark: | Print values in hex (Grammars)
10 | :heavy_check_mark: | Equal, isn't it? -> Boolean (Grammars)
11 | :heavy_check_mark: | Looping (single + nested)
12 | :heavy_check_mark: | If Condition (single + nested)
13 | :heavy_check_mark: | Basic Operation{+, -, *, /, \}
14 | :heavy_check_mark: | Print RESX:

## Contributors
* Suttichai Pongsanont
* Atthasit Sintunyatum
* Isara Naranirattisai
