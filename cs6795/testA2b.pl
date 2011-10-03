name('Main St').
name('Fredericton').
first('Peter').
mid('C.').
lastn('Jones').
numbern(37).
province('NB').

name(X,Y,Z) :- first(X), mid(Y), lastn(Z).
driver(W,X,Y,Z) :- numbern(W), name(X,Y,Z).
municipality(X,Y) :- name(X), province(Y).
street(X,Y) :- number(X), name(Y).
