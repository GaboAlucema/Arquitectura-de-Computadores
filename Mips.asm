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
	evaluar_estudiante:			# bucle para multiples estudiantes
		li $v0, 4
		la $a0, msg_nombre		# solicita nombre de estudiante
		syscall
		
		li $v0, 8				# codigo 8 para leer cadena de caracteres
		la $a0, buffer			# donde se almacena la cadena 
		li $a1, 20				# limite de caracteres
		syscall
		
		li $v0, 4
		la $a0, msg_numnotas	# solicita numero de notas
		syscall
		
		li $v0, 5				# codigo para leer enteros y guardarlos en $v0
		syscall
		move $t0, $v0			# guarda el numero de notas en $t0
		
		li.s $f1, 0.0			# inicializar suma total de notas en $f1 para flotantes
		li $t2, 0				# inicializar contador de notas
		
	leer_notas:
		li $v0, 4
		la $a0, msg_nota		# solicita la nota a ingresar
		syscall
		
		li $v0, 6				# codigo para leer flotantes y guardar en $f0
		syscall
		add.s $f1, $f1, $f0		# $f1 = $f1 + $f0
		addi $t2, $t2, 1		# $t2 = $t2 + 1
		
		bne $t2, $t0, leer_notas	# si $t2 != $t0 salta a leer_notas, sino sigue el codigo

	calcular_prom:
		mtc1 $t0, $f2			# convierte $t0 en float y lo guarda en $t2
		div.s $f3, $f1, $f2		# $f3 = $f1 / $f2

		li $v0, 4
		la $a0, msg_prom
		syscall

		li $v0, 2				# codigo para escribir un float almacenado en $f12
		mov.s $f12, $f3			# mueve el promedio $f3 en $f12
		syscall
	
	verificar:
		l.s $f5, 4.0			# revisar en MARS (li.s o l.s) para li de floats
		c.ls.s $f3, $f5			# compara entre flotantes si $f3 es menor a $f5
		bc1t reprobar			# si la comparacion anterior es true salta a reprobar

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
		la $a0, msg_otra
		syscall

		li $v0, 12			# codigo para leer un caracter y lo almacena en $v0
		syscall
		beq $v0, 's', evaluar_estudiante 	# si $v0 es igual a 's', salta a evaluar_estudiante

	li $v0, 10			# codigo para salir de un programa
	syscall