/* MENU INPUT */

menuInput(Option, Min, Max) :-
	get_code(Z), skip_line,
	Z > 47+Min, Z < 49+Max,
	Option is Z.

menuInput(Option, Min, Max) :- menuInput(Option, Min, Max).