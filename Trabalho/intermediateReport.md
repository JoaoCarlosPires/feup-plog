# Programação em Lógica - Trabalho Prático

## Informações do grupo

- Identificação do trabalho: Swack_2
- Elementos do Grupo:
    - João Carlos Machado Rocha Pires (up201806079)
    - Maria Marta Nunes Andrade Lobo dos Santos (up201604530)
- Turma Prática 5

## Descrição do jogo

Swack é um jogo de tabuleiro para dois jogadores (Vermelho/Branco). O tabuleiro é um quadrado 4x4, com células quadradas.

No início, todas as células estão preenchidas com peças vermelhas/brancas de forma alternada, em xadrez. Em tabuleiros com número de células ímpares, a célula central é preenchida com uma peça branca. Cada jogador tem um número de peças infinitas da sua cor fora do tabuleiro.

Células adjacentes significam células ortogonalmente adjacentes.

Uma stack é um conjunto de uma ou mais peças empilhadas dentro da mesma célula. A cor da stack é a cor da peça do topo, que determina o seu “dono”. O tamanho da stack é o número de peças nela contidas.

Um grupo é um conjunto de stacks adjacentes de cor igual. O tamanho de um grupo corresponde ao número de stacks que o formam.

O jogador com as peças vermelhas começa e as jogadas são feitas de forma alternada. 

Em cada jogada, o jogador poderá:

- Passar

- Mover uma peça da sua cor do topo de uma stack para uma stack adjacente cuja cor seja a do adversário, considerando que o tamanho de ambas as stacks é igual antes da realização do movimento. Depois, colocar uma peça da cor do adversário, exterior ao tabuleiro, no topo da stack de onde a peça do atual jogador foi retirada.

O jogo termina quando os jogadores decidem passar de forma consecutiva. O jogador com a maior pontuação vence. A pontuação corresponde ao tamanho do maior grupo. Em caso de empate, cada jogador adiciona à sua pontuação o tamanho do seu segundo maior grupo. Caso o empate continue, volta-se a adicionar o tamanho do terceiro maior grupo e assim sucessivamente. Em tabuleiros ímpares, se estiver empatado mesmo depois da aplicação dos critérios de desempate, vence quem fez o último movimento.

**Ligações usadas:** https://boardgamegeek.com/boardgame/314462/swack

## Representação interna do estado do jogo

Para representar as peças do jogo, optamos por atribuir o valor '1' às peças vermelhas, ou seja, do jogador 1, e o valor '2' às peças brancas, do jogador 2.

O tabuleiro é representado usando uma lista que contem várias listas, cada uma referente a uma linha do tabuleiro. Por sua vez, cada elemento de cada linha, ou seja, cada célula, é também uma lista, sendo o primeiro elemento o valor correspondente à peça do topo (valor 1 - peça vermelha no topo; valor 2 - peça branca no topo). Os restantes elementos, se houver mais do que uma peça na célula, ou seja, se o tamanho da stack for maior do que 1, estão ordenados desde o segundo, isto é, a partir do que está imediatamente abaixo da peça do topo até à base da stack.

No início do jogo, as listas correspondentes às células têm aridade 1 dado que apenas se encontra uma peça por célula. Daí em diante, mediante a jogabilidade, a aridade vai variando. 

A indicação do próximo jogador a efetuar uma jogada surge após a visualização gráfica do tabuleiro. Se o predicado *display_game/2* receber o valor 1 como segundo argumento, o próximo jogador a efetuar uma ação será o jogador 1. Se receber o valor 2, será o jogador 2.

