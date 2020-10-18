/* SWACK */

:- use_module(library(random)).
:- use_module(library(lists)).
:- use_module(library(system)).
:- ensure_loaded('board.pl').
:- ensure_loaded('display.pl').
:- ensure_loaded('input.pl').

swack :-
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
	board(B),
	nl, nl,
	write('Player1: '), blackPiece, write('   '),
	write('Player2: '), whitePiece, nl,
	printBoard(10, B), nl.

playMode(2) :-
	board(B),
	nl, nl,
	write('Player: '), blackPiece, write('   '),
	write('Computer: '), whitePiece, nl,
	printBoard(10, B), nl.
