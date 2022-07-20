% Tarefa 3 - Coloração de Mapa
% Gabriel Christo - 117217732
% João Barbosa - 117055449

% Faça um programa Prolog que dado um mapa qualquer, define uma coloração para o mapa usando 4 cores de tal forma que nenhuma região adjacente será pintada com a mesma cor. O seu programa deve ser feito de forma que: 
% (a) as fronteiras entre os países devem ser definidas como fatos. Por exemplo, a fronteira entre Brasil e Argentina deve ser definida como fronteira(brasil,argentina).
% (b) as cores devem ser definidas como fatos: cor(azul), cor(verde),cor(vermelho), cor(amarelo)
% (c) a resposta deve ser uma lista formada por pares (Pais,Cor). Por exemplo: [(brasil,verde),(argentina,azul)]
% (d) somente 1 resposta deve ser gerada
% Comente seu programa, indicando como os mapas e cores são definidos, além de explicar como o mesmo processa as respostas. Lembre de definir como deve ser feita uma consulta.

% Definição dos fatos para diferenciação das cores.
% Baseado nas cores abaixo, o programa atribui uma cor para cada país da entrada com algum país fronteira.
diff_color(azul, verde).
diff_color(verde, azul).
diff_color(azul, vermelho).
diff_color(vermelho, azul).
diff_color(azul, amarelo).
diff_color(amarelo, azul).
diff_color(verde, vermelho).
diff_color(vermelho, verde).
diff_color(verde, amarelo).
diff_color(amarelo, verde).
diff_color(vermelho, amarelo).
diff_color(amarelo, vermelho).       

applyColor([]). % caso base
applyColor([[_|[]]|T]) :- applyColor(T). % fim da lista de fronteiras com dado país sendo avaliado
applyColor([[H|[F1|F2]]|T]) :- 
    diff_color(H,F1), % país H será colorido diferente da cabeça F1 da lista de fronteiras
    applyColor([[H|F2]|T]). % itera o restante da lista de fronteiras

% Exemplo de mapa de entrada:
% [[Brasil | [Uruguai, Argentina, Chile, Paraguai]], [Uruguai | [Brasil, Argentina, Chile]], [Argentina | [Brasil, Uruguai, Chile]], [Chile | [Brasil, Uruguai, Argentina, Paraguai]], [Paraguai | [Brasil, Chile]]]
% onde a cabeça da lista representa o país e a cauda representa suas fronteiras.
% Não conseguimos efetuar a coloração com as fronteiras sendo definidas como fatos.
% 
% A consulta é feita da seguinte maneira:
% ?-applyColor([[Brasil | [Uruguai, Argentina, Chile, Paraguai]], [Uruguai | [Brasil, Argentina, Chile]],[Argentina | [Brasil, Uruguai, Chile]], [Chile | [Brasil, Uruguai, Argentina, Paraguai]], [Paraguai | [Brasil, Chile]]]).
% O programa exibirá as possibilidades de se colorir o mapa.
