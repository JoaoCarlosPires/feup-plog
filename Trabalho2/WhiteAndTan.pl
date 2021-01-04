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
	puzzleOption(NOption, P),
	solve(P).

solve :-
	reset_timer,
	setRestrictions,
	print_time,
	fd_statistics.

setRestrictions :- 
	%getLetters(Puzzle, Letters),
	%flatten(Letters, FL),
	domain([A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P], 0, 1),
	conditionalRestriction([B, C, D],A),
	conditionalRestriction([G, L],B),
	conditionalRestriction([G, K, O],C),
	conditionalRestriction([G, J, M],D),
	conditionalRestriction([F, G, H],E),
	conditionalRestriction([K, P],F),
	conditionalRestriction([E, F],G),
	conditionalRestriction([K, N],H),
	conditionalRestriction([F, C],I),
	conditionalRestriction([K, L],J),
	conditionalRestriction([G, C],K),
	conditionalRestriction([H, D],L),
	conditionalRestriction([J, G, D],M),
	conditionalRestriction([O, P],N),
	conditionalRestriction([J, E],O),
	conditionalRestriction([K, F, A],P),
	labeling([], [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P]),
	write(A-B-C-D-E-F-G-H-I-J-K-L-M-N-O-P).
	%cycle(Puzzle, 0).

getLetters([], []).
getLetters([CurrLine|NextLines], [CurrLetters|Rest]) :-
	getLineLetters(CurrLine, CurrLetters),
	getLetters(NextLines, Rest).

getLineLetters([], []).
getLineLetters([CurrCell|Others], [Curr|Other]) :-
	getLetter(CurrCell, Curr),
	getLineLetters(Others, Other).

getLetter([Direction, Letter], L) :- L = Letter.
getDirection([Direction, Letter], D) :- D = Direction.

%for each letter, get list of in-direction letters
%for each obtained list, call conditionalRestriction

cycle(_, 4).
cycle([CurrLine | NextLines], Lin) :- 
	lineCycle(CurrLine, 0, Lin, [CurrLine | NextLines]),
	NewL is Lin + 1.
	cycle(NextLines, NewL).

lineCycle(_, 4, _, _).
lineCycle([Cell|Others], Col, Lin, Puzzle) :-
	getLetter(Cell, L),
	getDirection(Cell, D),
	aponta(D, Lin, Col, L, Puzzle, List),
	conditionalRestriction(List, L),
	NewC is Col + 1.
	lineCycle(Others, NewC).


reset_timer :- statistics(walltime,_).	
print_time :-
	statistics(walltime,[_,T]),
	TS is ((T//10)*10)/1000,
	nl, write('Time: '), write(TS), write('s'), nl, nl.

conditionalRestriction(List,0) :- length(List, L), NewL is L - 1, sum(List, #=, NewL).
conditionalRestriction(List,1) :- sum(List, #=, 2).

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




