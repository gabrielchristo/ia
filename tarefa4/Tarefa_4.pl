% Tarefa 4 - Problema das Jarras
% Gabriel Christo - 117217732
% João Barbosa - 117055449

% Item 1a: escrever os fatos com estados finais do problema
% o objetivo e colocar 2 litros na jarra 1
objetivo(Estado) :-
	Estado=(2,0);
	Estado=(2,1);
	Estado=(2,2);
	Estado=(2,3).

% Item 1b: definir predicados de acoes sobre as jarras
acao((J1,J2),encher1,(4,J2)):- J1 < 4. % completa 1
acao((J1,J2),encher2,(J1,3)):- J2 < 3. % completa 2
acao((J1,J2),esvaziar1,(0,J2)):- J1 \== 0. % esvazia 1
acao((J1,J2),esvaziar2,(J1,0)):- J2 \== 0. % esvazia 2

acao((J1,J2),passar12,(NJ1,NJ2)):-
    J1>0, J1+J2<3, NJ2 is J1+J2, NJ1 is 0; % jarro 1 completo para jarro 2
    J1>0, J1+J2>3, NJ2 is 3, NJ1 is J1-(3-J2). % jarro 1 parcial para jarro 2
    
acao((J1,J2),passar21,(NJ1,NJ2)):-
    J2>0, J1+J2<4, NJ2 is 0, NJ1 is J1+J2; % jarro 2 completo para jarro 1
    J2>0, J1+J2>4, NJ1 is 4, NJ2 is J2-(4-J1). % jarro 2 parcial para jarro 1

% Item 1c: definir predicado vizinho usando predicado ternario findall
% N eh o estado das jarras atual a ser usado nos predicados de acao
neighbors(N, FilhosN) :- findall(X, acao(N, _, X), FilhosN).

% Item 1d: implementar algoritmo de busca em largura e consulta para buscar solucao a partir do estado inicial
% exemplo de consulta: ?-search_BFS([(0,0)]).

% --- Algoritmo de busca generico (fronteira para busca em largura) ---
% search eh verdadeiro se existe caminho de elemento da fronteira ate objetivo
% neighbors e verdadeiro se NN eh lista dos vizinhos de Node
% add_to_frontier define tipo de busca
search_BFS([Node | _]) :- objetivo(Node), !. % cut pois chegamos ao objetivo
search_BFS([Node | F1]) :-
    neighbors(Node, NN),
    add_to_frontier_BFS(NN, F1, F2),
    search_BFS(F2).

% fronteira para busca em largura
add_to_frontier_BFS(NN, F1, F2) :- append(F1, NN, F2).

% Item 1e: modificar item 1d para guardar sequencia de configuracoes dos estados
% para isso podemos adicionar uma lista de estados atualizada durante a busca
% exemplo de consulta: ?-search_BFS_stateful([(0,0)], L).
% --- Algoritmo de busca generico (fronteira para busca em largura salvando estados) ---
search_BFS_stateful([Node | _], [Node]) :- objetivo(Node). % cut removido para mostrar outras sequencias
search_BFS_stateful([Node | F1], [Node | L]) :-
    neighbors(Node, NN),
    add_to_frontier_BFS(NN, F1, F2),
    search_BFS_stateful(F2, L).

% Item 1f: modificar item 1e para evitar estados repetidos
% para isso devemos filtrar a fronteira impedindo os nos vizinhos repetidos
% exemplo de consulta: ?-search_BFS_stateful_unique([(0,0)], L).
diff(F, N, Result) :-
    intersection(F, N, Intersect), % intersecao dos vizinhos novos com fronteira
    subtract(N, Intersect, Result). % tirando vizinhos repetidos

search_BFS_stateful_unique([Node | _], [Node]) :- objetivo(Node). % cut removido para mostrar outras sequencias
search_BFS_stateful_unique([Node | F1], [Node | L]) :-
    neighbors(Node, NN),
    diff(F1, NN, NN_handled),
    add_to_frontier_BFS(NN_handled, F1, F2),
    search_BFS_stateful_unique(F2, L).

% Item 1g: repetir itens anteriores usando busca em profundidade
% no caso do item 1d em profundidade vai ocorrer um estouro de pilha devido limitacao de memoria
% no caso do item 1e em profundidade tambem vai ocorrer um estouro de pilha devido limitacao de memoria

% no caso do item 1f em profundidade temos o seguinte
% Algoritmo de busca generico (fronteira para busca em profundidade)
% exemplo de consulta: ?-search_DFS_stateful_unique([(0,0)], L).
search_DFS_stateful_unique([Node | _], [Node]) :- objetivo(Node). % cut removido para mostrar outras sequencias
search_DFS_stateful_unique([Node | F1], [Node | L]) :-
    neighbors(Node, NN),
    diff(F1, NN, NN_handled),
    add_to_frontier_DFS(NN_handled, F1, F2),
    search_DFS_stateful_unique(F2, L).

% fronteira para busca em profundidade
add_to_frontier_DFS(NN, F1, F2) :- append(NN, F1, F2).
