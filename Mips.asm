.data
msg_nombre: .asciiz "\nIngrese el nombre del estudiante: "
msg_numnotas: .asciiz "\nIngrese el numero de notas a evaluar: "
msg_nota: .asciiz "\nIngrese la nota: "
msg_prom: .asciiz "\nEl promedio del estudiante es: "
msg_aprob: .asciiz "El estudiante ha aprobado.\n"
msg_reprob: .asciiz "El estudiante ha reprobado.\n"
msg_otra: .asciiz "Desea evaluar otro estudiante? (s/n): "
buffer: .space 20	#espacio para el nombre del estudiante

.text
.globl main

main:
	evaluar_estudiante:		#bucle para multiples estudiantes
		li $v0, 4
		la $a0, msg_nombre	#solicita nombre de estudiante
		syscall
		
		li $v0, 8
		la $a0, buffer		
		li $a1, 20
		syscall
		
		li $v0, 4
		la $a0, msg_numnotas	#solicita numero de notas
		syscall
		
		li $v0, 5
		syscall
		move $t0, $v0		#guarda el numero de notas en $t0
		
		li.s $f0, 0.0		#suma total en $f0 para flotantes
		li $t2, 0		#inicializar contador de notas
		
	leer_notas:
		li $v0, 4
		la $a0, msg_nota	#solicita la nota a ingresar
		syscall
		
		li $v0, 6
		syscall
		mfc1 $t3, $f0
		add $t1, $t1, $t3
		addi $t2, $t2, 1
		
		bne $t2, $t0, leer_notas
		
		