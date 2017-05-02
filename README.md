# TGS-Elementary-Compiler
Assignment #4 "Elementary Compiler"
this project is submitted to the "01076262 Compiler Construction" subject, CE KMITL 2016
## Getting Started  

- Create a compiler program

```shell
  $ flex TGS.l
  $ yacc -d TGS.y
  $ gcc lex.yy.c y.tab.c -o TGSProg
  $ ./TGSProg test.tgs
  $ nasm -felf64 test.asm && gcc test.o && ./a.out
```

## Grammars
the grammars will be available here!

## Tasks

"#" | Status | Task
--- | --- | ---
0 | :heavy_check_mark: | Lexer (Lexical analysis)
13 | :heavy_check_mark: | Ignore tap and space(Lexical)
2 | :x: | Documents
3 | :heavy_check_mark: | Installing the required tools {'Flex', 'Bison', 'GCC'}
4 | :heavy_check_mark: | Num Value(Grammars)
5 | :satisfied: | Hex -> Dec Num Value
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
