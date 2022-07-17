/*
1. Programa recursivo para retornar soma de 0 a n
*/
soma(0,0).
soma(N,S) :- 
    N > 0,
    N1 is N - 1,
    soma(N1,S1),
    S is N + S1.

/*
2. Fatorial de n recursivo
*/
fatorial(0,1).
fatorial(1,1).
fatorial(N,F) :-
    N > 1,
    N1 is N - 1,
    fatorial(N1, F1),
    F is N * F1.

/*
3. N-esimo elemento da sequencia de fibonacci
*/
fibo(1,0).
fibo(2,1).
fibo(N, ACC) :-
    N > 2,
    F1 is N-1,
    F2 is N-2,
    fibo(F1, RES1),
    fibo(F2, RES2),
    ACC is RES1 + RES2.
