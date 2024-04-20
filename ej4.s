    .data
A: .byte 4
B: .byte 3
cad0: .asciiz "A: "
cad1: .asciiz "\nB: "
cad2: .asciiz "\nMenor: "
cad3: .asciiz "\nA no es menor a B"

    .text
    .globl main
main:
    li a0,4 # Selección del servicio: mostrar una cadena por pantalla
    la a1,cad0 # Apuntamos al inicio de la cadena a imprimir
    ecall # Pedimos el servicio, la cadena se muestra en la pantalla
    
    la s0,A 
    lb s0,0(s0) # Cargamos el primer operando
    li a0,1 # Selección del servicio: mostrar un entero por pantalla
    mv a1,s0 # Cargamos el valor que queremos mostrar
    ecall # Pedimos el servicio, el entero se muestra en la pantalla
    
    li a0,4 # Selección del servicio: mostrar una cadena por pantalla
    la a1,cad1 # Apuntamos al inicio de la cadena a imprimir
    ecall # Pedimos el servicio, la cadena se muestra en la pantalla
    
    la s0,B 
    lb s0,0(s0) # Cargamos el primer operando
    li a0,1 # Selección del servicio: mostrar un entero por pantalla
    mv a1,s0 # Cargamos el valor que queremos mostrar
    ecall # Pedimos el servicio, el entero se muestra en la pantalla
    
    la a0,A
    la a1,B
    
    jal switch
    
    beq a2,zero,no_iguales
    li a0,4 # Selección del servicio: mostrar una cadena por pantalla
    la a1,cad2 # Apuntamos al inicio de la cadena a imprimir
    ecall # Pedimos el servicio, la cadena se muestra en la pantalla
    
    la s0,B
    lb s0,0(s0)  #s0 = B (menor despues del cambio)
    li a0,1 # Selección del servicio: mostrar un entero por pantalla
    mv a1,s0 # Cargamos el valor que queremos mostrar
    ecall # Pedimos el servicio, el entero se muestra en la pantalla
    j fin
no_iguales:
    li a0,4 # Selección del servicio: mostrar una cadena por pantalla
    la a1,cad3 # Apuntamos al inicio de la cadena a imprimir
    ecall # Pedimos el servicio, la cadena se muestra en la pantalla
fin: 
    li a0,10 # Selección del servicio terminar el programa sin error
    ecall # Termina el programa y retorna al sistema operativo




# Esta subrutina recibe las direcciones de A y B en a0 y a1 respectivamente    
# La subrutina los compara y los intercambia para retornar siempre con A menor que B.
# Si A menor que B a2 = 1, sino a2 = 0
switch:
    lb t0,0(a0)
    lb t1,0(a1)
    li a2,0
    
    bgt t0,t1,retornar
    sb t0,0(a1)
    sb t1,0(a0)
    li a2,1
retornar:
    jr ra