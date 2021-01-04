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
	nl, write('|    a number between 1 and 15   |'),
	nl, write('|                                |'),
	nl, write('|    Pick one of those numbers   |'),
	nl, write('|   so we can solve the puzzle   |'),
	nl, write('|                                |'),
	nl, write('----------------------------------'),nl.

puzzleOption(1, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 1:'), 
	puzzle1(Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

puzzleOption(2, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 2:'), 
	puzzle2(Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

puzzleOption(3, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 3:'), 
	puzzle3(Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

puzzleOption(4, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 4:'),
	puzzle4(Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

puzzleOption(5, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 5:'), 
	puzzle5(Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

puzzleOption(6, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 6:'), 
	puzzle6(Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

puzzleOption(7, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 7:'), 
	puzzle7(Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

puzzleOption(8, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 8:'),
	puzzle8(Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

puzzleOption(9, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 9:'), 
	puzzle9(Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

puzzleOption(10, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 10:'), 
	puzzle10(Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

puzzleOption(11, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 11:'),
	puzzle11(Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

puzzleOption(12, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 12:'), 
	puzzle12(Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

/*
puzzleOption(13, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 13:'), 
	puzzle13(Puzzle),
	nl, nl,
	printPuzzle(5, Puzzle), nl.

puzzleOption(14, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 14:'),
	puzzle14(Puzzle),
	nl, nl,
	printPuzzle(5, Puzzle), nl.

puzzleOption(15, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 15:'),
	puzzle15(Puzzle),
	nl, nl,
	printPuzzle(5, Puzzle), nl.
*/

puzzleOption(0, Puzzle) :-
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Random Puzzle:'),
	random(1, 13, R),
	puzzle(R, Puzzle),
	nl, nl,
	printPuzzle(4, Puzzle), nl.

puzzle(1,Puzzle):- puzzle1(Puzzle).
puzzle(2,Puzzle):- puzzle2(Puzzle).
puzzle(3,Puzzle):- puzzle3(Puzzle).
puzzle(4,Puzzle):- puzzle4(Puzzle).
puzzle(5,Puzzle):- puzzle5(Puzzle).
puzzle(6,Puzzle):- puzzle6(Puzzle).
puzzle(7,Puzzle):- puzzle7(Puzzle).
puzzle(8,Puzzle):- puzzle8(Puzzle).
puzzle(9,Puzzle):- puzzle9(Puzzle).
puzzle(10,Puzzle):- puzzle10(Puzzle).
puzzle(11,Puzzle):- puzzle11(Puzzle).
puzzle(12,Puzzle):- puzzle12(Puzzle).
puzzle(13,Puzzle):- puzzle13(Puzzle).
puzzle(14,Puzzle):- puzzle14(Puzzle).
puzzle(15,Puzzle):- puzzle15(Puzzle).
