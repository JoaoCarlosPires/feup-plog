# Programação em Lógica - Trabalho Prático

## Identificação

- Identificação do trabalho: Swack_2
- Elementos do Grupo:
    - João Carlos Machado Rocha Pires (up201806079)
    - Maria Marta Nunes Andrade Lobo dos Santos (up201604530)
- Turma Prática 5

## Instalação e Execução do Jogo

Tanto em Windows como em Linux, antes da consulta do *swack.pl*, deverá ser alterado o path em todas as chamadas *open* dos predicados do ficheiro *winner.pl* (predicados *writeToFile*, *resetFile*, *readFile*). Este path deverá ser o caminho para os ficheiros *player1.txt*, *player2.txt* e *moves.txt*, contidos na pasta /files, junto com os ficheiros *.pl* .

**Windows e Linux**

```
consult('swack.pl')

play.
```  

**Nota:** No Linux, os caracteres usados para a representação das peças originam um maior espaçamento. Dado que o trabalho foi desenvolvido em Windows, não é garantido o alinhamento das peças no Linux. Ainda assim, trata-se apenas de um pormenor visual, que em nada afeta a jogabilidade e o bom funcionamento do jogo.

## O Jogo Swack

Swack é um jogo de tabuleiro para dois jogadores (Vermelho/Branco). O tabuleiro é um quadrado 4x4, com células quadradas.

No início, todas as células estão preenchidas com peças vermelhas/brancas de forma alternada, em xadrez. Em tabuleiros com número de células ímpares, a célula central é preenchida com uma peça branca. Cada jogador tem um número de peças infinitas da sua cor fora do tabuleiro.

Células adjacentes significam células ortogonalmente adjacentes.

Uma stack é um conjunto de uma ou mais peças empilhadas dentro da mesma célula. A cor da stack é a cor da peça do topo, que determina o seu "dono". O tamanho da stack é o número de peças nela contidas.

Um grupo é um conjunto de stacks adjacentes de cor igual. O tamanho de um grupo corresponde ao número de stacks que o formam.

O jogador com as peças vermelhas começa e as jogadas são feitas de forma alternada. 

Em cada jogada, o jogador poderá:

- Passar

- Mover uma peça da sua cor do topo de uma stack para uma stack adjacente cuja cor seja a do adversário, considerando que o tamanho de ambas as stacks é igual antes da realização do movimento. Depois, colocar uma peça da cor do adversário, exterior ao tabuleiro, no topo da stack de onde a peça do atual jogador foi retirada.

O jogo termina quando os jogadores decidem passar de forma consecutiva. O jogador com a maior pontuação vence. A pontuação corresponde ao tamanho do maior grupo. Em caso de empate, cada jogador adiciona à sua pontuação o tamanho do seu segundo maior grupo. Caso o empate continue, volta-se a adicionar o tamanho do terceiro maior grupo e assim sucessivamente. Em tabuleiros ímpares, se estiver empatado mesmo depois da aplicação dos critérios de desempate, vence quem fez o último movimento.

## Lógica do jogo

### Representação interna do estado do jogo

Para representar as peças do jogo, optamos por atribuir o valor '1' às peças vermelhas, ou seja, do jogador 1, e o valor '2' às peças brancas, do jogador 2.

O tabuleiro é representado usando uma lista que contem várias listas, cada uma referente a uma linha do tabuleiro. Por sua vez, cada elemento de cada linha, ou seja, cada célula, é também uma lista, sendo o primeiro elemento o valor correspondente à peça do topo (valor 1 - peça vermelha no topo; valor 2 - peça branca no topo). Os restantes elementos, se houver mais do que uma peça na célula, ou seja, se o tamanho da stack for maior do que 1, estão ordenados desde o segundo, isto é, a partir do que está imediatamente abaixo da peça do topo até à base da stack.

No início do jogo, as listas correspondentes às células têm aridade 1 dado que apenas se encontra uma peça por célula. Daí em diante, mediante a jogabilidade, a aridade vai variando. 

A indicação do próximo jogador a efetuar uma jogada surge após a visualização gráfica do tabuleiro. Se o predicado *display_game/2* receber o valor 1 como segundo argumento, o próximo jogador a efetuar uma ação será o jogador 1. Se receber o valor 2, será o jogador 2.

