/* DISPLAY */

/* Print board */
/* Size - tamanho da lista; Board - lista do tabuleiro */
printBoard(Size, Board) :-
	nl, 
	printLetters(Size, Size),
	printCells(0, Size, Board).

/* Letras do tabuleiro */
printLetters(Size, Size) :- 
	Size > 0,
	space(4),
	printLetter(Size, Size).

printLetter(1, Size) :-
	space(2),
	C is 65+Size-1,
	put_code(C),
	space(2), nl.

printLetter(Line, Size) :-
	space(2),
	C is 65+Size-Line,
	put_code(C),
	space(2),
	Nextline is Line-1,
	printLetter(Nextline,Size).

/* Tabuleiro */
printCells(_,_, []).

printCells(0, Size, [Line|Board]) :-
	printPieces(0, Size, Line),
	printCells(1, Size, Board).

printCells(Currentline, Size, [Line|Board]) :-
	printPieces(Currentline, Size, Line),
	Nextline is Currentline+1,
	printCells(Nextline, Size, Board).

/* Peças e divisões */
printPieces(Currline, _, Line) :-
	space(2),
	write(Currline),
	space(2),
	printPiece(Line),
	div, nl.

printPiece([]).

printPiece([0|Line]) :-
	div,
	space(2),
	printPiece(Line).

printPiece([1|Line]) :-
	div,
	blackPiece,
	space(3),
	printPiece(Line).

printPiece([2|Line]) :-
	div,
	whitePiece,
	space(2),
	printPiece(Line).
	
/* Characteres */

div :- put_code(9474).
blackPiece :- put_code(11044).
whitePiece :- put_code(11093).

space(0).
space(N) :- write(' '), N1 is N-1, space(N1).
