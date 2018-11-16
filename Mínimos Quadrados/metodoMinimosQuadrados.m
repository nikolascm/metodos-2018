% Metodo dos Minimos Quadrados
% Aluno: Nikolas Machado Correa

clear all

% Entrada dos dados
x = input('\nEntre com os valores do vetor x: ');
y = input('Entre com os valores do vetor y: ');

imprime_opcoes();
ajuste = input('\n\nInforme o valor correspondente ao ajuste desejado: ');

switch ajuste
    case 1
        grau = input('Informe o grau do polinomio: ');
        polinomial(x,y,grau);
    case 2
        exponencial(x,y,ajuste);
    case 3
        exponencial(x,y,ajuste);
    case 4
        hiperbolico(x,y);
    case 5
        geometrico(x,y);
    otherwise
        fprintf('Valor nao reconhecido, tente novamente!\n\n');
        return;
end

function imprime_opcoes()
    fprintf('\n1 - Polinomial')
    fprintf('\n2 - Exponencial (a.e^(bx)')
    fprintf('\n3 - Exponencial (a.b^(x))')
    fprintf('\n4 - Hiperbolico (1/a+bx)')
    fprintf('\n5 - Geometrico (a.x^(b))')
end

function polinomial(x,y,grau)
    % Monta matriz (A)
    for i=0:grau
        for j=0:grau
            A(i+1,j+1) = sum(x.^(j+i));
        end
    end
    % Monta vetor coluna (b)
    for i=0:grau
        b(i+1) = sum((x.^i).*y);
    end
    % Resultado
    converte_funcao(Gauss(A,b),1,x,y);
end

function exponencial(x,y,ajuste)
    % Monta matriz (A)
    Y = log(y);
    A = [length(x) sum(x); sum(x) sum(x.^2)];

    % Monta vetor coluna (b)
    b(1) = sum(Y);
    b(2) = sum(x.*Y);

    % Resultado
    converte_funcao(Gauss(A,b),ajuste,x,y);
end

function hiperbolico(x,y)
    % Monta matriz (A)
    A = [length(x) sum(x); sum(x) sum(x.^2)];

    % Monta vetor coluna (b)
    b(1) = sum(1./y);
    b(2) = sum(x./y);

    % Resultado
    converte_funcao(Gauss(A,b),4,x,y);
end

function geometrico(x,y)
    % Monta matriz (A)
    X = log(x);
    Y = log(y);
    A = [length(x) sum(X); sum(X) sum(X.^2)];

    % Monta vetor coluna (b)
    b(1) = sum(Y);
    b(2) = sum(X.*Y);

    % Resultado
    converte_funcao(Gauss(A,b),5,x,y);
end

function converte_funcao(solucao,ajuste,x,y)
    s = '';
    switch ajuste
        case 1
            % Conversao: String -> Funcao
            for i=0 : length(solucao)-1
                s = strcat(s,['+' num2str(solucao(i+1),'%0.4f') '*x.^' num2str(i)]);
            end
        case 2
            a = exp(solucao(1));
            b = solucao(2);
            % Conversao: String -> Funcao
            s = [num2str(a) '*(exp(' num2str(b,'%0.4f') '*x))'];
        case 3
            a = exp(solucao(1));
            b = exp(solucao(2));
            % Conversao: String -> Funcao
            s = [num2str(a) ' *(' num2str(b) '.^x)'];
        case 4
            a = solucao(1);
            b = solucao(2);
            % Conversao: String -> Funcao
            s = ['1 ./ (' num2str(a) ' + (' num2str(b) '.*x))'];
        case 5
            a = exp(solucao(1));
            b = solucao(2);
            % Conversao: String -> Funcao
            s = [num2str(a) ' *x.^' num2str(b)];
    end
    plota_graficos(x,y,s);
end

function plota_graficos(x,y,s)
    % Imprime funcao
    fprintf('\nFuncao de ajuste: %s\n', s);
    
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
end

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