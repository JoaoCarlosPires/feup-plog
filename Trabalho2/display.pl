/* DISPLAY */

/* Print board */
/* Size - tamanho da lista; Board - lista do tabuleiro */
printPuzzle(Size, Board, 0) :-
	nl,	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl, nl,
	write('Initial Puzzle:'), nl,
	printCells(Board, 0, 0).

printPuzzle(Size, Board, 1) :-
	nl,	write('Final Puzzle:'), nl,
	printCells(Board, 0, 1).

/* Tabuleiro */

printCells([],_,_).
printCells([Line|Board], Currentline, Init) :-
	space(3),
	printLine(Line, Currentline, Init),
	nl,
	Nextline is Currentline+1,
	printCells(Board, Nextline, Init).

/* Linhas */

printLine([], _, _).
printLine([Cell|Rest], Currentcol, 1) :-
	printArrow(Cell),
	Nextcol is Currentcol+1,
	printLine(Rest, Nextcol, 1).
printLine([Cell|Rest], Currentcol, 0) :-
	printArrow2(Cell),
	Nextcol is Currentcol+1,
	printLine(Rest, Nextcol, 0).

/* Peças e divisões */

printArrow2([1,_]) :- right_white, space(1).
printArrow2([2,_]) :- downright_white, space(1).
printArrow2([3,_]) :- downleft_white, space(1).
printArrow2([4,_]) :- left_white, space(1).
printArrow2([5,_]) :- upleft_white, space(1).
printArrow2([6,_]) :- upright_white, space(1).
printArrow2([7,_]) :- down_white, space(1).
printArrow2([8,_]) :- up_white, space(1).

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
space(Num) :- write(' '), Num1 is Num-1, space(Num1).

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

puzzle(1,Puzzle):- puzzle1(Puzzle).
puzzle(2,Puzzle):- puzzle2(Puzzle).
puzzle(3,Puzzle):- puzzle3(Puzzle).
puzzle(4,Puzzle):- puzzle4(Puzzle).