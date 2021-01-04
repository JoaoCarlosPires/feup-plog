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
printLine([Cell|Rest], Currentcol) :-
	printArrow(Cell),
	Nextcol is Currentcol+1,
	printLine(Rest, Nextcol).

/* Peças e divisões */

printArrow([1,0]) :- right_white, space(1).
printArrow([1,1]) :- right_tan, space(1).
printArrow([2,1]) :- downright_tan,	space(1).
printArrow([2,0]) :- downright_white, space(1).
printArrow([3,0]) :- downleft_white, space(1).
printArrow([3,1]) :- downleft_tan, space(1).
printArrow([4,1]) :- left_tan, space(1).
printArrow([4,0]) :- left_white, space(1).
printArrow([5,0]) :- upleft_white, space(1).
printArrow([5,1]) :- upleft_tan, space(1).
printArrow([6,1]) :- upright_tan, space(1).
printArrow([6,0]) :- upright_white, space(1).
printArrow([7,0]) :- down_white, space(1).
printArrow([7,1]) :- down_tan, space(1).
printArrow([8,0]) :- up_white, space(1).
printArrow([8,1]) :- up_tan, space(1).

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

space(0).
space(N) :- write(' '), N1 is N-1, space(N1).

/* MAIN MENU */

mainMenu :-
	nl,
	nl, write('----------------------------------'),
	nl, write('|      WHITE AND TAN PUZZLES     |'),
	nl, write('|--------------------------------|'),
	nl, write('|                                |'),
	nl, write('| 1. Exemplo 1      2. Exemplo 2 |'),
	nl, write('| 3. Exemplo 3      4. Exemplo 4 |'),
	nl, write('|           5. Random            |'),
	nl, write('----------------------------------'),nl.

puzzleOption(1, P) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 1:'), 
	puzzle1(P),
	nl, nl,
	printPuzzle(4, P), nl.

puzzleOption(2, P) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 2:'), 
	puzzle2(P),
	nl, nl,
	printPuzzle(4, P), nl.

puzzleOption(3, P) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 3:'), 
	puzzle3(P),
	nl, nl,
	printPuzzle(4, P), nl.

puzzleOption(4, P) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 4:'),
	puzzle4(P),
	nl, nl,
	printPuzzle(4, P), nl.

puzzleOption(5, P) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 5:'),
	random(1, 5, R),
	puzzle(R, P),
	nl, nl,
	printPuzzle(4, P), nl.

puzzle(1,P):- puzzle1(P).
puzzle(2,P):- puzzle2(P).
puzzle(3,P):- puzzle3(P).
puzzle(4,P):- puzzle4(P).