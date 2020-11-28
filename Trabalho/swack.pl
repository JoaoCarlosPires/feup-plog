/* SWACK */

:- use_module(library(random)).
:- use_module(library(lists)).
:- use_module(library(system)).
:- use_module(library(random)).
:- ensure_loaded('board.pl').
:- ensure_loaded('display.pl').
:- ensure_loaded('input.pl').
:- ensure_loaded('simplify.pl').
:- ensure_loaded('winner.pl').
:- ensure_loaded('additional.pl').
:- ensure_loaded('moves.pl').

play :-
	drawHeader,
	menu.

/* MENU */

menu :-
	resetFile(1),
	drawMenu,
	get_code(Option), 
	skip_line,
	NOption is Option-48,
	playMode(NOption),
	playCycle(NOption).

display_game(NextPlayer, Board) :-
	nl,	write('Current Game Board'), nl,
	printBoard(4, Board), nl,
	Next is NextPlayer + 1,
	write('Current player: '), write(Next), nl.

playCycle(NOption) :- 
	initial(A),
	board(A),
	repeatCycle(0, 0, A, NOption).

repeatCycle(NextPlayer, Pass, Board, 1) :-
	write('Move or Pass? (move/pass)'),nl,
	read(Ans),nl,
	Next is NextPlayer + 1,
	Player is mod(Next, 2),
	(Ans == pass ->
		(Pass == 1 -> 
			game_over(Board, Player)
		;
			display_game(Player, Board),
			repeatCycle(Player, 1, Board, 1) 
		)
	; 	move(Board, NextPlayer, 1)
	).

% Player vs Computer - Player turn
repeatCycle(0, Pass, Board, 2) :- 
	write('Move or Pass? (move/pass)'),nl,
	read(Ans),nl,
	(Ans == pass ->
		(Pass == 1 -> 
			game_over(Board, 1)
		;
			display_game(1, Board),
			repeatCycle(1, 1, Board, 2)
		)
	; 	move(Board, 0, 2)
	).

% Player vs Computer - Computer turn
repeatCycle(1, Pass, Board, 2) :-
	random(1, 3, PP),
	write(PP), nl, 
	(PP == 1 -> 
		(Pass == 1 -> 
			game_over(Board, 2)
		;
			display_game(0, Board),
			repeatCycle(0, 1, Board, 2)
		)
	; resetFile(2),
	validMoves(Board, 2, ListOfMoves),
	without_last(ListOfMoves, NewList),
	length(NewList, L),
	Bound is L + 1,
	random(1, Bound, Index),
	getPlay(Board, NewList, Index)
	).

repeatCycle(NextPlayer, Pass, Board, 3).

getPlay(Board, [Head|_], 1) :- !, computerMove(Board, 1, 2, Head).
getPlay(Board, [_|Tail], Idx) :- NewI is Idx - 1, getPlay(Board, Tail, NewI).

computerMove(Board, Next, NOption, [Lin, Col, FLin, FCol]) :-
	write('Moving from '), 
	write(Lin), 
	write(','), 
	write(Col), 
	write(' to '), 
	write(FLin),
	write(','), 
	write(FCol), nl,

	nth0(Lin, Board, BoardLine),
	nth0(Col, BoardLine, BoardCol),
	nth0(0, BoardCol, P),

	nth0(FLin, Board, FBoardLine),
	nth0(FCol, FBoardLine, FBoardCol),
	nth0(0, FBoardCol, FP),

	NextPlayer is Next + 1,
	
	(NextPlayer == 1 
		-> (FP == 2
			-> myreplace(BoardCol, New, 2),
			replace(Col, BoardLine, New, NewLine),
			replace(Lin, Board, NewLine, NewBoard),

			add(1, FBoardCol, NewCell),
			replace(FCol, FBoardLine, NewCell, NewFLine),
			replace(FLin, NewBoard, NewFLine, FinalBoard),

			Player is mod(NextPlayer, 2),
			display_game(Player, FinalBoard), 
			repeatCycle(Player, 0, FinalBoard, NOption)
			; write('invalid')
		)
		; (FP == 1
			-> myreplace(BoardCol, New, 1),
			replace(Col, BoardLine, New, NewLine),
			replace(Lin, Board, NewLine, NewBoard),

			add(2, FBoardCol, NewCell),
			replace(FCol, FBoardLine, NewCell, NewFLine),
			replace(FLin, NewBoard, NewFLine, FinalBoard),

			Player is mod(NextPlayer, 2),
			display_game(Player, FinalBoard), 
			repeatCycle(Player, 0, FinalBoard, NOption)
			; write('invalid')
		)
	).

move(Board, Next, NOption) :-
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
						repeatCycle(Player, 0, FinalBoard, NOption)
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
						repeatCycle(Player, 0, FinalBoard, NOption)
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

initial(A) :-
	board(A),
	display_game(0, A).




    
