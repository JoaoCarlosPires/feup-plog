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
	write('Player2: '), whitePiece, nl.

playMode(2) :-
	nl, nl,
	write('Player: '), redPiece, write('   '),
	write('Computer: '), whitePiece, nl.
	
/*
	display_game(first, 1). ou display_game(first, 2). 
	display_game(intermediate, 1). ou display_game(intermediate, 2).
	display_game(final, 1). ou display_game(final, 1). 
*/

/* Como o primeiro a jogar é sempre o jogador vermelho
   (Player 1), qualquer que seja o segundo argumento, 
   será sempre indicado que o próximo a jogar será o Player 1. */
display_game(first, _) :-
	first(A),
	nl, nl,
	write('Initial Game Board'), nl,
	printBoard(4, A), nl,
	write('Next player: Player 1'), nl.

display_game(intermediate, NextPlayer) :-
	intermediate(A),
	nl, nl,
	write('Intermediate Game Board'), nl,
	printBoard(4, A), nl,
	write('Next player: Player '), write(NextPlayer), nl.

/* Quando o board está no estado final, tanto faz qual o 
   número do jogador a efetuar a próxima jogada, dado que na realidade
   já terminou e não haverá mais jogadas.*/
display_game(final, _) :-
	final(A),
	nl, nl,
	write('Final Game Board'), nl,
	printBoard(4, A), nl.

/* A passagem do argumento 1 deve-se ao facto de que é sempre
   o jogador vermelho (Player 1) a começar a jogar */
initial(first) :- 
	display_game(first, 1).
