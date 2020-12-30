/* DISPLAY */

/* Print board */
/* Size - tamanho da lista; Board - lista do tabuleiro */
printPuzzle(Size, Board) :-
	nl, 
	printCells(Board, 0).

/* Tabuleiro */
printCells([],_).

printCells([Line|Board], Currentline) :-
	space(3),
	printLine(Line, Currentline),
	nl,
	Nextline is Currentline+1,
	printCells(Board, Nextline).

/* Linhas */

printLine([], _).

printLine([Cell|Rest], Currentline) :-
	printArrow(Cell),
	Nextline is Currentline+1,
	printLine(Rest, Nextline).

/* Peças e divisões */
printArrow([1,0|Tail]) :-
	right_white,
	space(1).

printArrow([1,1|Tail]) :-
	right_tan,
	space(1).

printArrow([2,1|Tail]) :-
	downright_tan,
	space(1).

printArrow([2,0|Tail]) :-
	downright_white,
	space(1).

printArrow([3,0|Tail]) :-
	downleft_white,
	space(1).

printArrow([3,1|Tail]) :-
	downleft_tan,
	space(1).

printArrow([4,1|Tail]) :-
	left_tan,
	space(1).

printArrow([4,0|Tail]) :-
	left_white,
	space(1).

printArrow([5,0|Tail]) :-
	upleft_white,
	space(1).

printArrow([5,1|Tail]) :-
	upleft_tan,
	space(1).

printArrow([6,1|Tail]) :-
	upright_tan,
	space(1).

printArrow([6,0|Tail]) :-
	upright_white,
	space(1).

printArrow([8,0|Tail]) :-
	up_white,
	space(1).

printArrow([8,1|Tail]) :-
	up_tan,
	space(1).

printArrow([7,1|Tail]) :-
	down_tan,
	space(1).

printArrow([7,0|Tail]) :-
	down_white,
	space(1).

/* Characteres */

up_tan :- put_code(8593).
down_tan :- put_code(8595).
right_tan :- put_code(8594).
left_tan :- put_code(8592).
upleft_tan :- put_code(8598).
downleft_tan :- put_code(8601).
upright_tan :- put_code(8599).
downright_tan :- put_code(8600).

up_white :- put_code(8657).
down_white :- put_code(8659).
right_white :- put_code(8658).
left_white :- put_code(8656).
upleft_white :- put_code(8662).
downleft_white :- put_code(8665).
upright_white :- put_code(8663).
downright_white :- put_code(8664).

% right - 1
% downRight - 2 
% downLeft - 3 
% left - 4 
% upLeft - 5 
% upRight - 6 
% down - 7 
% up - 8