# TGS-Elementary-Compiler
Assignment #4 "Elementary Compiler"
this project is submitted to the "01076262 Compiler Construction" subject, CE KMITL 2016
## Getting Started  

- Install required packages (GCC, Flex, Bison, NASM)

```shell
  $ sudo apt-get install gcc flex bison nasm
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
## Grammars and Token Type
Please look at TGS.l(lexer), TGS.y(Grammars) files.

## Contributors
* Suttichai Pongsanont
* Atthasit Sintunyatum
* Isara Naranirattisai
