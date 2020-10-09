/*
Casos de utilização
Exemplo de um tabuleiro do inicio do jogo
printBoard([
    [b-1, w-1, b-1, w-1, b-1, w-1, b-1, w-1],
    [w-1, b-1, w-1, b-1, w-1, b-1, w-1, b-1],
    [b-1, w-1, b-1, w-1, b-1, w-1, b-1, w-1],
    [w-1, b-1, w-1, b-1, w-1, b-1, w-1, b-1],
    [b-1, w-1, b-1, w-1, b-1, w-1, b-1, w-1],
    [w-1, b-1, w-1, b-1, w-1, b-1, w-1, b-1],
    [b-1, w-1, b-1, w-1, b-1, w-1, b-1, w-1],
    [w-1, b-1, w-1, b-1, w-1, b-1, w-1, b-1]
]).

Exemplo de um tabuleiro a meio do jogo
printBoard([
    [w-1, w-2, b-2, b-2, w-1, b-2, w-3, w-1],
    [w-2, b-3, b-3, b-2, w-1, b-2, w-4, b-3],
    [b-1, w-1, b-1, w-1, b-1, w-1, b-1, w-1],
    [w-2, b-1, b-2, b-1, w-1, b-3, w-1, w-2],
    [w-2, w-1, b-1, w-3, w-2, w-1, b-1, w-1],
    [w-2, b-1, w-1, w-1, w-2, b-2, w-3, b-1],
    [b-2, w-1, b-1, w-1, b-1, b-2, b-1, b-2],
    [b-1, b-2, b-2, b-1, w-3, w-3, b-2, w-1]
]).

*/

emptyBoard([
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0]
]).

initBoard([
    [b-1, w-1, b-1, w-1, b-1, w-1, b-1, w-1],
    [w-1, b-1, w-1, b-1, w-1, b-1, w-1, b-1],
    [b-1, w-1, b-1, w-1, b-1, w-1, b-1, w-1],
    [w-1, b-1, w-1, b-1, w-1, b-1, w-1, b-1],
    [b-1, w-1, b-1, w-1, b-1, w-1, b-1, w-1],
    [w-1, b-1, w-1, b-1, w-1, b-1, w-1, b-1],
    [b-1, w-1, b-1, w-1, b-1, w-1, b-1, w-1],
    [w-1, b-1, w-1, b-1, w-1, b-1, w-1, b-1]
]).

% To print the columns headers

l(1, L) :- L='A'.
l(2, L) :- L='B'.
l(3, L) :- L='C'.
l(4, L) :- L='D'.
l(5, L) :- L='E'.
l(6, L) :- L='F'.
l(7, L) :- L='G'.
l(8, L) :- L='H'.

printBoard(X) :-
    nl,
    write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |\n').
