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
	write('Move or Pass? (move/pass)'),nl,
	read(Ans),nl,
	(Ans == pass ->
		(Pass == 1 -> 
			winner(A)
		;
			Next is NextPlayer + 1,
			Player is mod(Next, 2),
			display_game(Player),
			repeatCycle(Player, 1) 
		)
	; 	% makeMove(A),
		Next is NextPlayer + 1,
		Player is mod(Next, 2),
		display_game(Player), 
		repeatCycle(Player, 0)
	).

% makeMove(board) :- 

winner(board) :- write('Winner is ...').

initial(first) :- 
	display_game(0).
