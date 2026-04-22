%Questão 1.
historico(12808,[item(1,1,2012,3.0,0.77),item(1,2,2013,6.5,0.90),item(5,1,2014,8.0,0.80)]).
historico(12909,[item(1,1,2012,7.0,0.80),item(2,2,2013,8.5,0.80),item(3,1,2014,5.0,0.75)]).
historico(12080,[item(5,1,2012,6.0,0.70),item(5,2,2013,7.5,0.90),item(6,1,2014,5.0,0.90)]).
historico(12090,[item(7,1,2012,6.0,0.75),item(8,2,2014,8.0,0.89)]).
%Aqui precisa de mudança, li errado o enunciado, aqui ele deve checar se o aluno foi aprovado em um curso inteiro e não só uma matéria 
verificarNota(N):- N >= 5.00.
verificarPresenca(P):- P >= 0.75.
concluiu(RA, CM):-
	historico(RA, L),
	member(item(CM,_,_,NOT,PRES), L),
	verificarNota(NOT),
	verificarPresenca(PRES).
	
			

