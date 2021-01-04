/* MENU INPUT */

menuInput(Option, Min, Max) :-
	get_code(Y), skip_line,
	Y > 47+Min, Y < 49+Max,
	Option is Y.

menuInput(Option, Min, Max) :- menuInput(Option, Min, Max).