Relativamente às peças extra, inicialmente posicionadas fora do tabuleiro, ainda que na prática tal não fosse possível, decidimos que seriam em número infinito. A razão para tal deve-se ao facto de que a regra de término do jogo não é a ausência de peças, mas sim a passagem em duas jogadas sucessivas. Ou seja, se tivéssemos definido que, por exemplo, cada jogador teria 30 peças da sua cor exteriores ao tabuleiro no início do jogo, como em cada jogada em que o jogador move uma das suas peças tem de colocar uma peça do adversário exterior ao tabuleiro, correríamos o risco de o jogo terminar por falta de peças exteriores, o que não consta nas regras. Desta forma, e para não sobrecarregar a visualização gŕafica do jogo, não colocamos nenhuma informação nos predicados de *display* sobre as peças exteriores uma vez que serão sempre em número infinito. 

De seguida, mostram-se, respetivamente, as representações em PROLOG de três estados do jogo: inicial, intermédio e final.

- Inicial

```
/* initial board configuration */

		/* LINHA 0 */
first(A) :- A = [[[2],
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
intermediate(A) :- A = [[[1, 1, 2],
			[1, 1, 2, 1],
			[2, 2],
			[1, 2, 1, 1]],
			/* LINHA 1 */
			[[1, 2, 1, 2],
			[1, 1, 2, 1],
			[1, 2, 1, 1, 2],
			[2, 1, 2, 1, 1, 1]],
			/* LINHA 2 */
			[[2],
			[1, 1],
			[2, 2, 2, 2],
			[2, 2, 2]],
			/* LINHA 3 */
			[[1, 2, 2, 2, 2],
			[2, 1, 1, 1, 1],
			[1, 2, 2, 2, 1],
			[1, 1, 1, 2]]].
```

- Final

```
/* final board configuration */

		/* LINHA 0 */
final(A) :- A = [[[1, 1, 2, 1],
		[1, 1, 2, 1],
		[1, 2],
		[1, 2, 1, 1]],
		/* LINHA 1 */
		[[1, 2],
		[2, 1, 1],
		[2, 2],
		[2, 1, 2, 1]],
		/* LINHA 2 */
		[[1, 2, 2, 1, 2],
		[2, 1, 1, 1],
		[2, 2, 2, 2],
		[1, 2, 2]],
		/* LINHA 3 */
		[[1, 2],
		[1, 1, 1, 1],
		[1, 2],
		[2, 1, 1, 2]]].
```

## Visualização do estado do jogo

Para a implementação do predicado de visualização do estado de jogo, recorremos ao predicado *display_game/2*, que recebe o estado do jogo e o número do jogador a efetuar a próxima jogada. 

Este predicado, que, para esta entrega, faz *display* de três tabuleiros pré-definidos, invoca o predicado *printBoard/2* que, recebendo o tabuleiro a ser impresso (na versão final será apenas um tabuleiro com alterações a cada jogada) e o tamanho do mesmo, imprimirá as células e as peças nas suas posições. Optou-se por apresentar apenas a peça do topo de cada *stack*, dado que as restantes não influenciam a jogada. Colocamos ainda um valor por célula correspondente ao tamanho da *stack*.

Após o *display* do tabuleiro, indicamos qual o próximo jogador. 

Exemplos de 3 estados do jogo (o estado inicial será sempre assim):

- Estado Inicial

```
display_game(first, 1).
```

![Estado Inicial do Jogo](pictures/first.png)

- Estado Intermédio

```
display_game(intermediate, 2).
```

![Estado Intermédio do Jogo](pictures/intermediate.png)

- Estado Final

```
display_game(final, 1).
```

![Estado Final do Jogo](pictures/final.png)

Após a invocação do predicado *play/0*, o utilizador deverá indicar o modo de jogo.

O resultado visual após a seleção de uma opção é:

- Player vs Player (Opção 1)

![Player vs Player](pictures/playerplayer.png)

- Player vs Computer (Opção 2)

![Player vs Computer](pictures/playercomputer.png)

- Computer vs Computer (Opção 3)

![Computer vs Computer](pictures/computercomputer.png)

Após a indicação da cor da peça de cada jogador, para esta entrega, aparecem então os 3 tabuleiros/estados de jogo. 

Na entrega final, após a escolha do modo de jogo, aparecerá apenas o tabuleiro no seu estado inicial.