Relativamente às peças extra, inicialmente posicionadas fora do tabuleiro, ainda que na prática tal não fosse possível, decidimos que seriam em número infinito. A razão para tal deve-se ao facto de que a regra de término do jogo não é a ausência de peças, mas sim a passagem em duas jogadas sucessivas. Ou seja, se tivéssemos definido que, por exemplo, cada jogador teria 30 peças da sua cor exteriores ao tabuleiro no início do jogo, como em cada jogada em que o jogador move uma das suas peças tem de colocar uma peça do adversário exterior ao tabuleiro, correríamos o risco de o jogo terminar por falta de peças exteriores, o que não consta nas regras. Desta forma, e para não sobrecarregar a visualização gŕafica do jogo, não colocamos nenhuma informação nos predicados de *display* sobre as peças exteriores uma vez que serão sempre em número infinito.

De seguida, representam-se três possíveis estados: inicial (sempre igual), intermédio e final.

- Inicial

```
/* initial board configuration */

/* LINHA 0 */
A = [[[2],
    [1],
	[2],
	[1]],
/* LINHA 1 */
	[[1],
	[2],
	[1],
	[2]],
/* LINHA 2 */
	[[2],
	[1],
	[2],
	[1]],
/* LINHA 3 */
	[[1],
	[2],
	[1],
	[2]]].
```

- Intermédio

```
/* intermediate board configuration */

/* LINHA 0 */
A = [[[1, 2],
    [2],
	[2],
	[1]],
/* LINHA 1 */
	[[1],
	[1],
	[2, 1],
	[2]],
/* LINHA 2 */
	[[1],
	[2, 1],
	[2],
	[1]],
/* LINHA 3 */
	[[1],
	[1, 2],
	[2],
	[2]]].
```

- Final

```
/* final board configuration */

/* LINHA 0 */
A = [[[1, 2],
    [1, 2],
	[2],
	[2, 1]],
/* LINHA 1 */
	[[1],
	[1],
	[2, 1],
	[2]],
/* LINHA 2 */
	[[1],
	[2, 1],
	[1, 2],
	[2]],
/* LINHA 3 */
	[[1],
	[1, 2],
	[2],
	[2]]].
```

### Visualização do estado do jogo

Para a implementação do predicado de visualização do estado de jogo, recorremos ao predicado *display_game/2*, que recebe o estado do jogo e o número do jogador a efetuar a próxima jogada. 

Este predicado invoca o predicado *printBoard/2* que, recebendo o tabuleiro a ser impresso (a ser alterado a cada jogada) e o tamanho do mesmo, imprimirá as células e as peças nas suas posições. Optou-se por apresentar apenas a peça do topo de cada *stack*, dado que as restantes não influenciam a jogada. Colocamos ainda um valor por célula correspondente ao tamanho da *stack*.

Após o *display* do tabuleiro, indicamos qual o próximo jogador. 

#### **Menus**

Após a invocação do predicado *play/0*, o utilizador deverá indicar o modo de jogo, seguido do nível de dificuldade (1-Normal ou 2-Difícil) se se tratar do modo *Player vs. Computer* ou *Computer vs. Computer*.

Segue-se a visualização da cor da peça de cada jogador, aparecendo depois o tabuleiro no seu estado inicial e iniciando-se assim a jogabilidade.

### Lista de Jogadas Válidas

As jogadas válidas exigem as seguintes condições:
- a peça do topo da stack da célula inicial escolhida é da cor do jogador atual
- a peça do topo da stack da célula final escolhida é da cor do adversário
- o tamanho de ambas as stacks é igual antes da realização do movimento
- as stacks são ortogonalmente adjacentes  

O predicado `validMoves(+Board, +Player, -ListOfMoves)` consiste na obtenção de uma lista com jogadas possíveis. Uma vez que há pontos no tabuleiro que não têm 4 stacks adjacentes, são analisados os casos especiais (os quatro cantos do tabuleiro - 2 stacks adjacentes ; as stacks pertencentes às linhas e colunas que o delimitam - 3 stacks adjacentes).

### Execução de Jogadas
move(Board, Next, NOption, Difficulty)
O predicado `repeatCycle(+Player, +Pass, +Board, +NOption, +Difficulty)` corresponde ao ciclo de jogadas, que depende do modo de jogo (*NOption*), da dificuldade (*Difficulty*, apenas para os modos 2 e 3), do jogador atual e da passagem ou não na jogada anterior.

