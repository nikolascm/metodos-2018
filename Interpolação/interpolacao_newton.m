% Polinomio de Interpolacao de Newton
% Aluno: Nikolas Machado Correa

clear all

% Entrada dos dados
x = input('\nEntre com os valores do vetor x: ');
y = input('Entre com os valores do vetor y: ');

% Variaveis
polinomio = '';
n = length(x);
cont = n-1;
k = 1;

% Interpolacao de Newton
A = zeros(n,n+1);
A(:,1) = x;
A(:,2) = y;
for j=3 : n+1
    for i=1 : cont
        num = A(i+1,j-1) - A(i,j-1);
        den = A(i+k,1) - A(i,1);
        A(i,j) = num/den;
    end
    k = k + 1;
    cont = cont-1;
end

% Escrever polinomio
for j=1:n
    polinomio = [polinomio ' + (' num2str(A(1,j+1)) ')'];
    for i=1:j-1
        polinomio = [polinomio '.*(x-' num2str(x(i)) ')'];
    end
end

% Imprimir resultados
fprintf('\nPolinômio => P%d(x) = %s\n\n',n,polinomio);
disp(A);

% Plotar gráfico
plota_graficos(x,y,polinomio);

function plota_graficos(x,y,s)    
    % Plotar grafico funcao
    hold on
    grid on
    y_aproximado = str2func(['@(x)' s]);
    plot(x,y_aproximado(x),'b',...
        'LineWidth',2);

    % Plotar grafico dos pontos
    plot(x,y,'o',...
        'MarkerSize',6,...
        'MarkerEdgeColor','r',...
        'MarkerFaceColor','r');
    
    % Titulo
    title('Interpolação de Newton');
end

