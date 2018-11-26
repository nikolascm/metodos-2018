% Metodo das Secantes
% Aluno: Nikolas Machado Correa

clear all;

% Entrada dos dados
func = input('\nEntre com a funcao (usando . antes de ^): ', 's');
x0 = input('Digite um valor para x0: ');
x1 = input('Digite um valor para x1: ');
TOL = input('Informe a tolerancia desejada: ');
NMAX = input('Informe o numero maximo de iteracoes: '); 
funcao = inline(func);

% Cabecalho da tabela
fprintf('\n');
fprintf('i  x0        x1        x2        f(x0)     f(x1)      f(x2)');

% Método das Secantes
i = 1;
while(i < NMAX)
    x2 = (x0*funcao(x1) - x1*funcao(x0)) / (funcao(x1) - funcao(x0));
    fprintf('\n%d  %0.5f   %0.5f   %0.5f   %0.5f   %0.5f   %0.5f', i,x0,x1,x2,funcao(x0),funcao(x1),funcao(x2));
    if((abs(funcao(x2)) < TOL) || ((abs(x2 - x1) / abs(x2)) < TOL))
        break;
    end 
    x0 = x1;
    x1 = x2;
    i = i+1;
end

% Resultados
solucao = x2;
if(i >= NMAX)
    printf('\n\n-> Número de iterações excedido. Solução: x1 = %0.5f\n',x1);
else
    fprintf('\n\n-> Solução: %0.5f\n', solucao);
end