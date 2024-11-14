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
	evaluar_estudiante:			#bucle para multiples estudiantes
		li $v0, 4
		la $a0, msg_nombre		#solicita nombre de estudiante
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
		move $t0, $v0			#guarda el numero de notas en $t0
		
		li.s $f1, 0.0			# inicializar suma total en $f1 para flotantes
		li $t2, 0				#inicializar contador de notas
		
	leer_notas:
		li $v0, 4
		la $a0, msg_nota		#solicita la nota a ingresar
		syscall
		
		li $v0, 6
		syscall
		add.s $f1, $f1, $f0
		addi $t2, $t2, 1
		
		bne $t2, $t0, leer_notas

	calcular_prom:
		mtc1 $t0, $f2
		div.s $f3, $f1, $f2

		li $v0, 4
		la $a0, msg_prom
		syscall

		li $v0, 2
		mov.s $f12, $f3
		syscall
	
	verificar:
		l.s $f5, 4.0			#revisar en MARS (li.s o l.s)
		c.ls.s $f3, $f5
		bc1t reprobar

	aprobar:
		li $v0, 4
		la $a0, msg_aprob
		syscall
		j otra_eva

	reprobar:
		li $v0, 4
		la $a0, msg_reprob
		syscall
		j otra_eva

	otra_eva:
		li $v0, 4
		la $a, msg_otra
		syscall

		li $v0, 12
		syscall
		beq $v0, 's', evaluar_estudiante 

	li $v0, 10
	syscall