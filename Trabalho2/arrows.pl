/*guardar numa Lista as setas na direção da seta em questão
	case(Direcao, Linha, Coluna, Cor, Puzzle, [], List) */

%Arrow points down
aponta(7, Lin, Col, Cor, Puzzle, Lista) :- 
	newLin is Lin + 1,
	getPos(newLin, Col, Puzzle, Cell),
	(var(Cell) -> aponta(7, NewLine, Col, Cor, Puzzle, [Cell|Lista]);
	aponta(8, newLin, Col, Cor, Puzzle,Lista)).

%Arrow points up
aponta(8, Lin, Col, Cor, Puzzle, Lista) :- 
	newLin is Lin - 1,
	getPos(newLin, Col, Puzzle, Cell),
	(var(Cell) -> aponta(8, NewLine, Col, Cor, Puzzle, [Cell|Lista]);
	aponta(8, newLin, Col, Cor, Puzzle, Lista)).

%Arrow points right
aponta(1, Lin, Col, Cor, Puzzle, Lista) :- 
	newCol is Col + 1,
	getPos(Lin, newCol, Puzzle, Cell), 
	(var(Cell) -> aponta(1, NewLine, Col, Cor, Puzzle, [Cell|Lista]);
	aponta(1, Lin, newCol, Cor, Puzzle, Lista)).
	
%Arrow points down right
aponta(2, Lin, Col, Cor, Puzzle, Lista) :-
	newCol is Col + 1,
	getPos(Lin, newCol, Puzzle, Cell),
	(var(Cell) -> aponta(2, NewLine, Col, Cor, Puzzle, [Cell|Lista]);
	aponta(2, Lin, newCol, Cor, Puzzle, Lista)),
	
	newLin is Lin + 1,
	getPos(newLin, newCol, Puzzle, Cell),
	(var(Cell) -> aponta(2, NewLine, Col, Cor, Puzzle, [Cell|Lista]);					
	aponta(2, newLin, newCol, Cor, Puzzle, Lista)).
	
%Arrow points down left 
aponta(3, Lin, Col, Cor, Puzzle, Lista) :-
	newCol is Col + 1,
	getPos(Lin, newCol, Puzzle, Cell),
	(var(Cell) -> aponta(3, NewLine, Col, Cor, Puzzle, [Cell|Lista]);
	aponta(3, Lin, newCol, Cor, Puzzle, Lista)),
	
	newLin is Lin-1,
	getPos(newLin, newCol, Puzzle, Cell),
	(var(Cell) -> aponta(3, NewLine, Col, Cor, Puzzle, [Cell|Lista]);
	aponta(3, newLin, newCol, Cor, Puzzle, Lista)).

%Arrow points left
aponta(4, Lin, Col, Cor, Puzzle, Lista) :-
	newCol is Col - 1,
	getPos(Lin, newCol, Puzzle, Cell),
	(var(Cell) -> aponta(4, NewLine, Col, Cor, Puzzle, [Cell|Lista]);
	aponta(4, Lin, newCol, Cor, Puzzle, Lista)).
	
%Arrow points up left
aponta(5, Lin, Col, Cor, Puzzle, Lista) :-
	newCol is Col - 1,
	getPos(Lin, newCol, Puzzle, Cell),
	(var(Cell) -> aponta(5, NewLine, Col, Cor, Puzzle, [Cell|Lista]);
	aponta(5, Lin, newCol, Cor, Puzzle, Lista)),
	
	newLin is Lin - 1,
	getPos(newLin, newCol, Puzzle, Cell),
	(var(Cell) -> aponta(5, NewLine, Col, Cor, Puzzle, [Cell|Lista]);
	aponta(5, newLin, newCol, Cor, Puzzle, Lista)).
	
%Arrow points up right
aponta(6, Lin, Col, Cor, Puzzle, Lista) :-
	newCol is Col - 1,
	getPos(Lin, newCol, Puzzle, Cell),
	(var(Cell) -> aponta(6, NewLine, Col, Cor, Puzzle, [Cell|Lista]);
	aponta(6, Lin, newCol, Cor, Puzzle, Lista)),
	
	newLin is Lin + 1,
	getPos(newLin, newCol, Puzzle, Cell),
	(var(Cell) -> aponta(6, NewLine, Col, Cor, Puzzle, [Cell|Lista]);
	aponta(6, newLin, newCol, Cor, Puzzle, Lista)).

getPos(Lin, Col, Puzzle, Cell) :-
	nth1(Col, Puzzle, Lin),
	nth1(Lin, Lin, Cell).
getPos(_, _, _, _).

% fazer um predicado que coloca numa lista
% as setas cuja cor é tan, restricao Cor #= 1

    




