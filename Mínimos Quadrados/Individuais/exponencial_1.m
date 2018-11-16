%  Metodo dos Minimos Quadrados
%  Exponencial do tipo ae^(bx)

clear all

% Entrada dos dados
x = input('\nEntre com os valores do vetor x: ');
y = input('Entre com os valores do vetor y: ');
grau = 1;

% Metodo dos minimos quadrados
Y = log(y);
A = [length(x) sum(x); sum(x) sum(x.^2)];

% Monta vetor coluna (b)
b(1) = sum(Y);
b(2) = sum(x.*Y);

% Resultado
solucao = Gauss(A,b);
a_ = exp(solucao(1));
b_ = solucao(2);

% Conversao: String -> Funcao
s = [num2str(a_) '*(exp(' num2str(b_,'%0.4f') '*x))'];

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
    'MarkerFaceColor','r')

% Configuracao da legenda
legend({['y = ' s]},'Location','best')
title('Método dos Mínimos Quadrados')

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

