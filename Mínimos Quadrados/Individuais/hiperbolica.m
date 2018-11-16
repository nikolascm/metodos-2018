% Metodo dos Minimos Quadrados
% Hiperbolica do tipo y = 1/(a + bx)

clear all

% Entrada dos dados
x = input('\nEntre com os valores do vetor x: ');
y = input('Entre com os valores do vetor y: ');
grau = 1;

% Metodo dos minimos quadrados
A = [length(x) sum(x); sum(x) sum(x.^2)];

% Monta vetor coluna (b)
b(1) = sum(1./y);
b(2) = sum(x./y);

% Resultado
solucao = Gauss(A,b);
a_ = solucao(1);
b_ = solucao(2);

% Conversao: String -> Funcao
s = ['1 ./ (' num2str(a_) ' + (' num2str(b_) '.*x))'];

% Imprime funcao
fprintf('\nFunção: %s\n',s);

% Plotar grafico da funcao
hold on
grid on
y_aproximado = str2func(['@(x)' s]);
plot(x,y_aproximado(x),'b',...
    'LineWidth',1);

% Plotar grafico dos pontos
plot(x,y,'o',...
    'MarkerSize',4,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','r');

% Configuracao da legenda
legend({['y = ' s]},'Location','best');
title('Método dos Mínimos Quadrados');

% Metodo de Gauss
function solucao = Gauss(A,b)
    %% Condição: determinante não ser nulo
    if(det(A))==0
        fprintf('Determinante = 0, solução não determinada.\n');
        return;
    end
    [n m] = size(A);
    for k = 1 : (n-1)
        for i = (k+1) : n
            m = A(i,k)/A(k,k);
            A(i,k) = 0;
            for j = (k+1) : n
                A(i,j) = A(i,j) - (m * A(k,j));
            end
            b(i) = b(i) - m * b(k);
        end
    end
    %% Resolução do sistema triangular superior
    x = b;
    x(n) = b(n)/A(n,n); 
    for i=n-1 :-1: 1
        soma = 0;
        for j=(i+1) : n
            soma = soma + A(i,j)*x(j);
        end
        x(i) = (b(i) - soma)/A(i,i);
    end
    solucao = x;
end