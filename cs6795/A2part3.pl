
ride(X,Y) :- train(X,Y).
ride(X,Y) :- bus(X,Y).
ride(X,Z) :- 
	train(X,Y),
	ride(Y,Z).
ride(X,Z) :-
	bus(X,Y),
	ride(Y,Z).

bus(home,kings_place).
bus(kings_place,work).
bus(kings_place,train_station).
train(train_station,bathurst).

