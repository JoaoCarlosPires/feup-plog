/* SWACK */

:- use_module(library(random)).
:- use_module(library(lists)).
:- use_module(library(system)).
:- ensure_loaded('board.pl').
:- ensure_loaded('display.pl').

play :-
	nl,
	write('*'), write('*************************************'), write('*'), nl,
	write('*'), space(37), write('*'), nl,
	write('*'), space(16), write('SWACK'), space(16), write('*'), nl,
	write('*'), space(37), write('*'), nl,
	write('*'), write('*************************************'), write('*'), nl,
	menu.

/* MENU */

menu :-
	drawMenu,
	get_code(Option), 
	skip_line,
	NOption is Option-48,
	playMode(NOption),
	playCycle.
	
drawMenu :-
	write('*'), space(37), write('*'), nl,
	write('*'), space(8), write('1. Player vs. Player'), space(9), write('*'), nl,
	write('*'), space(8), write('2. Player vs. Computer'), space(7), write('*'), nl,
	write('*'), space(8), write('3. Computer vs. Computer'), space(5), write('*'), nl,
	write('*'), space(37), write('*'), nl,
	write('*'), write('*************************************'), write('*'), nl.

playMode(1) :-
	nl, nl,
	write('Player 1: '), redPiece, write('   '),
	write('Player 2: '), whitePiece, nl.

playMode(2) :-
	nl, nl,
	write('Player 1: '), redPiece, write('   '),
	write('Computer 2: '), whitePiece, nl.

playMode(3) :-
	nl, nl,
	write('Computer 1: '), redPiece, write('   '),
	write('Computer 2: '), whitePiece, nl.

display_game(NextPlayer) :-
	board(A),
	nl, nl,
	write('Initial Game Board'), nl,
	printBoard(4, A), nl,
	Next is NextPlayer + 1,
	write('Next player: '), write(Next), nl.

playCycle :- 
	initial(first),
	repeatCycle(0, 0).

repeatCycle(NextPlayer, Pass) :-
	board(A),
	write('Move or Pass? (move/pass)'),nl,
	read(Ans),nl,
	(Ans == pass ->
		(Pass == 1 -> 
			winner
		;
			Next is NextPlayer + 1,
			Player is mod(Next, 2),
			display_game(Player),
			repeatCycle(Player, 1) 
		)
	; 	makeMove(A, NextPlayer),
		Next is NextPlayer + 1,
		Player is mod(Next, 2),
		display_game(Player), 
		repeatCycle(Player, 0)
	).

getInputPlay(Col, Lin) :-
	getColumn(Col),
	getLine(Lin).

getLine(Lin) :-
	write('Please specify line '),
	get_code(Li),
	skip_line,
	validateLine(Li, Lin).

getColumn(Col) :- 
	write('Please specify column '), 
	get_code(Co),
	skip_line,
	validateColumn(Co, Col).

validateColumn(65, Col) :- Col is 0.
validateColumn(66, Col) :- Col is 1.
validateColumn(67, Col) :- Col is 2.
validateColumn(68, Col) :- Col is 3.
validateColumn(_, Col) :- write('Invalid column letter\n\n'), getColumn(Col).

validateLine(48, Lin) :- Lin is 0.
validateLine(49, Lin) :- Lin is 1.
validateLine(50, Lin) :- Lin is 2.
validateLine(51, Lin) :- Lin is 3.
validateLine(_, Lin) :- write('Invalid line number\n\n'), getLine(Lin).

makeMove(Board, Next) :-
	getInputPlay(Col, Lin),
	nth0(Lin, Board, BoardLine),
	nth0(Col, BoardLine, BoardCol),
	nth0(0, BoardCol, P),
	NextPlayer is Next + 1,
	(P \= NextPlayer
		-> write('Cannot move an adversary piece!\n'),
		makeMove(Board, Next)
		; 
		(P == 1 -> NewP is 2; NewP is 1),
		myreplace(BoardCol, New, NewP),
		replace(Col, BoardLine, New, NewLine),
		replace(Lin, Board, NewLine, NewBoard),
		write(NewBoard), nl
	).

myreplace([Head|Tail], New, Piece) :- append([], [Piece|Tail], New). 

replace(I, L, E, K) :-
  nth0(I, L, _, R),
  nth0(I, K, E, R).

winner :- write('Winner is ...').

initial(first) :-
	display_game(0).
