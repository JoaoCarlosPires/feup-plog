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

% setas ([Dir, Cor],...).  

/* initial puzzles examples */
puzzle1(P):- P=[[[7,1],[7,0],[3,1],[4,1]],
				[[2,0],[2,1],[3,1],[4,1]],
				[[1,1],[6,1],[4,1],[5,0]],
				[[8,1],[1,0],[5,0],[8,1]]].

puzzle2(P):- P=[[[1,0],[2,0],[7,0],[3,0]],
				[[1,0],[2,0],[4,0],[3,0]],
				[[6,0],[1,0],[8,0],[8,0]],
				[[6,0],[1,0],[5,0],[5,0]]].		

puzzle3(P):- P=[[[7,0],[1,0],[3,0],[7,0]],
				[[2,0],[7,0],[4,0],[3,0]],
				[[6,0],[8,0],[8,0],[5,0]],
				[[1,0],[6,0],[5,0],[5,0]]].

puzzle4(P):- P=[[[7,0],[7,0],[3,0],[4,0]],
				[[2,0],[1,0],[3,0],[7,0]],
				[[6,0],[8,0],[4,0],[8,0]],
				[[6,0],[6,0],[5,0],[4,0]]].		
				

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
	statistics(walltime, [Start,_]), nl,
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 1:'), 
	puzzle1(P),
	nl, nl,
	printPuzzle(4, P), nl,
	statistics(walltime, [End,_]) ,
	Time is End - Start ,
	write('Time: '),
	write(Time), nl, fd_statistics.

puzzleOption(2) :-
	statistics(walltime, [Start,_]), nl,
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 2:'), 
	puzzle2(P),
	nl, nl,
	printPuzzle(4, P), nl,
	statistics(walltime, [End,_]) ,
	Time is End - Start ,
	write('Time: '),
	write(Time), nl, fd_statistics.

puzzleOption(3) :-
	statistics(walltime, [Start,_]), nl,
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 3:'), 
	puzzle3(P),
	nl, nl,
	printPuzzle(4, P), nl,
	statistics(walltime, [End,_]) ,
	Time is End - Start ,
	write('Time: '),
	write(Time), nl, fd_statistics.

puzzleOption(4) :-
	statistics(walltime, [Start,_]), nl,
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 4:'),
	puzzle4(P),
	nl, nl,
	printPuzzle(4, P), nl,
	statistics(walltime, [End,_]) ,
	Time is End - Start ,
	write('Time: '),
	write(Time), nl, fd_statistics.

puzzleOption(5) :-
	statistics(walltime, [Start,_]), nl,
	write('White Arrows: '), right_white, write('   '),
	write('Tan Arrows: '), right_tan, nl,
	nl,
	write('Puzzle 5:'),
	random(1, 5, R),
	puzzle(R, P),
	nl, nl,
	printPuzzle(4, P), nl,
	statistics(walltime, [End,_]) ,
	Time is End - Start ,
	write('Time: '),
	write(Time), nl, fd_statistics.
	
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

right_tan :- put_code(8594).
right_white :- put_code(8658).