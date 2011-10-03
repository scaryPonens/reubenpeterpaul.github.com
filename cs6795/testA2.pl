street(numbern(12), appellation('Main St')).
municipality(appellation('Fredericton'),province('NB')).
first('Peter').
mid('C.').
lastn('Jones').
numbern(37).
province('NB').

name(X,Y,Z) :- first(X), mid(Y), lastn(Z).
driver(W,X,Y,Z) :- numbern(W), name(X,Y,Z).
destination(W,X,Y,Z) :- street(W,X), municipality(Y,Z).
