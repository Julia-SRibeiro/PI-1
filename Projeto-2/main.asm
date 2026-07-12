#(A + B + !C)*(A + !B + C)*(A + !B + !C)*(!A + B + C)
.data
msg_a: .asciiz "Insira o valor de A: "
msg_b: .asciiz "Insira o valor de B: "
msg_c: .asciiz "Insira o valor de C: "
msg_s: .asciiz "O valor de S e: "

.text
.globl main

main:
# Ler A, B e C
la $a0, msg_a # Move mensagem para %a0
jal ler_valor # Chama procedimeto
move $s0, $v0 # A

la $a0, msg_b # Move mensagem para %a0
jal ler_valor # Chama procedimeto
move $s1, $v0 # B

la $a0, msg_c # Move mensagem para %a0
jal ler_valor # Chama procedimeto
move $s2, $v0 # C


# Negar
move $a0, $s0 # Move A para %a0
jal negar # Chama procedimeto
move $s3, $v0 # A!

move $a0, $s1 # Move B para %a0
jal negar # Chama procedimeto
move $s4, $v0 # B!

move $a0, $s2 # Move C para %a0
jal negar # Chama procedimeto
move $s5, $v0 # C!


# Somas
addi $sp, $sp, -24 # Empilha
sw $s0, 0($sp) # A
sw $s1, 4($sp) # B
sw $s2, 8($sp) # C
sw $s3, 12($sp) # A!
sw $s4, 16($sp) # B!
sw $s5, 20($sp) # C!

# (A + B + !C)
lw $a0, 0($sp) # Move da pilha para $a0
lw $a1, 4($sp) # Move da pilha para $a1
lw $a2, 20($sp) # Move da pilha para $a2
jal soma # Chama procedimeto
move $t1, $v0
# (A + !B + C)
lw $a0, 0($sp) # Move da pilha para $a0
lw $a1, 16($sp) # Move da pilha para $a1
lw $a2, 8($sp) # Move da pilha para $a2
jal soma # Chama procedimeto
move $t2, $v0
# (A + !B + !C)
lw $a0, 0($sp) # Move da pilha para $a0
lw $a1, 16($sp) # Move da pilha para $a1
lw $a2, 20($sp) # Move da pilha para $a2
jal soma # Chama procedimeto
move $t3, $v0
# (!A + B + C)
lw $a0, 12($sp) # Move da pilha para $a0
lw $a1, 4($sp) # Move da pilha para $a1
lw $a2, 8($sp) # Move da pilha para $a2
jal soma # Chama procedimeto
move $t4, $v0

addi $sp, $sp, 24 # Desempilha


# Multiplicações
#1
move $a0, $t1
move $a1, $t2
jal multiplica
move $t0, $v0
#2
move $a0, $t0
move $a1, $t3
jal multiplica
move $t0, $v0
#3
move $a0, $t0
move $a1, $t4
jal multiplica
move $t0, $v0

move $s6, $v0 # Valor final


# Saída
la $a0, msg_s # Imprime mensagem
li $v0, 4
syscall

li $v0, 1 # Imprime valor
move $a0, $s6
syscall


# Encerra programa
li $v0, 10
syscall

#*******************************************************
ler_valor:
li   $v0, 4 # Mostra msg
syscall
li   $v0, 5 # lê inteiro
syscall

jr $ra # Volta para o main
#*******************************************************
negar:
xori $v0, $a0, 0000000000000001 # Nega

jr $ra # Volta para o main
#********************************************************
soma:
or $v0, $a0, $a1
or $v0, $v0, $a2
jr $ra # Volta para o main
#********************************************************
multiplica:
and $v0, $a0, $a1

jr $ra # Volta para o main
