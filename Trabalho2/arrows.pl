/*guardar numa Lista as setas na direção da seta em questão
	case(Direcao,Linha, Coluna, Puzzle, [], List) */

%Arrow points down
aponta(7, Lin, Col, Puzzle, Lista, Final) :- 
	newCol is Col + 1,
	getPos(Lin, newCol, Puzzle, Cell),
	(Cell = -1 -> (reverse(Lista, Final), true);
	(var(Cell) -> aponta(8, Lin, newCol, Puzzle, [Cell|Lista], Final);
	aponta(8, Lin, newCol, Puzzle,Lista, Final))).

%Arrow points up
aponta(8, Lin, Col, Puzzle, Lista, Final) :- 
	newCol is Col - 1,
	getPos(Lin, newCol, Puzzle, Cell),
	(Cell = -1 -> (reverse(Lista, Final), true);
	(var(Cell) -> aponta(8, Lin, newCol, Puzzle, [Cell|Lista], Final);
	aponta(8, Lin, newCol, Puzzle,Lista, Final))).

%Arrow points right
aponta(1, Lin, Col, Puzzle, Lista, Final) :- 
	newLin is Lin + 1,
	getPos(newLin, Col, Puzzle, Cell), 
	(Cell = -1 -> (reverse(Lista, Final), true); 
	(var(Cell) -> aponta(1, newLin, Col, Puzzle, [Cell|Lista], Final);
	aponta(1, newLin, Col, Puzzle, Lista, Final))).
	
%Arrow points down right
aponta(2, Lin, Col, Puzzle, Lista, Final) :-
	newCol is Col + 1,
	((getPos(Lin, newCol, Puzzle, Cell),
	(Cell = -1 -> (reverse(Lista, Final), true);
	(var(Cell) -> aponta(2,Lin, newCol, Puzzle, [Cell|Lista], Final);
	aponta(2, Lin, newCol, Puzzle, Lista, Final))));
	
	(newLin is Lin + 1,
	getPos(newLin, newCol, Puzzle, Cell),					
	(Cell = -1 -> (reverse(Lista, Final), true);
	(var(Cell) -> aponta(2, newLin, newCol, Puzzle, [Cell|Lista], Final);
	aponta(2, newLin, newCol, Puzzle, Lista, Final))))).
	
%Arrow points down left 
aponta(3, Lin, Col, Puzzle, Lista, Final) :-
	newCol is Col + 1,
	((getPos(Lin, newCol, Puzzle, Cell),
	(Cell = -1 -> (reverse(Lista, Final), true);
	(var(Cell) -> aponta(3, Lin, newCol, Puzzle, [Cell|Lista], Final);
	aponta(3, Lin, newCol, Puzzle, Lista, Final))));
	
	(newLin is Lin-1,
	getPos(newLin, newCol, Puzzle, Cell),
	(Cell = -1 -> (reverse(Lista, Final), true);
	(var(Cell) -> aponta(3, newLin, newCol, Puzzle, [Cell|Lista], Final);
	aponta(3, newLin, newCol, Puzzle, Lista, Final))))).

%Arrow points left
aponta(4, Lin, Col, Puzzle, Lista, Final) :-
	newLin is Line - 1,
	getPos(newLin, Col, Puzzle, Cell),
	(Cell = -1 -> (reverse(Lista, Final), true);
	(var(Cell) -> aponta(4, newLin, Col, Puzzle, [Cell|Lista], Final);
	aponta(4, newLin, Col, Puzzle, Lista, Final))).
	
%Arrow points up left
aponta(5, Lin, Col, Puzzle, Lista, Final) :-
	newCol is Col - 1,
	((getPos(Lin, newCol, Puzzle, Cell),
	(Cell = -1 -> (reverse(Lista, Final), true);
	(var(Cell) -> aponta(5, Lin, newCol, Puzzle, [Cell|Lista], Final);
	aponta(5, Lin, newCol, Puzzle,Lista, Final))));
	
	(newLin is Lin - 1,
	getPos(newLin, newCol, Puzzle, Cell),
	(Cell = -1 -> (reverse(Lista, Final), true);
	(var(Cell) -> aponta(5, newLin, newCol, Puzzle,[Cell|Lista], Final);
	aponta(5, newLin, newCol, Puzzle, Lista, Final))))).
	
%Arrow points up right
aponta(6, Lin, Col, Puzzle,Lista, Final) :-
	newCol is Col - 1,
	((getPos(Lin, newCol, Puzzle, Cell),
	(Cell = -1, reverse(Lista, Final);
	var(Cell), 
	aponta(6, Lin, newCol, Puzzle,[Cell|Lista], Final);
	aponta(6, Lin, newCol, Puzzle, Lista, Final)));
	
	(newLin is Lin + 1,
	getPos(newLin, newCol, Puzzle, Cell),
	(Cell = -1 -> (reverse(Lista, Final), true);
	(var(Cell) -> aponta(6, newLin, newCol, Puzzle,[Cell|Lista], Final);
	aponta(6, newLin, newCol, Puzzle, Lista, Final))))).

getPos(Lin, Col, Puzzle, Cell) :-
	nth1(Col, Puzzle, Lin),
	nth1(Lin, Lin, Cell).
getPos(_, _, _, -1).