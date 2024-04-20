    .data
vector: .byte 54,5,23,65,2,84,16,78,37,97,56,26,48,13,103,18
cad0: .asciiz "Vector: "
cad1: .asciiz " "

    .text
    .globl main
main:
    la a0,vector
    li a1,15
    jal sort
    
    li t0,16
    li t1,0
    la t2,vector
    li a0,4 # Selección del servicio: mostrar una cadena por pantalla
    la a1,cad0 # Apuntamos al inicio de la cadena a imprimir
    ecall # Pedimos el servicio, la cadena se muestra en la pantalla
loop_main:
    ble t0,t1,fin
    lb t3,0(t2)  # v[t1]
    li a0,1 # Selección del servicio: mostrar un entero por pantalla
    mv a1,t3 # Cargamos el valor que queremos mostrar
    ecall # Pedimos el servicio, el entero se muestra en la pantalla
    
    li a0,4 # Selección del servicio: mostrar una cadena por pantalla
    la a1,cad1 # Apuntamos al inicio de la cadena a imprimir
    ecall # Pedimos el servicio, la cadena se muestra en la pantalla
    
    addi t1,t1,1
    addi t2,t2,1
    j loop_main

fin: 
    li a0,10 # Selección del servicio terminar el programa sin error
    ecall # Termina el programa y retorna al sistema operativo
    

# Esta subrutina ordena de menor a mayor un vector.
# Recibe en a0 el puntero a la base del vector y en a1 la cantidad de elementos.
sort:
    # Reservar espacio en la pila
    addi sp, sp, -24     
    
    # Guardar ra y los registros s en la pila
    sw ra, 20(sp)        
    sw s0, 16(sp)
    sw s1, 12(sp)
    sw s2, 8(sp)
    sw s3, 4(sp)
    sw s11, 0(sp)

    mv s0,a0
    mv s11,s0
    mv s1,a1
    li s2,0
    li s3,0
    
 loop1:
    ble s1,s2,retornar_sort
loop2:
    ble s1,s3,end_loop2
    addi a0,s11,0
    addi a1,s11,1
    jal switch
    addi s11,s11,1
    addi s3,s3,1
    j loop2
end_loop2:
    addi s1,s1,-1
    li s3,0
    mv s11,s0
    j loop1
    
retornar_sort:
    # Restaurar los registros s desde la pila
    lw s11, 0(sp)
    lw s3, 4(sp)
    lw s2, 8(sp)
    lw s1, 12(sp)
    lw s0, 16(sp)

    # Restaurar ra desde la pila
    lw ra, 20(sp)
    
    # Ajustar el puntero de pila
    addi sp, sp, 24
    
    jr ra
    
    

# Esta subrutina recibe las direcciones de A y B en a0 y a1 respectivamente    
# La subrutina los compara y los intercambia para retornar siempre con A menor que B.
# Si A menor que B a2 = 1, sino a2 = 0
switch:
    lb t0,0(a0)
    lb t1,0(a1)
    
    ble t0,t1,retornar_switch
    sb t0,0(a1)
    sb t1,0(a0)
retornar_switch:
        jr ra
