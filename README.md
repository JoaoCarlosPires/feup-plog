# feup-plog
 
This programs were created during the **1st semester** of the **3rd year** of **Integrated Master in Informatics and Computing Engineering**, in **Logic Programming** curricular unity (FEUP).

[PLOG FEUP-Sigarra](https://sigarra.up.pt/feup/en/UCURR_GERAL.FICHA_UC_VIEW?pv_ocorrencia_id=272714 "Curricular Unity Homepage")

## Contributors

All the work developed during this curricular unit was made side-by-side with [Marta Santos](https://github.com/martandradelobo "Github Profile").

## Practical Classes

- TP1

To open the prolog file with the clauses, we must use the following line of code, right after opening the *sicstus* software

```pearl
consult('name_of_file.pl').
```
Then, just ask the interpreter the questions in each file.

Example:

For the first question, a), to know the parents of Michael Scofield, we just have to type

```pearl
parent(X, 'MichaelScofield'), parent(Y, 'MichaelScofield'), X\=Y.
```
The interpreter will ask if the X and Y values are those ones and all we have to do is type 'yes' and that's it.

- Notes

  * The symbol '\\=' represents the logical different (≠).
  * If the file that we want to consult isn't in the same folder as the one where the program is, then all we have to do is to use the relative path. Example: ~/Documents/PLOG/TP1/name_of_file.pl (instead of just name_of_file.pl) 
