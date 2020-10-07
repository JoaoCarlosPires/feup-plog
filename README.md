# feup-plog

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
