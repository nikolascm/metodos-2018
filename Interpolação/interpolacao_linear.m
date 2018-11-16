% Metodo da Interpolação Linear
% Aluno: Nikolas Machado Correa

clear all

% Entrada dos dados
x = input('\nEntre com os valores do vetor x: ');
y = input('Entre com os valores do vetor y: ');
fprintf('\n')

% Variaveis
n = length(x);
grau = n-1;
pn = '';
A = [];

% Monta matriz A
for i=0 : grau
    A = [A; x.^(i)];
    grau = grau - 1;
end
solucao = Gauss(A',y');

% Escreve polinomio
for i=0 : n-1
     pn = [pn num2str(solucao(i+1)) '*x.^' num2str(i) ' +'];
end

% Imprime funcao
pn(length(pn)) = [];
fprintf('Polinomio -> P%d(x) = %s\n',n-1,pn);

% Plotar grafico da funcao
hold on
y_aproximado = str2func(['@(x)' pn]);
plot(x,y_aproximado(x),'b',...
    'LineWidth',2);

% Plotar grafico dos pontos
plot(x,y,'o',...
    'MarkerSize',8,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','r')

% Configuracao da legenda
legend({['y = ' pn]},'Location','best')
title('Interpolação Polinomial Linear')
    
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