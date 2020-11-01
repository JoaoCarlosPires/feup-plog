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
	display_game(first, 1),
	display_game(intermediate, 2),
	display_game(final, 1).

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

display_game(first, NextPlayer) :-
	first(A),
	nl, nl,
	write('Initial Game Board'), nl,
	printBoard(4, A), nl,
	write('Next player: '), write(NextPlayer), nl.

display_game(intermediate, NextPlayer) :-
	intermediate(A),
	nl, nl,
	write('Intermediate Game Board'), nl,
	printBoard(4, A), nl,
	write('Next player: '), write(NextPlayer), nl.

/* Quando o board está no estado final, tanto faz qual o 
   número do jogador a efetuar a próxima jogada, dado que na realidade
   já terminou e não haverá mais jogadas. */
display_game(final, _) :-
	final(A),
	nl, nl,
	write('Final Game Board'), nl,
	printBoard(4, A), nl.

initial(first) :- 
	display_game(first, 1).
