carnumber(37).
firstname('Peter').
middlename('C.').
lastname('Jones').
date('9/27'). 
streetnumber(12).
streetname('Main St').
municipalityname('Fredericton').
provincename('NB').
fare(12.50).

taxiride(W,X,Y,Z,D,E,F,G,H,I) :- 
	driver(W,X,Y,Z), 
	passengers, 
	transportinformation(D,E,F,G,H,I).

driver(W,X,Y,Z) :- carnumber(W), fullname(X,Y,Z).

fullname(X,Y,Z) :- firstname(X), middlename(Y), lastname(Z).

transportinformation(D,E,F,G,H,I) :- date(D), destination(E,F,G,H), fare(I).

destination(E,F,G,H) :- street(E,F), municipality(G,H).

street(X,Y) :- streetnumber(X), streetname(Y).

municipality(X,Y) :- municipalityname(X), provincename(Y).
