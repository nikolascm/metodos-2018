% Metodo da Falsa Posicao
% Aluno: Nikolas Machado Correa

clear all;

% Entrada dos dados
func = input('\nEntre com a funcao(usando . antes de ^): ', 's');
a = input('Digite o extremo esquerdo do intervalo(a): ');
b = input('Digite o extremo direito do intervalo(b): '); 
TOL = input('Informe a tolerancia desejada: ');
NMAX = input ('Numero maximo de iteracoes: '); 
funcao = inline(func);

% Calculos iniciais
aux = 0;
x = 0;
a_ = a;
b_ = b;
iteracao = 1;
FA = funcao(a);
FB = funcao(b);
intervalo = abs(b-a);

% Cabecalho da tabela
fprintf('\n');
fprintf('n  an        bn        x         f(x)');

while(intervalo > TOL)
    % Atualiza valor das variaveis
    x = (a*funcao(b)-b*funcao(a))/(funcao(b)-funcao(a));
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
        fprintf('\n-> |f(%d)|= %0.5f < TOL = %0.5f',iteracao,abs(fx),TOL);
		fprintf('\n-> Solucao: x = %0.5f\n\n',x);
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
    fprintf('\n-> Condicao((b-a)<TOL)');
    fprintf('\n-> (b-a)= %0.5f < TOL = %0.5f',intervalo,TOL);
    fprintf('\n-> Solucao: x = %0.5f\n\n',x);
end

% Graficos
hold on
grid on

% Plotar grafico funcao
y = str2func(['@(x)' func]);
plot([a_,b_], [0,0],'--');
fplot(y,[a_,b_],'b');

% Plotar ponto
plot(x,funcao(x),'o',...
    'MarkerSize',6,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','r');

% Configuracao da legenda
title('Método da Falsa Posição');