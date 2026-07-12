#!/bin/bash

#VERIFICA SE O SCRIPT SHELL EXISTE E DA PERMISSÃO
if [ -f shell_script.sh ]; then
    chmod +x shell_script.sh
else
    echo "shell_cript não encontrado"
    exit 1
fi

echo "Iniciando os testes: ..."

rm -f LogFLT_*.csv

# EXECUTA AS QUATRO EXECUÇÕES NECESSÁRIAS
echo "Rodando Mergesort em C..."
./shell_script.sh -l c -a mergesort

echo "Rodando Mergesort em Python..."
./shell_script.sh -l python -a mergesort

echo "Rodando Bubblesort em C..."
./shell_script.sh -l c -a bubblesort

echo "Rodando Bubblesort em Python..."
./shell_script.sh -l python -a bubblesort

echo "Testes finalizados. Gerando gráfico: ... ---"

# COLETA INFORMAÇÕES DO SISTEMA PARA O RODAPÉ
OS=$(lsb_release -d 2>/dev/null | cut -f2 || echo "Linux Generico")
CPU=$(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | xargs || echo "CPU Desconhecida")
RAM=$(free -h | grep Mem | awk '{print $2}' || echo "RAM Desconhecida")
GPU=$(lspci | grep -i vga | cut -d: -f3 | xargs || echo "GPU Integrada/Desconhecida")

INFO_SISTEMA="Ambiente: $OS | CPU: $CPU | RAM: $RAM | GPU: $GPU"

# CHAMA O GNUPLOT PASSANDO A INFO DO SISTEMA
gnuplot -e "INFO_RODAPE='$INFO_SISTEMA'" plotCSV.plt

echo "Verifique o arquivo 'gráfico.png'."
