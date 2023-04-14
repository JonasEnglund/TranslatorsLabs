all: main.l main.y 
	bison -d main.y
	flex main.l
	gcc -o calc main.tab.c lex.yy.c -lfl -lm
	./calc < stream.txt

clean: 
	rm main.tab.cc main.tab.hh || true
	rm main.tab.c main.tab.h || true
	rm lex.yy.cc lex.yy.c

