% wyznaczanie silni
silnia(0,1). 
silnia(N,Nsil) :-  
N > 0,  
M is N - 1,  
silnia(M,Msil), 
Nsil is N * Msil.

% wyznaczanie ciągu Fibonacciego
fib(0,0).
fib(1,1).
fib(N,Nfib) :-
N > 1,
M is N - 1,
O is N - 2,
fib(M,Mfib),
fib(O,Ofib),
Nfib is Mfib + Ofib. 

% Opis działania bramek
brAnd(0,0,0).
brAnd(1,0,0).
brAnd(0,1,0).
brAnd(1,1,1).
brOr(0,0,0).
brOr(0,1,1).
brOr(1,0,1).
brOr(1,1,1).
brXor(0,0,0).
brXor(0,1,1).
brXor(1,0,1).
brXor(1,1,0).

% Opis układu
uklad(A,B,C,D,E,F,G,H,I,J,K) :-
brAnd(A,B,E),
brOr(C,D,F),
brAnd(E,F,I),
brAnd(G,H,J),
brXor(I,J,K).
