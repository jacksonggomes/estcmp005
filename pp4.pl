%%  amigo(+Stimuli, -Response) � a entrada.
%   @parametro  Stimuli � uma lista de �tomos (palavras).
%
dialogo :-
    write('Bem vindo ao amigo virtual. Para come�ar digite: amigo([palavra1,palvra2...],Response).'),
    !.


/*Fun��o que recebe a entrada do usu�rio*/
amigo(Stimuli, Response) :-
    template(InternalStimuli, InternalResponse),
    match(InternalStimuli, Stimuli),
    match(InternalResponse, Response),
    !.

/*Padr�es de entrada com suas respectivas respostas*/
template([s([boa,noite]),s(X)], [s([boa,noite, bem, vindo, como, se, chama]),s(X),w('?')]).
template([s([meu,nome, �]),s(X)], [s([boa,noite, bem, vindo]),s(X),w('?')]).
template([s([eu,estou]),s(X)], [s([por_que,voc�,est�]),s(X),w('?')]).
template([s([eu,sou]),s(X)], [s([por_que,voc�,�]),s(X),w('?')]).
template([s([eu,preciso]),s(X)], [s([por_que,voc�,precisa]),s(X),w('?')]).
template([s([eu,quero]),s(X)], [s([por_que, voc�, gostaria]),s(X),w('?')]).
template([s([qual,sua]),s(X)], [s([eu,n�o,sei]),s(X),w('?')]).
template([w(eu),s(X),w(voc�)], [s([por_que,fazer,voc�]),s(X),w(eu),w('?')]).

/*Procura os padr�es no template, retornando a devida sa�da.*/
match([],[]).
match([Item|Items],[Word|Words]) :-
    match(Item, Items, Word, Words).

match(w(Word), Items, Word, Words) :-
    match(Items, Words).
match(s([Word|Seg]), Items, Word, Words0) :-
    append(Seg, Words1, Words0),
    match(Items, Words1).


/** <exemplos>

?- amigo([boa, noite, amigo], Response).

?- amigo([eu, preciso, de, ajuda], Response).

?- amigo([eu, preciso, me, formar], Response).
*/
