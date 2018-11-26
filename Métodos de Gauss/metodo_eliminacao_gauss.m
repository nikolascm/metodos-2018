% Metodo de Eliminacao de Gauss
% Aluno: Nikolas Machado Correa

clear all;

A = input('\nEntre com os valores da matriz A: ');
b = input('Entre com os valores do vetor b: ');

% Condicao: determinante nao ser nulo
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

% Resolucao do sistema triangular superior
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

% Resultados
fprintf('\nMatriz final: \n\n');
disp(A);
fprintf('\nVetor solução: \n\n');
disp(x);