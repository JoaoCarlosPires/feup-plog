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

makeMove(Board, Next) :-
	getInputPlay(Col, Lin),
	getFInputPlay(FCol, FLin),

	nth0(Lin, Board, BoardLine),
	nth0(Col, BoardLine, BoardCol),
	nth0(0, BoardCol, P),

	nth0(FLin, Board, FBoardLine),
	nth0(FCol, FBoardLine, FBoardCol),
	nth0(0, FBoardCol, FP),
	
	NextPlayer is Next + 1,
	(P \= NextPlayer
		-> write('Cannot move an adversary piece!'), nl,
		makeMove(Board, Next)
		;
		(NextPlayer == 1 
			-> (FP == 2
				-> (P == 1 -> NewP is 2; NewP is 1),
				myreplace(BoardCol, New, NewP),
				replace(Col, BoardLine, New, NewLine),
				replace(Lin, Board, NewLine, NewBoard),

				NewNewP is mod(NewP, 2),
				FinalP is NewNewP + 1,
				append([FinalP], [FBoardCol], NewCell),
				write(NewCell),
				replace(FCol, FBoardLine, NewCell, NewFLine),
				replace(FLin, NewBoard, NewFLine, FinalBoard),

				write(FinalBoard)
				; write('invalid')
			   )
			; (FP == 1
				-> (P == 1 -> NewP is 2; NewP is 1),
				myreplace(BoardCol, New, NewP),
				replace(Col, BoardLine, New, NewLine),
				replace(Lin, Board, NewLine, NewBoard),

				NewNewP is mod(NewP, 2),
				FinalP is NewNewP + 1,
				append([FinalP], [FBoardCol], NewCell),
				write(NewCell),
				replace(FCol, FBoardLine, NewCell, NewFLine),
				replace(FLin, NewBoard, NewFLine, FinalBoard),

				write(FinalBoard)
				; write('invalid')
			  )
		) 
		
	).

myreplace([Head|Tail], New, Piece) :- append([], [Piece|Tail], New). 

replace(I, L, E, K) :-
  nth0(I, L, _, R),
  nth0(I, K, E, R).

winner :- write('Winner is ...').

initial(first) :-
	display_game(0).
