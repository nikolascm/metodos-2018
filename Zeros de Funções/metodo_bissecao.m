% Metodo da Bissecao
% Aluno: Nikolas Machado Correa

clear all;

% Entrada dos dados
funcao = input('\nEntre com a funcao(usando . antes de ^): ', 's');
a = input('Digite o extremo esquerdo do intervalo(a): ');
b = input('Digite o extremo direito do intervalo(b): '); 
TOL = input('Informe a tolerancia desejada: ');
NMAX = input ('Numero maximo de iteracoes: '); 
funcao = inline(funcao);

% Calculos iniciais
aux = 0;
x = 0;
x_ = [];
fx_ = [];
iteracao = 1;
FA = funcao(a);
FB = funcao(b);
intervalo = abs(b-a);

% Cabecalho da tabela
fprintf('\n');
fprintf('n  an        bn        x         f(x)');

while(intervalo > TOL)
    % Atualiza valor das variaveis
    x = (a+b)/2;
	fx = funcao(x);
    intervalo = abs(b-a);

    if(fx<0)
    	fprintf('\n%d  %0.5f   %0.5f   %0.5f   %0.5f',iteracao,a,b,x,fx);
    else
        fprintf('\n%d  %0.5f   %0.5f   %0.5f   +%0.5f',iteracao,a,b,x,fx);
    end
    if(abs(fx) < TOL)
        fprintf('\n');
        fprintf('\n-> Condicao(f(x)<TOL)');
        fprintf('\n->f(%d)= %0.5f < TOL = %0.5f',iteracao,fx,TOL);
		fprintf('\nA solucao obtida vale aproximadamente: %0.5f\n\n',fx);
		aux = 1;
        break;
	else
		iteracao = iteracao + 1;
        if(FA*fx<0)
			b = x;
			FB = fx;
        else
			a = x;
            FA = fx;
        end
    end
    if(iteracao >= NMAX)
        fprintf('\nNúmero de iteracoes excedido!\n\n');
        return;
    end
end
if(aux==0)
    fprintf('\n');
    fprintf('\n->Condicao((b-a)<TOL)');
    fprintf('\n(b-a)= %0.5f < TOL = %0.5f',intervalo,TOL);
    fprintf('\nA solucao obtida vale aproximadamente: %0.5f\n',x);
end

% Plotar grafico da funcao
hold on
grid on
x_ = a:TOL:b;
xlim([a, b]);
ylim ([funcao(a), funcao(b)]);
plot(x_, funcao(x_), 'b',(a+b)/2, funcao((a+b)/2), 'o-r', [a,b], [0,0],'--');

% Configuracao da legenda
title('Método da Bisseção');