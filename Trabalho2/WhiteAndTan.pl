/* PUZZLE */

:- use_module(library(random)).
:- use_module(library(lists)).
:- use_module(library(system)).
:- use_module(library(clpfd)).
:- ensure_loaded('display.pl').
:- ensure_loaded('arrows.pl').
:- ensure_loaded('puzzles.pl').
:- ensure_loaded('input.pl').
				
puzzle :- mainMenu, menu.

/* MENU */
menu :-
	menuInput(Option, 1, 9),
	NOption is Option-48,
	puzzle(NOption, Puzzle),
	(NOption < 7 -> solveProblem(Puzzle, 4) ; solveProblem(Puzzle, 5)).
	
getLetters([], []).
getLetters([CurrLine|NextLines], [CurrLetters|Rest]) :-
	getLineLetters(CurrLine, CurrLetters),
	getLetters(NextLines, Rest).

getLineLetters([], []).
getLineLetters([CurrCell|Others], [Curr|Other]) :-
	getLetter(CurrCell, Curr),
	getLineLetters(Others, Other).

getLetter([Direction, Letter], Letter).

solveProblem(Puzzle, 4) :-
	statistics(walltime, [Start,_]),
	
	getLetters(Puzzle, Letters),
	flatten(Letters, Fla),
	
	domain(Fla, 0, 1),
	cycle(Fla, Puzzle, 0, 4),
	
	labeling([], Fla),
	
	statistics(walltime, [End,_]),
	Time is End - Start,
	
	printHeader,
	printPuzzle(4, Puzzle, 0),
	printPuzzle(4, Puzzle, 1),

	format('\nDuration: ~3d s~n', [Time]),
	fd_statistics.

solveProblem(Puzzle, 5) :-
	statistics(walltime, [Start,_]),
	
	getLetters(Puzzle, Letters),
	flatten(Letters, Fla),
	
	domain(Fla, 0, 1),
	cycle(Fla, Puzzle, 0, 5),
	
	labeling([], Fla),
	
	statistics(walltime, [End,_]),
	Time is End - Start,
	
	printHeader,
	printPuzzle(5, Puzzle, 0),
	printPuzzle(5, Puzzle, 1),

	format('\nDuration: ~3d s~n', [Time]),
	fd_statistics.
	
/* 4X4 PUZZLES */
cycle([], _, 4, 4).
cycle([L1, L2, L3, L4|Others], Puzzle, Lin, 4) :-
	lineCycle([L1, L2, L3, L4], Puzzle, 0, Lin, 4),
	NewLin is Lin + 1,
	cycle(Others, Puzzle, NewLin, 4).

lineCycle([], _, 4, _, 4).
lineCycle([CurrLetter|Other], Puzzle, Col, Lin, 4) :-
	getDir(Puzzle, Lin, Col, Dir),
	aponta(Dir, Lin, Col, Puzzle, List),
	conditionalRestriction(List, CurrLetter),
	NewCol is Col + 1,
	lineCycle(Other, Puzzle, NewCol, Lin, 4).

/* 5X5 PUZZLES */
cycle([], _, 5, 5).
cycle([L1, L2, L3, L4, L5|Others], Puzzle, Lin, 5) :-	
	lineCycle([L1, L2, L3, L4, L5], Puzzle, 0, Lin, 5),
	NewLin is Lin + 1,
	cycle(Others, Puzzle, NewLin, 5).

lineCycle([], _, 5, _, 5).
lineCycle([CurrLetter|Other], Puzzle, Col, Lin, 5) :-
	getDir(Puzzle, Lin, Col, Dir),
	aponta2(Dir, Lin, Col, Puzzle, List),
	conditionalRestriction(List, CurrLetter),
	NewCol is Col + 1,
	lineCycle(Other, Puzzle, NewCol, Lin, 5).

getDir(Puzzle, Lin, Col, Dir) :-
	nth0(Lin, Puzzle, Line),
	nth0(Col, Line, Cell),
	nth0(0, Cell, Dir).

conditionalRestriction(Lista,0) :- length(Lista, Len), NewL is Len - 1, sum(Lista, #=, NewL).
conditionalRestriction(Lista,1) :- sum(Lista, #=, 2).

flatten(List, FlatList) :-
	flatten(List, [], FlatList0),
    !,
    FlatList = FlatList0.

flatten(Var, Tl, [Var|Tl]) :-
    var(Var),
    !.
flatten([], Tl, Tl) :- !.
flatten([Hd|Tl], Tail, List) :-
    !,
    flatten(Hd, FlatHeadTail, List),
    flatten(Tl, Tail, FlatHeadTail).
flatten(NonList, Tl, [NonList|Tl]).




