/* SWACK */

:- use_module(library(random)).
:- use_module(library(lists)).
:- use_module(library(system)).
:- ensure_loaded('board.pl').
:- ensure_loaded('display.pl').
:- ensure_loaded('input.pl').
:- ensure_loaded('simplify.pl').
:- ensure_loaded('winner.pl').


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
	resetFile,
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
	nl,	write('Current Game Board'), nl,
	printBoard(4, Board), nl,
	Next is NextPlayer + 1,
	write('Current player: '), write(Next), nl.

playCycle :- 
	initial(A),
	board(A),
	repeatCycle(0, 0, A).

repeatCycle(NextPlayer, Pass, Board) :-
	write('Move or Pass? (move/pass)'),nl,
	read(Ans),nl,
	Next is NextPlayer + 1,
	Player is mod(Next, 2),
	(Ans == pass ->
		(Pass == 1 -> 
			game_over(Board, Player)
		;
			display_game(Player, Board),
			repeatCycle(Player, 1, Board) 
		)
	; 	move(Board, NextPlayer, 0)
	).

move(Board, Next, _) :-
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
				move(Board, Next, 0)
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
		move(Board, Next, 0)
		)
	; write('Stacks dont have the same size'), nl,
	move(Board, Next, 0)
	).

add(X,List,[X|List]).

myreplace([_|Tail], New, Piece) :- append([], [Piece|Tail], New). 

adjacent(C, L1, C, L2) :- L1+1 =:= L2.
adjacent(C, L1, C, L2) :- L1-1 =:= L2.
adjacent(C1, L, C2, L) :- C1+1 =:= C2.
adjacent(C1, L, C2, L) :- C1+1 =:= C2.

replace(I, L, E, K) :-
  nth0(I, L, _, R),
  nth0(I, K, E, R).

game_over(FinalB, LastPlayer) :- 
	
	getSimplified(FinalB, Simplified),
	
	value(Simplified, 1, 0),
	value(Simplified, 2, 0),
	
	readFile(1, P1Points),
	readFile(2, P2Points),
	
	without_last(P1Points, P1),
	sort(P1, S1),
	reverse(S1, Sorted1),
	
	without_last(P2Points, P2),
	sort(P2, S2),
	reverse(S2, Sorted2),
	
	write('The winner is '),
	getWinner(Sorted1, Sorted2, LastPlayer).

getWinner([], _, 0) :- write('Player 2!\n').
getWinner([], _, 1) :- write('Player 1!\n').

getWinner(_, [], 1) :- write('Player 1!\n').
getWinner(_, [], 0) :- write('Player 2!\n').

getWinner([P1|Rest1], [P2|Rest2], LastPlayer) :-
	(P1 =:= P2
		-> getWinner(Rest1, Rest2, LastPlayer)
		; (P1 > P2
			-> write('Player 1!\n')
			; write('Player 2!\n')
		)
	).

initial(A) :-
	board(A),
	display_game(0, A).

% The without_last predicate is based on
% https://stackoverflow.com/questions/16174681/how-to-delete-the-last-element-from-a-list-in-prolog
without_last([_], []).
without_last([X|Xs], [X|WithoutLast]) :- 
    without_last(Xs, WithoutLast).
    
