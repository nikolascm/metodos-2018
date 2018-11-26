% Metodo de Gauss-Seidel
% Aluno: Nikolas Machado Correa

clear all;

A = input('\nInforme a matriz A: ');
b = input('Informe ao vetor b: ');
TOL = input('Insira o erro permitido: ');
NMAX = input('Número máximo de iterações: ');

% Calculos iniciais
[n m] = size(A);
X = zeros(1,n);
norma = 1;
k = 1;

% Cabecalho da tabela
fprintf('\n');
fprintf('k   x1         x2        x3');

while norma > TOL
    k = k+1;
    fprintf('\n%d', k);
    for i=1:n
        soma = 0;
        for j=1:(i-1)
            soma = soma + A(i,j)*x(j);
        end
        for j=i+1:n
            soma = soma + A(i,j)*X(j);
        end
        x(i) = (b(i) - soma)/A(i,i);
        fprintf('   %0.5f', x(i));
    end
    norma = norm(x-X);
    X = x;
    if k >= NMAX
        fprintf('\nNúmero de iteracoes excedido!\n\n');
        break;
    end
end

% Resultados
fprintf('\n\n');
fprintf('-> Iteracoes: %d\n',k);
fprintf('-> x1 = %0.5f\n',X(1));
fprintf('-> x2 = %0.5f\n',X(2));
fprintf('-> x3 = %0.5f\n',X(3));

