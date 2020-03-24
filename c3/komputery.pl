:-dynamic komputer/5.

wykPrg:-
 write('1 - biezacy stan bazy danych'), nl,
 write('2 - dopisanie nowego komputera'), nl,
 write('3 - usuniecie komputera'), nl,
 write('4 - obliczenie sredniej ceny komputerow w bazie'), nl,
 write('5 - uzupelnienie bazy o dane zapisane w pliku'), nl,
 write('6 - zapisanie bazy w pliku'), nl,
 write('7 - wypisanie danych i liczby komputerow o podanej nazwie procesora'), nl,
 write('8 - wypisanie danych i liczby komputerow o cenie mniejszej niz podana'), nl,
 write('0 - koniec programu'), nl, nl,
 read(I),
 I > 0,
 opcja(I),
 wykPrg.
wykPrg.

opcja(1) :- wyswietl.

opcja(2) :- write('Podaj nazwe:'), read(Nazwa),
 write('Podaj typ:'), read(Typ),
 write('Podaj czestotliwosc zegara:'), read(Czestotliwosc),
 write('Podaj rozmiar HDD:'), read(Rozmiar),
 write('Podaj cene:'), read(Cena), nl,
 assert(komputer(Nazwa, Typ, Czestotliwosc, Rozmiar, Cena)).

opcja(3) :- write('Podaj nazwe usuwanego procesora:'), read(Nazwa),
write('Podaj typ usuwanego procesora:'), read(Typ),
 retract(komputer(Nazwa,Typ,_,_,_)),! ;
 write('Brak takiego komputera').

opcja(4) :- sredniaCena.

opcja(5) :- write('Podaj nazwe pliku:'), read(Nazwa),
 exists_file(Nazwa), !, consult(Nazwa);
 write('Brak pliku o podanej nazwie'), nl.

opcja(6) :- write('Podaj nazwe pliku:'), read(Nazwa),
 open(Nazwa, write, X), zapis(X), close(X).

opcja(7) :- write('Podaj nazwe procesora:'), read(Nazwa),
 daneProcesor(Nazwa).

opcja(8) :- write('Podaj cene:'), read(Cena),
 daneCena(Cena).

opcja(_) :- write('Zly numer opcji'), nl.

wyswietl :- write('elementy bazy:'), nl,
 komputer(Nazwa, Typ, Czestotliwosc, Rozmiar, Cena),
 write(Nazwa), write(' '), write(Typ), write(' '), write(Czestotliwosc), write(' '), write(Rozmiar), write(' '), write(Cena), nl, fail.
wyswietl :- nl.

sredniaCena :- findall(Cena, komputer(_,_,_,_,Cena), Lista),
 suma(Lista, Suma, LiczbaKomputerow),
 SredniaCena is Suma / LiczbaKomputerow,
 write('Srednia cena komputerow w bazie:'), write(SredniaCena), nl, nl.

daneCena(X):- findall(komputer(Nazwa,Typ,Czestotliwosc,Rozmiar,Cena), (komputer(Nazwa,Typ,Czestotliwosc,Rozmiar,Cena), Cena < X), Lista),
 write('elementy bazy:'), nl,
 write(Lista),
 dlugosc(Lista, LiczbaKomputerow), nl,
 write('Liczba komputerow:'), write(LiczbaKomputerow), nl, nl.

daneProcesor(X):- findall(komputer(Nazwa,Typ,Czestotliwosc,Rozmiar,Cena), (komputer(Nazwa,Typ,Czestotliwosc,Rozmiar,Cena), Nazwa = X), Lista),
 write('elementy bazy:'), nl,
 write(Lista),
 dlugosc(Lista, LiczbaKomputerow), nl,
 write('Liczba komputerow:'), write(LiczbaKomputerow), nl, nl.


zapis(X) :- komputer(Nazwa, Typ, Czestotliwosc, Rozmiar, Cena),
 write(X, 'komputer('),
 write(X, Nazwa), write(X, ','), write(X, Typ), write(X, ','), write(X, Czestotliwosc), write(X, ','), write(X, Rozmiar), write(X, ','), write(X, Cena),
 write(X, ').'), nl(X), fail.
zapis(_) :- nl.

suma([],0,0).
suma([G|Og], Suma, N) :- suma(Og, S1, N1),
 Suma is G + S1,
 N is N1+1.

dlugosc([],0).
dlugosc([_|Ogon],Dlug) :-
	dlugosc(Ogon,X),
	Dlug is X+1.

%komputer(intel, graficzny, 1000, 2000, 400).
%komputer(intel, mikroprocesor, 500, 256, 150). 
%komputer(radeon, dzwiekowy, 1500, 3000, 600).
%komputer(radeon, graficzny, 1200, 2000, 500).
%komputer(amd, fizyczny, 1700, 1500, 290).