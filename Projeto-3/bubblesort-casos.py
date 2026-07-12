import sys
import random
import time

def bubbleSort(alist):
    for passnum in range(len(alist)-1,0,-1):
        for i in range(passnum): # <-- Loop interno na linha correta
            if alist[i]>alist[i+1]:
                temp = alist[i]
                alist[i] = alist[i+1]
                alist[i+1] = temp
if len(sys.argv) != 3:
    print(f"ERRO nos parâmetros: python {sys.argv[0]} <tamanho> <tipo>", file=sys.stderr)
    print("  Tipo 1: Melhor Caso (Ordenado)", file=sys.stderr)
    print("  Tipo 2: Pior Caso (Invertido)", file=sys.stderr)
    print("  Tipo 3: Caso Médio (Aleatório)", file=sys.stderr)
    sys.exit(1)
try:
    valor = int(sys.argv[1])# número de elementos
    tipo = int(sys.argv[2])# tipo de caso (1, 2 ou 3)
    if valor <= 0 or tipo not in [1, 2, 3]:
        raise ValueError()
except ValueError:
    print("ERRO: Parâmetros inválidos.", file=sys.stderr)
    sys.exit(1)
alist = None
if tipo == 1: # Melhor Caso: Vetor já ordenado
    alist = list(range(valor))
elif tipo == 2: # Pior Caso: Vetor em ordem inversa
    alist = list(range(valor - 1, -1, -1))
else: # tipo == 3 # Caso Médio: Aleatório 
    alist = []
    for i in range (valor):
        alist.append(random.randrange(0,valor))
tempo_inicial = time.perf_counter()
bubbleSort(alist)
tempo_final = time.perf_counter()

tempo_total = tempo_final - tempo_inicial

# Imprime tamanho e tempo, no formato.
print(f"{valor};{tempo_total:.10f}")
