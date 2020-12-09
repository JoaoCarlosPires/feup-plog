/* DISPLAY */

/* Print Puzzle */
printPuzzle(Size, Puzzle) :-
	nl, 
	printArrows(0, Size, Puzzle).

/* Puzzle */
printArrows(_,_, []).

printArrows(0, Size, [Line|Puzzle]) :-
	printArrow(0, Size, Line),
	printArrows(1, Size, Puzzle).

printArrows(Currentline, Size, [Line|Puzzle]) :-
	printArrow(Currentline, Size, Line),
	Nextline is Currentline+1,
	printArrows(Nextline, Size, Puzzle).

/* Setas */
printArrow(Currline, _, Line) :-
	write(' '),
	printArrow(Line),
	nl.

printArrow([]).

printArrow([0|Line]) :-
	printArrow(Line).

printArrow([1|Line]) :-
	write(' '),
	right,
	write(' '),
	printArrow(Line).

printArrow([2|Line]) :-
	write(' '),
	downright,
	write(' '),
	printArrow(Line).

printArrow([3|Line]) :-
	write(' '),
	downleft,
	write(' '),
	printArrow(Line).

printArrow([4|Line]) :-
	write(' '),
	left,
	write(' '),
	printArrow(Line).

printArrow([5|Line]) :-
	write(' '),
	upleft,
	write(' '),
	printArrow(Line).

printArrow([6|Line]) :-
	write(' '),
	upright,
	write(' '),
	printArrow(Line).

printArrow([7|Line]) :-
	write(' '),
	down,
	write(' '),
	printArrow(Line).

printArrow([8|Line]) :-
	write(' '),
	up,
	write(' '),
	printArrow(Line).	

/* Characteres */

up :- put_code(8593).
down :- put_code(8595).
right :- put_code(8594).
left :- put_code(8592).
upleft :- put_code(8598).
downleft :- put_code(8601).
upright :- put_code(8599).
downright :- put_code(8600).

% right - 1
% downRight - 2 
% downLeft - 3 
% left - 4 
% upLeft - 5 
% upRight - 6 
% down - 7 
% up - 8

