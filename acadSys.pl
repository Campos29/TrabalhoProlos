%Questão 1.
historico(12808,[item(1,1,2012,3.0,0.77),item(1,2,2013,6.5,0.90),item(5,1,2014,8.0,0.80)]).
historico(12909,[item(1,1,2012,7.0,0.80),item(2,2,2013,8.5,0.80),item(3,1,2014,5.0,0.75)]).
historico(12080,[item(5,1,2012,6.0,0.70),item(5,2,2013,7.5,0.90),item(6,1,2014,5.0,0.90)]).
historico(12090,[item(7,1,2012,6.0,0.75),item(8,2,2014,8.0,0.89)]).
historico(11011,[item(1,1,2012,5.0,0.75),item(2,2,2014,9.0,0.50)]).

cursa(12909,1).
cursa(12080,2).
cursa(12090,2).

curriculo(1,[1,2,3,4]).
curriculo(2,[5,6,7,8]).


verificarNota(N):- N >= 5.00.
verificarPresenca(P):- P >= 0.75.
aprovadoMat(RA, CM):-
	historico(RA, L),
	member(item(CM,_,_,NOT,PRES), L),
	verificarNota(NOT),
	verificarPresenca(PRES).

aprovadoTodas(_, []).
aprovadoTodas(RA, [CM|R]):-
	aprovadoMat(RA,CM),
	aprovadoTodas(RA, R).


concluiuCurso(RA,CC):- 
	cursa(RA,CC),
	curriculo(CC, MATS),
	aprovadoTodas(RA, MATS).


	
			

