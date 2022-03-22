all:
	flex ./src/main.l
	gcc lex.yy.c -o main

	mkdir bin
	mkdir lex
	mv lex.yy.c lex
	mv main bin