#!/bin/bash
# VERIFICA QUANTIDADE DE PARAMETROS
if [ $# -ne 4 ]; then
	echo "Sintaxe errada!"
	echo "Utilize -l <linguagem> -a <algoritmo>"
	exit
fi

# PARAMETROS
LINGUAGEM=$2
ALGORITMO=$4
CASO=3
EXECUCOES=10

# ARQUIVOS
LOG_BRUTO="log_${ALGORITMO}_${LINGUAGEM}.csv"
echo "N_Execucao;Tamanho;Tempo" > "$LOG_BRUTO"

LOG_FLT="LogFLT_${ALGORITMO}_${LINGUAGEM}.csv"
echo "Tamanho;Tempo" > "$LOG_FLT"

# VERIFICA ALGORITMO
if [ "$ALGORITMO" != "mergesort" -a "$ALGORITMO" != "bubblesort" ]; then
	echo "Sintaxe de algoritmo errada!"
	echo "Utilize 'mergesort' ou 'bubblesort'"
	exit
fi

# VERIFICA LINGUAGEM E DEFINE COMANDO
case $LINGUAGEM in
	c)
		PROGRAMA="./${ALGORITMO}-casos_${LINGUAGEM}";;
	python)
		PROGRAMA="python3 ${ALGORITMO}-casos.py";;		
	*)
	echo "Sintaxe de linguagem errada!"
	echo "Utilize 'c' ou 'python'"
	exit;;
esac

# EXECUTA ARQUIVO DE ORDENACAO
for ENTRADA in 1 2 3 4 5
do
	TAMANHO=$(( 10 ** $ENTRADA ))
	
	for (( LOOP=0; LOOP < $EXECUCOES; LOOP++ )); do
		RESULTADO=$($PROGRAMA $TAMANHO $CASO)
		echo "$((LOOP+1));$RESULTADO" >> "$LOG_BRUTO"
	done
done
echo "Dados brutos salvos em: $LOG_BRUTO"

#VETOR DOS TEMPOS
VET_TEMPOS=($(cut -d ';' -f3 "$LOG_BRUTO"))

# CALCULO DAS MEDIAS
for ((i=1; i<${#VET_TEMPOS[@]}; i+=$EXECUCOES)); do
	SOMA=0

	for ((j=0; j<10 ; j++)); do
		SOMA=$(echo "$SOMA + ${VET_TEMPOS[i+j]}" | bc)
	done
	
	MEDIA=$(echo "scale=8; $SOMA/$EXECUCOES" | bc)
    	echo "$((10 ** (i/10 + 1)));$MEDIA" >> "$LOG_FLT"
done

echo "  -> Médias salvas em: $LOG_FLT"
exit
