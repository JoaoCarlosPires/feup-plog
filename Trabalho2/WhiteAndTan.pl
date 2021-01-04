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
	menuInput(Option, 1, 5),
	NOption is Option-48,
	puzzle(NOption, Puzzle),
	solve(Puzzle).

solve(Puzzle) :-
	reset_timer,
	setRestrictions(Puzzle),
	print_time,
	fd_statistics.

getLetters([], []).
getLetters([CurrLine|NextLines], [CurrLetters|Rest]) :-
	getLineLetters(CurrLine, CurrLetters),
	getLetters(NextLines, Rest).

getLineLetters([], []).
getLineLetters([CurrCell|Others], [Curr|Other]) :-
	getLetter(CurrCell, Curr),
	getLineLetters(Others, Other).

getLetter([Direction, Letter], Letter).

setRestrictions(Puzzle) :-
	getLetters(Puzzle, Letters),
	flatten(Letters, Fla),
	domain(Fla, 0, 1),
	cycle(Fla, Puzzle, 0),
	labeling([], Fla),
	write(Fla).

cycle([], _, 4).
cycle([L1, L2, L3, L4|Others], Puzzle, Lin) :-
	lineCycle([L1, L2, L3, L4], Puzzle, 0, Lin),
	NewLin is Lin + 1,
	cycle(Others, Puzzle, NewLin).

lineCycle([], _, 4, _).
lineCycle([CurrLetter|Other], Puzzle, Col, Lin) :-
	getDir(Puzzle, Lin, Col, Dir),
	aponta(Dir, Lin, Col, Puzzle, List),
	conditionalRestriction(List, CurrLetter),
	NewCol is Col + 1,
	lineCycle(Other, Puzzle, NewCol, Lin).

getDir(Puzzle, Lin, Col, Dir) :-
	nth0(Lin, Puzzle, Line),
	nth0(Col, Line, Cell),
	nth0(0, Cell, Dir).

reset_timer :- statistics(walltime,_).	
print_time :-
	statistics(walltime,[_,T]),
	TS is ((T//10)*10)/1000,
	nl, write('Time: '), write(TS), write('s'), nl, nl.

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




