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

%Questao 2
curso(1, informatica).
curso(2, eletro_eletronica).

materia(1, tecnicas_de_programacao, 8).
materia(2, programacao_orientada_a_objetos, 5).
materia(3, estruturas_de_dados, 4).
materia(4, topicos_em_metodologias_de_programacao, 3).
materia(5, circuitos_eletricos, 4).
materia(6, eletronica_digital, 5).
materia(7, arquitetura_computadores, 6).
materia(8, microcontroladores, 4).


aluno(12808, jose).
aluno(12080, marcos).
aluno(12909, joao).
aluno(12090, ana).

codMat([], []).
codMat([item(CM,_,_,_,_)|R], [CM|COD]) :-
    codMat(R, COD).

matFaltantes([], _, []).
matFaltantes([CM|R], C, [NM|RF]) :-
    \+ member(CM, C),
    materia(CM, NM, _),
    !,
    matFaltantes(R, C, RF).
matFaltantes([CM|R], C, RF) :-
    member(CM, C),
    matFaltantes(R, C, RF).

falta(RA, CC, LM) :-
    curriculo(CC, MC),       
    historico(RA, HIST),     
    codMat(HIST, C), 
    matFaltantes(MC, C, LM). 

%Questao 3
extraCod([], _, []).
extraCod([CM|RE], CUR, [CM,|RE]) :-
    \+ member(CM, CUR),
    !,
    extraCod(R, CUR, RE).

extraCod([CM|R], CUR, RE) :-
    member(CM, CUR),
    extraCod(R, CUR, RE).

nomeMaterias([], []).
nomeMaterias([CM|R], [NM|RN]) :-
    materia(CM, NM, _),
    nomeMaterias(R, RN).


extra(RA, CC, QUAIS) :-
    historico(RA, HIST),
    codMat(HIST, COD),
    curriculo(CC, CURSO),
    extraCod(COD, CURSO, EXTRAS),
    nomeMaterias(EXTRAS, QUAIS).



%COD = Codigos
%R = Resto
%RF = Resto faltam
%C = Cursadas
%LM = Lista Materias
%MC = Materia Curriculo
%HIST = Historico
%CUR = Curriculo
%RN = Resto nome
%NM = Nome Materia

