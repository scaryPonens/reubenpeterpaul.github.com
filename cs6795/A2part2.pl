human(X) :- philosopher(X).
human(X) :- featherless(X), biped(X).
philosopher(X) :- dualist(X).
dualist(john).
biped(mary).
featherless(joe).
