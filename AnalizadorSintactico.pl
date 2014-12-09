/*
Os vellos non deben de namorarse
	Autor: Alfonso Daniel Rodríguez Castelao.
	Editorial: Galaxia.
	Paxina: 43.
	Escea VI.

#cursiva 
No fondo mostrase unha parede branca. O boticario atópase morto. Entra o medicante que representa a morte.

A MORTE:
	#cursiva
	Saca a careta de medicante.

	Xa estou aiqui. Cheguei tarde porque sabía que non me 		necesitabas.



*/
% Definicion do operador de diferencia de listas

:- op(600,xfy,[\]).

% Clausula de interfaz para pasar de listas a diferencias de listas

frase(Frase,Arbol) :- frase_dl(Frase\[],Arbol),!.

% Estructura da frase


frase_dl(P0\X, f(SV, SN)) :- sv(SV, Num, P0\P1),
			     sn(SN, Num, P1\X). 

frase_dl(P0\X, f(SN, SV)) :- sn(SN, Num, P0\P1),
			     sv(SV, Num, P1\X).



% Estructura de un sintagma nominal

sn(sn(nil), _, P0\P0).

sn(sn(Det,Nucleo,CN), Num,P0\X) :- det(Det, Num, Gen, P0\P1),
                           	     n(Nucleo, Num, Gen, P1\P2),
				     complemento_nominal(CN,P2\X).

sn(sn(Det,Nucleo,Adj), Num, P0\X):- det(Det,Num,Gen,P0\P1),
                           	    n(Nucleo,Num,Gen,P1\P2),
				    adj(Adj,Num,Gen,P2\X).
sn(sn(Det,Nucleo),Num, P0\X):- det(Det,Num,Gen,P0\P1),
			       n(Nucleo,Num,Gen,P1\X).

sn(sn(Nucleo),Num, P0\X):- n(Nucleo,Num,Gen,P0\X).




% Estructura de un sintagma verbal

sv(sv(nil), _, P0\P0).



sv(sv(V), Num, P0\X) :- v(V, Num, P0\X).

sv(sv(V, SN), Num, P0\X) :- v(V, Num, P0\P1),
			    sn(SN, _, P1\X).

sv(sv(CCL, V), Num, P0\X) :- ccl(CCL, P0\P1),
			     v(V, Num, P1\X).

sv(sv(CCT, V, CCL),Num,P0\X) :- cct(CCT, P0\P1),
				v(V, Num, P1\P2),
				ccl(CCL, P2\X).

sv(sv(V, CCT, CCCausa),Num,P0\X) :- v(V, Num, P0\P1),
				    cct(CCT,P1\P2),
				    cccausa(CCCausa,P2\X).

sv(sv(V,PSub),Num,P0\X) :- v(V,Num,P0\P1),
			   prop_sub(PSub, _,P1\X).

sv(sv(CCN,CI,V),Num,P0\X) :- ccn(CCN,P0\P1),
			     ci(CI,Num,P1\P2),
			     v(V,Num,P2\X).


% Estructura de unha proposicion subordinada

prop_sub(prop_sub(Nexo,SV),Num,P0\X):- conector(Nexo,P0\P1),
			    	       sv(SV,Num,P1\X).



% Estructura complemento nominal

complemento_nominal(cn(Prep,SN),P0\X) :- prep(Prep,P0\P1),
					 sn(SN, Num, P1\X).

complemento_nominal(cn(Nexo,SV),P0\X) :-  conector(Nexo,P0\P1),
					  sv(SV, _,P1\X).

% Complemento indirecto

ci(ci(Pronome), Num, P0\X) :- pronome(Pronome,Num,P0\X). 

% Complemento circunstancial de negacion

ccn(ccn(Adv), P0\X) :- advnegacion(Adv,P0\X).

% Complemento circunstancial de lugar

ccl(ccl(Prep,SN),P0\X) :- prep(Prep,P0\P1),
			  sn(SN, _,P1\X).

ccl(ccl(Adv),P0\X) :- advlugar(Adv,P0\X).

% Complemento circunstancial de tempo

cct(cct(Adv),P0\X) :- advtempo(Adv,P0\X).

% Complemento circunstancial de causa

cccausa( cccausa(Nexo,SV),P0\X) :- conector(Nexo,P0\P1),
				   sv(SV, _,P1\X).

% Diccionario del texto.
/*
No fondo mostrase unha parede branca. O boticario atópase morto. Entra o medicante que representa a morte.

A MORTE:
	#cursiva
	Saca a careta de medicante.

	Xa estou aiqui. Cheguei tarde porque sabía que non me 		necesitabas.
*/
det(det(a),sing,fem,[a|X]\X).
det(det(o),sing,masc,[o|X]\X).
det(det(unha),sing, fem,[unha|X]\X).

n(n(boticario), sing, masc, [boticario|X]\X).
n(n(medicante),sing,masc,[medicante|X]\X).
n(n(morte),sing,fem,[morte|X]\X).
n(n(morto),sing,masc,[morto|X]\X).
n(n(parede),sing,fem,[parede|X]\X).
n(n(fondo),sing,masc,[fondo|X]\X).
n(n(careta),sing,fem,[careta|X]\X).

adj(adj(branca),sing,fem,[branca|X]\X).

advtempo(adv(xa),[xa|X]\X).
advtempo(adv(tarde),[tarde|X]\X).

advlugar(adv(aiqui),[aiqui|X]\X).

advnegacion(adv(non),[non|X]\X).

ci(me,sing,[me|X]\X).

v(v(entra),sing,[entra|X]\X).
v(v(representa),sing,[representa|X]\X).
v(v(mostrase),sing,[mostrase|X]\X).
v(v(atopase),sing,[atopase|X]\X).
v(v(saca),sing,[saca|X]\X).
v(v(estou),sing,[estou|X]\X).
v(v(cheguei),sing,[cheguei|X]\X).
v(v(sabia),sing,[sabia|X]\X).
v(v(necesitabas),sing,[necesitabas|X]\X).


conector(que,[que|X]\X).
conector(porque,[porque|X]\X).

prep(en+det(o),[no|X]\X).
prep(de, [de|X]\X).

pronome(me, sing, [me|X]\X).








  












