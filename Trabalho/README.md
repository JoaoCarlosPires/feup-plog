# Programação em Lógica - Trabalho Prático

## Informações do grupo

- Identificação do trabalho: Swack_2
- Elementos do Grupo:
    - João Carlos Machado Rocha Pires (up201806079)
    - Maria Marta Nunes Andrade Lobo dos Santos (up201604530)
- Turma Prática 5

## Descrição do jogo

Swack é um jogo de tabuleiro para dois jogadores: Preto e Branco. O tabuleiro é um quadrado de qualquer tamanho, com células também quadradas.

No início do jogo, todas as células do jogo estão preenchidas com peças pretas e brancas de forma alternada, em xadrez. Em tabuleiros com número de células ímpares, a célula central é preenchida com uma peça branca. Adicionalmente, cada jogador deverá ter à sua disposição um número de peças suficientes da sua cor que estarão fora do tabuleiro.

Células adjacentes significam células ortogonalmente adjacentes.

Uma stack é um conjunto de uma ou mais peças empilhadas dentro da mesma célula. A cor da stack é a cor da peça que se encontra no topo, o que determina o seu “dono”. O tamanho da stack é o número de peças que nela estão contidas.

Um grupo é um conjunto de stacks adjacentes tais que a cor das mesmas é igual. O tamanho de um grupo corresponde ao número de stacks que o formam.

O jogador com as peças pretas começa o jogo e, daí em diante, as jogadas são feitas de forma alternada. 

Em cada jogada, poderão ser realizadas as seguintes ações:

- Passar

- Mover a peça da cor do jogador do topo de uma stack para uma stack adjacente cuja cor seja a do adversário, considerando que o tamanho de ambas as stacks é igual antes da realização do movimento. Depois, colocar uma peça da cor do adversário, exterior ao tabuleiro, no topo da stack de onde a peça do atual jogador foi retirada.

O jogo termina assim que os jogadores decidem passar a sua jogada de forma consecutiva. O jogador com a maior pontuação no final do jogo vence. A pontuação de um jogador corresponde ao tamanho do maior grupo. Se houver um empate, cada jogador adiciona à sua pontuação o tamanho do seu segundo maior grupo. Se o empate continuar, volta-se a adicionar o tamanho do terceiro maior grupo e assim sucessivamente. Nos tabuleiros ímpares, se estiver empatado mesmo depois da aplicação dos critérios de desempate, vence quem fez o último movimento.

**Ligações usadas:** https://boardgamegeek.com/boardgame/314462/swack

## Representação interna do estado do jogo

Indicação de como representam o estado do jogo, incluindo tabuleiro (tipicamente usando uma lista de listas com diferentes átomos para as peças), jogador atual, e eventualmente peças capturadas ou ainda por jogar, ou outras informações que possam ser necessárias (dependendo do jogo). Deve incluir exemplos da representação, em Prolog, de estados de jogo inicial, intermédio e final (que deverão estar também no ficheiro de código - ver abaixo), e indicação do significado de cada átomo (ex., como representam as diferentes peças).

## Visualização do estado do jogo

Pequena descrição da implementação do predicado de visualização do estado de jogo (max. 200 palavras)