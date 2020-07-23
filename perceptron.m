% X:           padr�es (entradas da rede);
% D:           alvos desejados (sa�das apresentadas para a rede);
% Y:           sa�das obtidas (calculadas) pela rede; 
% g:           ativa��o do neur�nio;
% delta:       erro da sa�da (D - Y);
% alpha:       taxa de aprendizado;
% w:           pesos das conex�es sin�pticas dos neur�nios;
% erro_epoca:  Erro acumulado numa �poca;
% epoca_max:   m�ximo de �pocas permitidas de treinamento.

clc
clear all
close all

% Inicia vari�veis
g = 0;      %potencial de ativa��o
x0 = -1;    %entrada zero, sempre -1

% Carrega dados de entrada
X = load('entradas.txt');   
[nPadroes, nEntradas] = size(X);

%Sa�da desejada
D = load('OR.txt');
% D = [0; 0; 0; 1];   %AND
% D = [0; 1; 1; 1];   %OR


%Inicia o vetor de pesos, com valores aleat�rios
%A dimens�o de w ser� a dimens�o da entrada+1, devido ao bias
w = rand(1,nEntradas+1)

alpha = 0.1;                      % Taxa de Aprendizado.
epoca_max = 10;                       % Itera��es m�ximas.


for epoca = 1:epoca_max
    Y = zeros(nPadroes,1);
    erro_epoca = 0;

    for j=1:nPadroes
        g = sum(X(j,:).*w(2:nEntradas+1)) + x0*w(1);    %Calcula Y
        if (g < 0) 
            Y(j) = 0;
        else
            Y(j) = 1;    
        end
            
        delta = D(j)-Y(j);
        w(1) = w(1) + alpha*X(1,1)*delta

        for i=2:nEntradas+1
            w(i) = w(i) + alpha*X(j,i-1)*delta;
        end
            
        erro_epoca = erro_epoca + abs(delta);
    end
    if (erro_epoca == 0)                    %Se erro = 0, para o treinamento
        break;
    end           
end

% Resultados
if (erro_epoca == 0)
    disp('A rede convergiu para o resultado desejado.');
else
    disp('A rede n�o convergiu para o resultado desejado.');
end

disp(' ');
disp(['�pocas: ',num2str(epoca)]);
disp(['bias:   ',num2str(w(1,1))]);

for i=2:nEntradas+1
    disp(['w',num2str(i) ': ',num2str(w(i))]);
end
disp(' ');

disp('Teste da Rede para os pesos encontrados: ');

for j=1:nPadroes
    disp(['X1 = ',num2str(X(j,1)),...
        ' X2 = ',num2str(X(j,2)),...
        ' Yrede = ',num2str(Y(j)),...
        ' Ydesejado = ',num2str(D(j))]);
end