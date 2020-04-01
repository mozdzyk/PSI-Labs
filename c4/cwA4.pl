:- dynamic xpositive/2.
:- dynamic xnegative/2.

%1. Opis obiektów (ich cech charakterystycznych)

 dish_is(hamburger) :-
 it_is(fastfood) ,
 positive(has,bun),
 positive(has,vegetables).

 dish_is(spaghetti) :-
 positive(has,pasta) ,
 positive(has,sauce) ,
 negative(has,sugar).

 dish_is(salad) :-
 it_is(healthy) ,
 negative(has,milk) ,
 positive(has,sauce).

 dish_is(cake) :-
 it_is(sweet) ,
 positive(has,chocolate),
 positive(has,flour),
 positive(has,eggs),
 negative(has,meat).

 dish_is(pizza) :-
 it_is(fastfood) ,
 positive(has,flour) ,
 positive(has,cheese) ,
 negative(has,chocolate).

 dish_is(pancake) :-
 it_is(sweet) ,
 negative(has,vegetables),
 positive(has,flour),
 positive(has,eggs),
 positive(has,milk).

 dish_is(tortilla) :-
 it_is(fastfood) ,
 negative(has,chocolate),
 positive(has,meat),
 positive(has,vegetables),
 positive(has,pancake).

 dish_is(soup) :-
 positive(has,vegetables),
 positive(has,water),
 positive(is,salty),
 negative(has,sugar).

 dish_is(salmon) :-
 it_is(animal),
 it_is(fish),
 negative(has,bun).

 dish_is(pork) :-
 it_is(animal),
 positive(has,meat),
 positive(has,sauce).

 dish_is(chicken_nuggets) :-
 positive(has,meat),
 positive(has,sauce),
 positive(has,chicken),
 negative(has,bones).

 dish_is(chips) :-
 it_is(fastfood),
 positive(have,potatoes).

%2. Opis cech charakterystycznych dla klas obiektów
 it_is(fastfood) :-
 positive(is,salty),
 positive(is,greasy),
 positive(has,sauce),
 negative(has,fruits).

 it_is(healthy) :-
 negative(is,salty),
 negative(has,fat),
 positive(has,vegetables).

 it_is(healthy) :-
 negative(has,sugar),
 positive(has,fruits).

 it_is(sweet) :-
 positive(has,sugar),
 negative(has,salt).
 
 it_is(animal) :-
 positive(was,living),
 positive(has,bones).

 it_is(fish) :-
 positive(has,fins),
 positive(has,gills).

%3. Szukanie potwierdzenia cechy obiektu w dynamicznej bazie
 positive(X,Y) :-xpositive(X,Y),!.
 positive(X,Y) :-
 not(xnegative(X,Y)) , ask(X,Y,yes).
 negative(X,Y) :-xnegative(X,Y),!.
 negative(X,Y) :-
 not(xpositive(X,Y)) , ask(X,Y,no).

%4. Zadawanie pytań użytkownikowi
ask(X,Y,yes) :-
 write(X), write(' it '),write(Y), write('\n'),
 read(Reply),
 sub_string(Reply,0,1,_,'y'),!,
 remember(X,Y,yes).

ask(X,Y,no) :-
 write(X), write(' it '),write(Y), write('\n'),
 read(Reply),
 sub_string(Reply,0,1,_,'n'),!,
 remember(X,Y,no).

ask(X,Y,no) :-
 remember(X,Y,no), fail.

 
%5. Zapamiętanie odpowiedzi w dynamicznej bazie
 remember(X,Y,yes) :-
 asserta(xpositive(X,Y)).
 remember(X,Y,no) :-
 asserta(xnegative(X,Y)).

%6. Uruchomienie programu
 run :-
 dish_is(X),!,
 write('\nYour dish may be a(n) '),write(X),
 nl,nl,clear_facts.
 run :-
 write('\nUnable to determine what'),
 write('your dish is.\n\n'),clear_facts.

%7. Wyczyszczenie zawartości dynamicznej bazy
 clear_facts :-
 retract(xpositive(_,_)),fail.
 clear_facts :-
 retract(xnegative(_,_)),fail.
 clear_facts :-
 write('\n\nPlease press the space bar to exit\n'). 
