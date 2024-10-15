# Programa que calcula el promedio de un estudiante y determina si aprobo o no

def CalcularPromedio(notas):
    suma = 0
    for i in range(len(notas)):
        suma += notas[i]

    promedio = suma / len(notas)

    return promedio

def Aprobado(promedio):
    if promedio >= 4.0:
        return True
    else:
        return False

def MostrarResultado(nombre, promedio, aprobado):
    print ("El estudiante ", nombre, " tiene un promedio de ", round(promedio, 1))
    if aprobado:
        print ("El estudiante ", nombre, " ha aprobado")
    else:
        print ("El estudiante ", nombre, " ha reprobado")

while (True):
    print ("Ingrese el nombre del estudiante: ")
    nombre = input()

    print ("Ingrese el numero de notas a evaluar: ")
    n = int(input())

    notas = []

    for i in range(n):
        print ("Ingrese la nota ", i+1, ":")
        nota = float(input())
        notas.append(nota)

    promedio = CalcularPromedio(notas)

    MostrarResultado(nombre, promedio, Aprobado(promedio))

    print ("Desea evaluar otro estudiante? (s/n)")
    respuesta = input()
    if respuesta != 's' or respuesta != 'S':
        break
