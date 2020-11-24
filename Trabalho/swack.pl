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

display_game(NextPlayer, Board) :-
	nl, nl,
	write('Initial Game Board'), nl,
	printBoard(4, Board), nl,
	Next is NextPlayer + 1,
	write('Current player: '), write(Next), nl.

playCycle :- 
	initial(first),
	board(A),
	repeatCycle(0, 0, A).

repeatCycle(NextPlayer, Pass, Board) :-
	write('Move or Pass? (move/pass)'),nl,
	read(Ans),nl,
	(Ans == pass ->
		(Pass == 1 -> 
			winner
		;
			Next is NextPlayer + 1,
			Player is mod(Next, 2),
			display_game(Player, Board),
			repeatCycle(Player, 1, Board) 
		)
	; 	makeMove(Board, NextPlayer)
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

	% check if both stacks have the same size
	(same_length(FBoardCol, BoardCol) ->
		(adjacent(Col, Lin, FCol, FLin) ->
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
						add(FinalP, FBoardCol, NewCell),
						replace(FCol, FBoardLine, NewCell, NewFLine),

						replace(FLin, NewBoard, NewFLine, FinalBoard),

						Player is mod(NextPlayer, 2),
						display_game(Player, FinalBoard), 
						repeatCycle(Player, 0, FinalBoard)
						; write('invalid')
					)
					; (FP == 1
						-> (P == 1 -> NewP is 2; NewP is 1),
						myreplace(BoardCol, New, NewP),
						replace(Col, BoardLine, New, NewLine),
						replace(Lin, Board, NewLine, NewBoard),

						NewNewP is mod(NewP, 2),
						FinalP is NewNewP + 1,
						add(FinalP, FBoardCol, NewCell),
						replace(FCol, FBoardLine, NewCell, NewFLine),
						replace(FLin, NewBoard, NewFLine, FinalBoard),

						Player is mod(NextPlayer, 2),
						display_game(Player, FinalBoard), 
						repeatCycle(Player, 0, FinalBoard)
						; write('invalid')
					)
				) 	
			)
		; write('Cells arent adjacent'), nl,
		makeMove(Board, Next)
		)
	; write('Stacks dont have the same size'), nl,
	makeMove(Board, Next)
	).

add(X,List,[X|List]).

myreplace([Head|Tail], New, Piece) :- append([], [Piece|Tail], New). 

adjacent(C, L1, C, L2) :- L1+1 =:= L2.
adjacent(C, L1, C, L2) :- L1-1 =:= L2.
adjacent(C1, L, C2, L) :- C1+1 =:= C2.
adjacent(C1, L, C2, L) :- C1+1 =:= C2.

replace(I, L, E, K) :-
  nth0(I, L, _, R),
  nth0(I, K, E, R).

winner :- write('Winner is ...').

initial(first) :-
	board(A),
	display_game(0, A).
    
