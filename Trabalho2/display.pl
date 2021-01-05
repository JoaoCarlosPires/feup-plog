/* DISPLAY */

/* Print board */
/* Size - tamanho da lista; Board - lista do tabuleiro */
printPuzzle(Size, Board, 0) :-
	nl, write('Initial Puzzle:'), nl,
	printCells(Board, 0, 0).

printPuzzle(Size, Board, 1) :-
	nl,	write('Final Puzzle:'), nl,
	printCells(Board, 0, 1).

printHeader :-
	nl,	write('White Arrows: '), 
	right_white, write(' '),
	left_white, write(' '),
	up_white, write(' '),
	down_white, write(' '),
	upleft_white, write(' '),
	downleft_white, write(' '),
	upright_white, write(' '),
	downright_white, write(' '), nl,
	write('Tan Arrows: '), 
	right_tan, write(' '),
	left_tan, write(' '),
	up_tan, write(' '),
	down_tan, write(' '),
	upleft_tan, write(' '),
	downleft_tan, write(' '),
	upright_tan, write(' '),
	downright_tan, write(' '), nl.

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

up_tan :- put_code(8593), write('T').
down_tan :- put_code(8595), write('T').
right_tan :- put_code(8594), write('T').
left_tan :- put_code(8592),  write('T').
upleft_tan :- put_code(8598),  write('T').
downleft_tan :- put_code(8601),  write('T').
upright_tan :- put_code(8599),  write('T').
downright_tan :- put_code(8600),  write('T').

up_white :- put_code(8593),  write('W').
down_white :- put_code(8595),  write('W').
right_white :- put_code(8594),  write('W').
left_white :- put_code(8592),  write('W').
upleft_white :- put_code(8598),  write('W').
downleft_white :- put_code(8601),  write('W').
upright_white :- put_code(8599),  write('W').
downright_white :- put_code(8600),  write('W').

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
	nl, write('|                                |'),
	nl, write('|      WHITE AND TAN PUZZLES     |'),
	nl, write('|                                |'),
	nl, write('|--------------------------------|'),
	nl, write('|                                |'),
	nl, write('|  Each puzzle is represented by |'),
	nl, write('|    a number between 1 and 9    |'),
	nl, write('|                                |'),
	nl, write('|      4x4 puzzles - 1 to 6      |'),
	nl, write('|      5x5 puzzles - 7 to 9      |'),
	nl, write('|                                |'),
	nl, write('|    Pick one of those numbers   |'),
	nl, write('|   so we can solve the puzzle   |'),
	nl, write('|                                |'),
	nl, write('----------------------------------'),nl.

puzzle(1,Puzzle):- puzzle1(Puzzle).
puzzle(2,Puzzle):- puzzle2(Puzzle).
puzzle(3,Puzzle):- puzzle3(Puzzle).
puzzle(4,Puzzle):- puzzle4(Puzzle).
puzzle(5,Puzzle):- puzzle5(Puzzle).
puzzle(6,Puzzle):- puzzle6(Puzzle).
puzzle(7,Puzzle):- puzzle7(Puzzle).
puzzle(8,Puzzle):- puzzle8(Puzzle).
puzzle(9,Puzzle):- puzzle9(Puzzle).
