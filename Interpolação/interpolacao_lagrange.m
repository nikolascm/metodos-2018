% Metodo da Interpolação de Lagrange
% Aluno: Nikolas Machado Correa

% Entrada dos dados
x = input('\nEntre com os valores do vetor x: ');
y = input('Entre com os valores do vetor y: ');
fprintf('\n')

% Determinação do grau
n = length(x);
grau = n-1;

% Interpolação de Lagrange
s = '';
pn = "";

for i=1:n
    L = "";
    pn = "";
    den = 1;
    num = "";
    for j=1:n
        if i~=j
            if(num ~= "")
                num = [num '.*(x-' num2str(x(j)) ')'];
            else
                num = ['(x-' num2str(x(j)) ')'];
            end
            den = den * (x(i)-x(j));
        end
    end
    L = [num ')/(' num2str(den)];
    if pn~= ""
        pn = [pn ' + ' num2str(y(i)) '.*(' L ')'];
    else
        pn = ['.*(' L ')'];
        fprintf('i=%d -> %s .* L%d(x) = %s\n',i,num2str(y(i)),i,[num2str(y(i)) pn]); 
    end
    s = [s '+(' num2str(y(i)) pn ')'];
end

plota_graficos(x,y,s);

function plota_graficos(x,y,s)
    % Imprime funcao
    fprintf('\nPolinomio de Lagrange: %s\n', s);
    
    % Plotar grafico funcao
    hold on
    y_aproximado = str2func(['@(x)' s]);
    plot(x,y_aproximado(x),'b',...
        'LineWidth',2);

    % Plotar grafico dos pontos
    plot(x,y,'o',...
        'MarkerSize',6,...
        'MarkerEdgeColor','r',...
        'MarkerFaceColor','r')

    % Titulo
    title('Interpolação de Lagrange');
end
