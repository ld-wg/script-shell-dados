# script-shell-dados
Shell script de processamento de dados, feito especificamente para o tipo de arquivo da entrada. Lê arquivos .csv com dados e faz uma série de leituras, tabelas e gráficos (Gnuplot).

O objetivo deste trabalho é fazer um script chamado evasao.sh que:

1. Leia todos os arquivos do diretório descompactado da extração do arquivo evasao2014-18.tar.gz

2. Concatene as informações de cada arquivo em um único arquivo

3. Faça um ranking (ordenado de modo decrescente) de cada "forma de evasão", considerando o total de evasões no período disponível (2014-2018).

4. Com base no ano de evasão (este dado faz parte do nome de cada arquivo .csv), faça um ranking que mostre a quantidade de anos que os alunos ficam na universidade antes de ocorrer a evasão, isto é, quantos alunos ficam 1 ano, quantos ficam 2 e por aí vai...

5. Mostre para cada ano, qual foi o semestre (1o ou 2o) que teve mais casos de evasão e a porcentagem correspondente

6. Mostre a porcentagem da média de evasões do sexo masculino e feminino ao longo do período (2014 a 2018).

7. Produza um gráfico (de linha) com os anos de evasão no eixo x e o número de evasões no eixo y (use o Gnuplot)

8. Produza um gráfico (de barras) mostrando, para cada ano, o número de evasões por forma de ingresso
