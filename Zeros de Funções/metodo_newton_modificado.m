% Metodo de Newton Modificado
% Aluno: Nikolas Machado Correa

clear all;

% Entrada dos dados
x0 = input('\nDigite um valor inicial: ');
TOL = input('Informe a tolerancia desejada: ');
NMAX = input('Informe o numero maximo de iteracoes: '); 
funcao_ = input('Entre com a funcao (usando . antes de ^): ', 's');
derivada = input('Entre com a derivada da funcao: ', 's');

% Calculos iniciais
i = 0;
x = x0;
delta_x = 1;
solucao = 0;
convergiu = '';

% Cabecalho da tabela
fprintf('\n');
fprintf('n    xn        f(xn)           f�(xn)');

% Metodo de Newton Modificado
deriv = str2func(['@(x)' derivada]);    
dfx = deriv(x);

while i < NMAX
    func = str2func(['@(x)' funcao_]);
    fx = func(x);
    if(fx>0)
        fprintf('\n%d    %0.5f   +%0.5e    %0.5f', i, x, fx, dfx);
    else
        fprintf('\n%d    %0.5f   %0.5e    %0.5f', i, x, fx, dfx);
    end
    if(abs(delta_x) <= TOL & (abs(fx) <= TOL || dfx == 0))
        break;
    end
    delta_x = fx/dfx;
    x = x - delta_x;
    i = i + 1;
end

% Resultados
solucao = x;
info = abs(delta_x) > TOL || abs(fx) > TOL;
if(info == 0)
    convergiu = 'Sim';
else
    convergiu = 'N�o';
end

% Imprime resultados
fprintf('\n\n');
fprintf('-> Solu��o: x = %f\n', solucao);
fprintf('-> Convergiu? = %s\n\n', convergiu);
