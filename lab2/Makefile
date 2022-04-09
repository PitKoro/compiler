all:
	mkdir bin
	mkdir includes
	mkdir build

	
	bison src/grammar.y --defines=grammar.h -o grammar.c
	mv grammar.h includes
	flex src/lex.l

	mv lex.yy.c build
	mv grammar.c build
	

	gcc build/grammar.c build/lex.yy.c -o parser
	mv parser bin