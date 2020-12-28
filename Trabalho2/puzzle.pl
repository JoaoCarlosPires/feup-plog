/* PUZZLE */

:- use_module(library(random)).
:- use_module(library(lists)).
:- use_module(library(system)).
:- ensure_loaded('display.pl').
:- ensure_loaded('arrows.pl').

% right - 1
% downRight - 2 
% downLeft - 3 
% left - 4 
% upLeft - 5 
% upRight - 6 
% down - 7 
% up - 8

/* initial puzzles examples */
puzzle1(P):- P=[[7,7,3,4],
				[2,2,3,4],
				[1,6,4,5],
				[8,1,5,8]].

puzzle2(P):- P=[[1,2,7,3],
				[1,2,4,3],
				[6,1,8,8],
				[6,1,5,5]].		

puzzle3(P):- P=[[7,1,3,7],
				[2,7,4,3],
				[6,8,8,5],
				[1,6,5,5]].

puzzle4(P):- P=[[7,7,3,4],
				[2,1,3,7],
				[6,8,4,8],
				[6,6,5,4]].			

puzzle :-
	nl,
	nl, write('----------------------------------'),
	nl, write('|      WHITE AND TAN PUZZLES     |'),
	nl, write('|--------------------------------|'),
	nl, write('|                                |'),
	nl, write('| 1. Exemplo 1      2. Exemplo 2 |'),
	nl, write('| 3. Exemplo 3      4. Exemplo 4 |'),
	nl, write('|           5. Random            |'),
	nl, write('----------------------------------'),nl,
	menu.

/* MENU */
menu :-
	menuInput(Option, 1, 5),
	NOption is Option-48,
	puzzleOption(NOption).

puzzleOption(1) :-
	nl,
	write('Puzzle 1:'), 
	puzzle1(P),
	nl, nl,
	printPuzzle(4, P), nl.

puzzleOption(2) :-
	nl,
	write('Puzzle 2:'), 
	puzzle2(P),
	nl, nl,
	printPuzzle(4, P), nl.

puzzleOption(3) :-
	nl,
	write('Puzzle 3:'), 
	puzzle3(P),
	nl, nl,
	printPuzzle(4, P), nl.

puzzleOption(4) :-
	nl,
	write('Puzzle 4:'),
	puzzle4(P),
	nl, nl,
	printPuzzle(4, P), nl.

puzzleOption(5) :-
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

/* MENU INPUT */

menuInput(Option, Min, Max) :-
	get_code(O), skip_line,
	O > 47+Min, O < 49+Max,
	Option is O.

menuInput(Option, Min, Max) :- menuInput(Option, Min, Max).