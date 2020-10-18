/* INPUTS */

menuInput(Option, Min, Max) :-
	get_code(O), skip_line,
	O > 47+Min, O < 49+Max,
	Option is O.

menuInput(Option, Min, Max) :- menuInput(Option, Min, Max).


