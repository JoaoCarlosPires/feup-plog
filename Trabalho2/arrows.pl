%Arrow points right
aponta(1, _, 3, _, []).
aponta(1, Lin, Col, Puzzle, [Curr|Rest]) :- 
	NewCol is Col + 1,
	getPos(Lin, NewCol, Puzzle, Curr), 
	aponta(1, Lin, NewCol, Puzzle, Rest).
	
%Arrow points down right
aponta(2, _, 3, _, []).
aponta(2, 3, _, _, []).
aponta(2, Lin, Col, Puzzle, [Curr|Rest]) :-
	NewCol is Col + 1,
	NewLin is Lin + 1,
	getPos(NewLin, NewCol, Puzzle, Curr), 
	aponta(2, NewLin, NewCol, Puzzle, Rest).
	
%Arrow points down left 
aponta(3, _, 0, _, []).
aponta(3, 3, _, _, []).
aponta(3, Lin, Col, Puzzle, [Curr|Rest]) :-
	NewCol is Col - 1,
	NewLin is Lin + 1,
	getPos(NewLin, NewCol, Puzzle, Curr), 
	aponta(3, NewLin, NewCol, Puzzle, Rest).

%Arrow points left
aponta(4, _, 0, _, []).
aponta(4, Lin, Col, Puzzle, [Curr|Rest]) :- 
	NewCol is Col - 1,
	getPos(Lin, NewCol, Puzzle, Curr), 
	aponta(4, Lin, NewCol, Puzzle, Rest).
	
%Arrow points up left
aponta(5, _, 0, _, []).
aponta(5, 0, _, _, []).
aponta(5, Lin, Col, Puzzle, [Curr|Rest]) :-
	NewCol is Col - 1,
	NewLin is Lin - 1,
	getPos(NewLin, NewCol, Puzzle, Curr), 
	aponta(5, NewLin, NewCol, Puzzle, Rest).
	
%Arrow points up right
aponta(6, _, 3, _, []).
aponta(6, 0, _, _, []).
aponta(6, Lin, Col, Puzzle, [Curr|Rest]) :-
	NewCol is Col + 1,
	NewLin is Lin - 1,
	getPos(NewLin, NewCol, Puzzle, Curr), 
	aponta(6, NewLin, NewCol, Puzzle, Rest).

%Arrow points down
aponta(7, 3, _, _, []).
aponta(7, Lin, Col, Puzzle, [Curr|Rest]) :- 
	NewLin is Lin + 1,
	getPos(NewLin, Col, Puzzle, Curr), 
	aponta(7, NewLin, Col, Puzzle, Rest).

%Arrow points up
aponta(8, 0, _, _, []).
aponta(8, Lin, Col, Puzzle, [Curr|Rest]) :- 
	NewLin is Lin - 1,
	getPos(NewLin, Col, Puzzle, Curr), 
	aponta(8, NewLin, Col, Puzzle, Rest).

getPos(Lin, Col, Puzzle, Cell) :-
	nth0(Lin, Puzzle, Line),
	nth0(Col, Line, Aux),
	nth0(1, Aux, Cell).

    




