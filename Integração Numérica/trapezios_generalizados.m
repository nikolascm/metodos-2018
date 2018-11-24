% Regra dos Trapezios Generalizada
% Aluno: Nikolas Machado Correa

clear all

% Entrada dos dados
funcao = input('\nEntre com a funcao(usando . antes de ^): ', 's');
a = input('Digite o limite esquerdo do intervalo(a): ');
b = input('Digite o limite direito do intervalo(b): '); 
n = input('Informe o numero de subintervalos: ');
funcao = inline(funcao);
h = (b-a)/n;

% Gerar x
k = 1;
for i = a:h:b
    x(k) = i;
    k = k + 1;
end

% Gerar y
k = 1;
for i = a:h:b
    y(k) = funcao(x(k));
    k = k + 1;
end

% Regra dos Trapezios
soma = 0;
for i=2 : n
    soma = soma + 2*y(i);
end
I = h/2*(y(1) + y(n+1) + soma)

% Plotar grafico
plota_graficos(x,y,funcao);

function plota_graficos(x,y,funcao)    
    % Plotar grafico funcao
    hold on
    grid on
    plot(x,funcao(x),'b',...
        'LineWidth',2);

    % Plotar grafico dos pontos
    plot(x,y,'o',...
        'MarkerSize',6,...
        'MarkerEdgeColor','r',...
        'MarkerFaceColor','r');
    
    % Titulo
    title('Regra dos Trapézios');
end
