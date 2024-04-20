    .data
A: .word 1,2,3,4
B: .word 4,3,2,1
C: .word 0,0,0,0

    .text
    .globl main
main:
    la a0,C
    la a1,A
    la a2,B
    
    jal gemm
    
    fin: li a0,10 # Selección del servicio terminar el programa sin error
         ecall # Termina el programa y retorna al sistema operativo

# General Matrix Multiplication, C = C + A ∗ B
gemm:
    li t0,0
    li t1,0
    li t2,0
    li t3,2
    mv a4,a2
    
for1:
    ble t3,t0,end_for1
for2:
    ble t3,t1,end_for2
for3:
    ble t3,t2,end_for3
    
    lw t4,0(a0)
    lw t5,0(a1)
    lw t6,0(a2)
    mul t5,t5,t6
    add t4,t4,t5
    sw t4,0(a0)
    
    addi t2,t2,1
    addi a1,a1,4
    ble t3,t2,for3
    li t4,4
    mul t4,t4,t3
    add a2,a2,t4
        

    j for3
end_for3:
    li t4,4
    mul t4,t4,t3
    sub a1,a1,t4
    addi t5,t3,-1
    mul t4,t4,t5
    sub a2,a2,t4
    li t2,0
    addi a0,a0,4
    addi a2,a2,4
    addi t1,t1,1
    j for2
end_for2:
    li t4,4
    mul t4,t4,t3
    add a1,a1,t4
    mv a2,a4
    li t1,0
    addi t0,t0,1
    j for1
end_for1:
    jr ra
