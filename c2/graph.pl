%opis grafu
graph(dom,silownia,2).
graph(silownia,restauracja,3).
graph(dom,szkola,4).
graph(szkola,bar,4).
graph(szkola,sklep,1).
graph(szkola,biblioteka,5).
graph(szkola,stolowka,7).
graph(sklep,park,6).
graph(biblioteka,sala,6).
graph(stolowka,sala,8).
graph(park,restauracja,12).
graph(park,centrum,5).
graph(sala,centrum,10).
graph(centrum,most,8).
graph(centrum,wieza,6).
graph(most,wieza,13).
graph(wieza,muzeum,2).
graph(muzeum,zoo,6).
 
% graf nieskierowany
neighbor(X, Y, D) :- graph(X, Y, D).
neighbor(X, Y, D) :- graph(Y, X, D).
 
%lista wêz³ów zakazanych
avoid([most,biblioteka]).
go(Here,There) :- route(Here, There,[Here], 0).
 
%rekurencyjne poszukiwanie drogi
route(X,X,VisitedRooms,D) :-
member(szkola,VisitedRooms), wypisz(VisitedRooms), write(D), nl.
route(Room,Way_out,VisitedRooms,D) :-
neighbor(Room,NextRoom, Dn),
avoid(DangerousRooms),
\+ member(NextRoom,DangerousRooms),
\+ member(NextRoom,VisitedRooms),
M is D + Dn,
route(NextRoom,Way_out,[NextRoom|VisitedRooms],M).
 
%sprawdzenie, czy element wystêpuje w liœcie
member(X,[X|_]).
member(X,[_|H]) :- member(X,H).
 
% wypisywanie w kolejnosci przechodzenia
wypisz([]).
wypisz([H|T]) :- wypisz(T), write(H), nl.