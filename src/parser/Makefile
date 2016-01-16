build:
	bison -d php.y
	flex php.l
	g++ php.tab.c lex.yy.c -lfl -o php

clean:
	rm php
	rm lex.yy.c
	rm php.tab.c
	rm php.tab.h
