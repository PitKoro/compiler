all:
	mkdir -p bin
	mkdir -p includes
	mkdir -p gen

	bison src/grammar.y --defines=includes/grammar.h -o gen/grammar.c
	flex -o gen/lex.c src/lex.l

	gcc gen/grammar.c gen/lex.c -o bin/parser
	