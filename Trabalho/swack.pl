/* SWACK */

:- use_module(library(random)).
:- use_module(library(lists)).
:- use_module(library(system)).
:- ensure_loaded('board.pl').
:- ensure_loaded('display.pl').
:- ensure_loaded('input.pl').

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
	write('*'), space(37), write('*'), nl,
	write('*'), space(8), write('1. Player vs. Player'), space(9), write('*'), nl,
	write('*'), space(8), write('2. Player vs. Computer'), space(7), write('*'), nl,
	write('*'), space(37), write('*'), nl,
	write('*'), write('*************************************'), write('*'), nl,
	menuInput(Option, 1, 2),
	NOption is Option-48,
	playMode(NOption).

playMode(1) :-
	nl, nl,
	write('Player1: '), redPiece, write('   '),
	write('Player2: '), whitePiece, nl,
	display_game(first, 1),
	display_game(intermediate, 1),
	display_game(final, 1).

playMode(2) :-
	nl, nl,
	write('Player: '), redPiece, write('   '),
	write('Computer: '), whitePiece, nl,
	display_game(first, 1),
	display_game(intermediate, 1),
	display_game(final, 1).
	
display_game(first, 1) :-
	board(A),
	nl, nl,
	write('Initial Game Board'), nl,
	printBoard(4, A), nl.

display_game(intermediate, 1) :-
	board(B),
	nl, nl,
	write('Intermediate Game Board'), nl,
	printBoard(4, B), nl.

display_game(final, 1) :-
	board(C),
	nl, nl,
	write('Final Game Board'), nl,
	printBoard(4, C), nl.

initial(first) :- 
	display_game(first, 1).
