%%  amigo(+Stimuli, -Response) é a entrada.
%   @parametro  Stimuli é uma lista de átomos (palavras).
%
dialogo :-
    write('Bem vindo ao amigo virtual. Para começar digite: amigo([palavra1,palvra2...],Response).'),
    !.


/*Função que recebe a entrada do usuário*/
amigo(Stimuli, Response) :-
    template(InternalStimuli, InternalResponse),
    match(InternalStimuli, Stimuli),
    match(InternalResponse, Response),
    !.

/*Padrões de entrada com suas respectivas respostas*/
template([s([boa,noite]),s(X)], [s([boa,noite, bem, vindo, como, se, chama]),s(X),w('?')]).
template([s([meu,nome, é]),s(X)], [s([boa,noite, bem, vindo]),s(X),w('?')]).
template([s([eu,estou]),s(X)], [s([por_que,você,está]),s(X),w('?')]).
template([s([eu,sou]),s(X)], [s([por_que,você,é]),s(X),w('?')]).
template([s([eu,preciso]),s(X)], [s([por_que,você,precisa]),s(X),w('?')]).
template([s([eu,quero]),s(X)], [s([por_que, você, gostaria]),s(X),w('?')]).
template([s([qual,sua]),s(X)], [s([eu,não,sei]),s(X),w('?')]).
template([w(eu),s(X),w(você)], [s([por_que,fazer,você]),s(X),w(eu),w('?')]).

/*Procura os padrões no template, retornando a devida saída.*/
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