Se o movimento for feito pelo jogador, utiliza-se o predicado `move(+Board, +Next, +NOption, +Difficulty)`, que consiste na validação, execução e obtenção de um novo estado de jogo. Começa por receber o input do jogador com `getInputPlay(Col, Lin)`, que diz respeito à posição da peça que pretende mover, e com `getFInputPlay(FCol, FLin)`, que considera a posição que esta peça irá ocupar. `validateColumn/2` e `validateLine/2` verificam se os inputs do utilizador correspondem de facto a uma coordenada existente. De seguida, averigua-se a exequibilidade da jogada, avaliando se satisfaz as condições anteriormente expostas. Por fim, se passar as verificações com sucesso, é atualizado o tabuleiro atual e é feita a chamada de `repeatCycle/5`. 

Se o movimento for feito pelo computador, o predicado é `computerMove(+Board, +Next, +NOption, +Move, +Difficulty)`, que recebe um movimento já processado por predicados de escolha (mencionados de seguida) e, portanto, efetua o movimento sem as verificações, que já foram feitas aquando da seleção do movimento.

### Final do Jogo
O jogo termina se, e só se, ambos os jogadores passarem em duas jogadas sucessivas. Quando estamos perante estas condições, o predicado `game_over(+FinalB, +LastPlayer)` identifica qual o vencedor do jogo, calculando o tamanho dos grupos de cada jogador. Estes valores são guardados em ficheiros de texto (*player1.txt* e *player2.txt*), sendo posteriormente analisados de forma a determinar qual o maior, dando a vitória ao jogador respetivo. Em caso de empate, verifica-se sucessivamente os tamanhos do segundo maior grupo, terceiro maior grupo, etc. Se mesmo assim perdurar o empate, vence o jogador que efetuou a última jogada, ou seja, o *LastPlayer*. 

### Avaliação do Tabuleiro
O predicado `value(+Visited, +Disc, _)` avalia o estado do jogo, analisando o tamanho dos grupos de cada jogador. Para esta análise, no predicado `board_flood/6`, foi utilizado o método *Flood Fill* (algoritmo usado em *arrays* multidimensionais de forma a determinar áreas interligadas entre si). Assim, a cada célula percorrida, esta é marcada como visitada e é verificado se existem peças da mesma cor nas posições adjacentes. O algoritmo termina quando não há mais células a visitar, colocando os tamanhos dos maiores grupos nos ficheiros *player1.txt* e *player2.txt*. Tal como mencionado num comentário no código, este predicado foi reaproveitado do trabalho de um ano anterior, sendo que o adaptamos para o nosso jogo.

### Jogada do Computador
Para a jogada do computador, em primeiro lugar, é gerada aleatoriamente a decisão de passar ou jogar, uma vez que o jogo só termina se ambos os jogadores passarem. Depois de avaliadas as jogadas válidas, há duas possibilidades:

- Se o nível de dificuldade for 1-Normal, é invocado o predicado `getPlay(+Board, +ListOfMoves, +Idx, +Difficulty, +NOption, +Player)`, no qual é escolhida a jogada na posição *Idx* (um valor random entre 1 e o [tamanho da lista de jogadas possíveis + 1]) das jogadas possíveis (*ListOfMoves*) e a mesma é efetuada através da chamada do predicado `computerMove/5`.

- Se o nível de dificuldade for 2-Hard, é invocado o predicado `choose_move(+Board, +Player, +ListOfMoves, +NOption)`, que percorre a lista de jogadas possíveis e escolhe aquela que maximiza o tamanho do maior grupo do computador, chamando finalmente o predicado `computerMove/5`.

## Conclusões

O trabalho foi realizado com sucesso, de acordo com o pedido no enunciado, e de forma igual por todos os membros do grupo. No que toca a *known issues*, detetamos apenas uma falha ao lidar com seleções erradas de opções do menu principal e do menu de dificuldade (o mesmo não acontece na escolha errada da coluna e linha no movimento, sendo que aí é pedido um novo input ao jogador). Quanto a melhorias identificadas, identificamos a otimização do tempo de escolha da melhor jogada do computador, no nível 2-Hard. 

## Bibliografia

- https://boardgamegeek.com/boardgame/314462/swack

- https://github.com/andrefmrocha/Fuse-GI

- https://stackoverflow.com/questions/4805601/read-a-file-line-by-line-in-prolog

- https://stackoverflow.com/questions/16174681/how-to-delete-the-last-element-from-a-list-in-prolog