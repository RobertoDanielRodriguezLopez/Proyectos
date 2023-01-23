class Jarra():
    def __init__(self, cap):
        self.__elemento_agua = '*'
        self.__elemento_vacio = ' '
        self.__capacidad = cap
        self.__lista = []
        i = 0
        while(i < cap):
            self.__lista.append(self.__elemento_vacio)
            i+=1

    def vaciar(self):
        i = 0
        while(i < self.__capacidad):
            self.__lista[i] = self.__elemento_vacio
            i+=1
    
    def llenar(self):
        i = 0
        while(i < self.__capacidad):
            self.__lista[i] = self.__elemento_agua
            i+=1

    def mostrarJarra(self):
        print('Jarra de', self.__capacidad, 'litros:')
        for e in self.__lista:
            print('|',e,'|')
        print('-----')

    def cantidadLitros(self):
        cantidad = 0
        for e in self.__lista:
            if(e == self.__elemento_agua):
                cantidad+=1
        return cantidad

    def quitarLitros(self, litros):
        i = 0
        encontrado = False
        while(not encontrado):
            if (self.__lista[i] == self.__elemento_agua):
                encontrado = True
            i+=1
        i-=1
        while(litros > 0):
            self.__lista[i] = self.__elemento_vacio
            i+=1
            litros-=1

    def agregarLitros(self, litros):
        i = 0
        while((i < self.__capacidad) and (self.__lista[i] == self.__elemento_vacio)):
            i+=1
        while(litros > 0):
            i-=1
            self.__lista[i] = self.__elemento_agua
            litros-=1
    
class JuegoJarras():
    def __init__(self):
        self.__j3L = Jarra(3)
        self.__j5L = Jarra(5)
        self.__opciones_validas = ['1','2','3','4','5','6','7']

    def jugar(self):
        nro = 0
        counter = 0
        while(nro < 7):
            print('Juego de las Jarras!:')
            print('*********************')
            print('1 - Llenar jarra de 3L')
            print('2 - Llenar jarra de 5L')
            print('3 - Vaciar jarra de 3L')
            print('4 - Vaciar jarra de 5L')
            print('5 - Verter el contenido de jarra de 3L en la jarra de 5L')
            print('6 - Verter el contenido de jarra de 5L en la jarra de 3L')
            print('7 - Salir')
            print('****************')
            self.__j3L.mostrarJarra()
            self.__j5L.mostrarJarra()
            print('****************')
            nro = input('Por favor, ingrese una opción:')
            counter +=1
            if (nro not in self.__opciones_validas):
                nro = 0
            else:
                nro = int(nro)
            if (nro == 1):
                self.__j3L.llenar()
            elif (nro == 2):
                self.__j5L.llenar()
            elif (nro == 3):
                self.__j3L.vaciar()
            elif (nro == 4):
                self.__j5L.vaciar()
            elif (nro == 5):
                jarra3L = self.__j3L.cantidadLitros()
                jarra5L = self.__j5L.cantidadLitros()
                dispJarra5L = 5 - jarra5L
                if (dispJarra5L < jarra3L):
                    intercambio = dispJarra5L
                else:
                    intercambio = jarra3L
                self.__j3L.quitarLitros(intercambio)
                self.__j5L.agregarLitros(intercambio)
            elif (nro == 6):
                jarra3L = self.__j3L.cantidadLitros()
                jarra5L = self.__j5L.cantidadLitros()
                dispJarra3L = 3 - jarra3L
                if (dispJarra3L < jarra5L):
                    intercambio = dispJarra3L
                else:
                    intercambio = jarra5L
                self.__j5L.quitarLitros(intercambio)
                self.__j3L.agregarLitros(intercambio)

            if(self.__j5L.cantidadLitros() == 4):
                print(f'Felicitaciones! Tu puntaje es {100 - counter * 10}:')
                print('****************')
                self.__j3L.mostrarJarra()
                self.__j5L.mostrarJarra()
                print('****************')
                print('1 - Jugar de nuevo')
                print('2 - Terminar')
                nro = input('Por favor, ingrese una opción:')
                if (nro not in self.__opciones_validas):
                    nro = 0
                else:
                    nro = int(nro)
                    if (nro == 1):
                        self.__j3L.vaciar()
                        self.__j5L.vaciar()
                    elif (nro == 2):
                        nro = 7
        

j = JuegoJarras()
j.jugar()