/* START CELL */
getInputPlay(Col, Lin) :-
	getColumn(Col),
	getLine(Lin).

getLine(Lin) :-
	write('Please specify line '),
	get_code(Li),
	skip_line,
	validateLine(Li, Lin).

getColumn(Col) :- 
	write('Please specify column '), 
	get_code(Co),
	skip_line,
	validateColumn(Co, Col).

validateColumn(65, Col) :- Col is 0.
validateColumn(66, Col) :- Col is 1.
validateColumn(67, Col) :- Col is 2.
validateColumn(68, Col) :- Col is 3.
validateColumn(_, Col) :- write('Invalid column letter\n\n'), getColumn(Col).

validateLine(48, Lin) :- Lin is 0.
validateLine(49, Lin) :- Lin is 1.
validateLine(50, Lin) :- Lin is 2.
validateLine(51, Lin) :- Lin is 3.
validateLine(_, Lin) :- write('Invalid line number\n\n'), getLine(Lin).

/* END CELL */
getFInputPlay(FCol, FLin) :-
	getFColumn(FCol),
	getFLine(FLin).

getFLine(FLin) :-
	write('Please specify line '),
	get_code(FLi),
	skip_line,
	validateLine(FLi, FLin).

getFColumn(FCol) :- 
	write('Please specify column '), 
	get_code(FCo),
	skip_line,
	validateColumn(FCo, FCol).

validateColumn(65, FCol) :- FCol is 0.
validateColumn(66, FCol) :- FCol is 1.
validateColumn(67, FCol) :- FCol is 2.
validateColumn(68, FCol) :- FCol is 3.
validateColumn(_, FCol) :- write('Invalid column letter\n\n'), getFColumn(FCol).

validateLine(48, FLin) :- FLin is 0.
validateLine(49, FLin) :- FLin is 1.
validateLine(50, FLin) :- FLin is 2.
validateLine(51, FLin) :- FLin is 3.
validateLine(_, FLin) :- write('Invalid line number\n\n'), getFLine(FLin).