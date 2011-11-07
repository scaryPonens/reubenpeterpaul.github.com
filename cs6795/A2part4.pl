goldmemgold(X,[gold,X,gold|R]).
goldmemgold(X,[Y|R]) :- goldmemgold(X,R).
