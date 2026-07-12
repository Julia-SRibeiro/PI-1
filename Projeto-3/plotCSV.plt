# Configurações de Saída
set terminal pngcairo size 1280,720 enhanced font "Segoe UI,10"
set output "grafico.png"

# Título e Labels
set title "Análise de complexidade de algoritmos de ordenação (Caso 3 - Aleatório)\nMergesort vs Bubblesort em C e Python" font ",14 bold"
set xlabel "Tamanho do Vetor (Elementos)"
set ylabel "Tempo de Execução (segundos)"

# Estética
set grid lw 1 lc rgb "#dddddd"
set border lw 1.5
#set key top left box opaque shadow
set datafile separator ";"

# Escala Logarítmica 
# Se quiser linear, comente as duas linhas abaixo com #
set logscale x 10
set logscale y 10
set format x "10^{%L}"
set format y "10^{%L}"

# Rodapé com Informações do Sistema
# Verifica se a variável existe, senão deixa em branco
if (!exists("INFO_RODAPE")) INFO_RODAPE='Info do sistema não disponível'
set label 1 INFO_RODAPE at screen 0.5, 0.03 center font "Courier,8" tc rgb "#555555" noenhanced

# Estilo e cores das linhas
set style line 1 lw 3 lc rgb "#e6194B" pt 7 ps 1.5 # Vermelho (Merge C)
set style line 2 lw 3 lc rgb "#f58231" pt 7 ps 1.5 # Laranja (Merge Py)
set style line 3 lw 3 lc rgb "#4363d8" pt 9 ps 1.5 # Azul (Bubble C)
set style line 4 lw 3 lc rgb "#42d4f4" pt 9 ps 1.5 # Ciano (Bubble Py)

# Plotagem dos 4 arquivos simultaneamente
# Como usamos logscale, se houver tempo 0, o gnuplot pode reclamar, mas plota o resto.
plot \
    'LogFLT_mergesort_c.csv'      using 1:2 with linespoints ls 1 title "Mergesort (C)", \
    'LogFLT_mergesort_python.csv' using 1:2 with linespoints ls 2 title "Mergesort (Python)", \
    'LogFLT_bubblesort_c.csv'     using 1:2 with linespoints ls 3 title "Bubblesort (C)", \
    'LogFLT_bubblesort_python.csv' using 1:2 with linespoints ls 4 title "Bubblesort (Python)"

set output
