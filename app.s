/* .include "funciones.s" */

	.include "funciones.s"
	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 20 
    .equ HALF_HEIGH,    240
    .equ HALF_WIDTH,    320
    
	.equ GPIO_BASE,    0x3f200000
	.equ GPIO_GPFSEL0, 0x00
	.equ GPIO_GPLEV0,  0x34

	.globl main

main:
			
	

	// x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	mov x19,4
	mov x21,SCREEN_WIDTH
	mov x22,SCREEN_HEIGH



	//---------------- MAIN ------------------------------------

	  	movz x10, 0xaa, lsl 16			//color verde
	  	movk x10, 0xff22, lsl 00


      movz x11, 0x00, lsl 16	    //color azul
      movk x11, 0x0000, lsl 00    

			bl fondo

			mov x1,100						//seteo mis x1,x2 TAMAÑO
			mov x2,100
			mov x3,200									//seteo de donde quiero que empieze a dibujar  X3=Y X4=X 
			mov x4,200
			movz x11, 0x00, lsl 16	    //color rojo
      movk x11, 0x0000, lsl 00 
			bl direccion								//calcula el punto donde empieza a dibujar
			bl cuadrado


			mov x1,100						//seteo mis x1,x2 TAMAÑO
			mov x2,100
			mov x3,300									//seteo de donde quiero que empieze a dibujar  X3=Y X4=X 
			mov x4,300
			movz x11, 0x00, lsl 16	    //color rojo
      movk x11, 0x0000, lsl 00 
			bl direccion								//calcula el punto donde empieza a dibujar
			bl cuadrado

//---segunda diagonal

			mov x1,50									//seteo mis x1,x2 TAMAÑO
			mov x2,100
			mov x3,150									//seteo de donde quiero que empieze a dibujar  X3=Y X4=X 
			mov x4,350
			movz x11, 0x00, lsl 16	    //color rojo
      movk x11, 0xffff, lsl 00 
			bl direccion								//calcula el punto donde empieza a dibujar
			bl circulo


			mov x1,100									//seteo mis x1,x2 TAMAÑO
			mov x2,100
			mov x3,300									//seteo de donde quiero que empieze a dibujar  X3=Y X4=X 
			mov x4,50
			movz x11, 0xfA, lsl 16	    //color rojo
      movk x11, 0xffff, lsl 00 
			bl direccion								//calcula el punto donde empieza a dibujar
			bl cuadrado


			mov x1,100									//radio
			mov x3,100									//centro
			mov x4,100		
			movz x11, 0xff, lsl 16	    //color rojo
      movk x11, 0x3333, lsl 00 
			bl direccion
			bl circulo
 
	
			mov x1,50									//radio
			mov x3,100									//centro
			mov x4,100		
			movz x11, 0xff, lsl 16	    //color rojo
      movk x11, 0xaf00, lsl 00 
			bl direccion
			bl circulo

		//-----------------------------------TRIANGULOS--------------------------------------------//

			mov x1,100									//seteo mis x1,x2 TAMAÑO
			mov x2,100
			mov x3,249										//seteo de donde quiero que empieze a dibujar  X3=Y X4=X 
			mov x4,350
			movz x11, 0xff, lsl 16	    //color rojo
      movk x11, 0x0000, lsl 00 
			bl direccion								//calcula el punto donde empieza a dibujar
			bl trianguloa


			mov x1,100									//seteo mis x1,x2 TAMAÑO
			mov x2,100
			mov x3,150										//seteo de donde quiero que empieze a dibujar  X3=Y X4=X 
			mov x4,250
			movz x11, 0x00, lsl 16	    //color rojo
      movk x11, 0xff00, lsl 00 
			bl direccion								//calcula el punto donde empieza a dibujar
			bl triangulob


			mov x1,100									//seteo mis x1,x2 TAMAÑO
			mov x2,100
			mov x3,150										//seteo de donde quiero que empieze a dibujar  X3=Y X4=X 
			mov x4,250
			movz x11, 0x00, lsl 16	    //color rojo
      movk x11, 0x00ff, lsl 00 
			bl direccion								//calcula el punto donde empieza a dibujar
			bl trianguloc


			mov x1,100									//seteo mis x1,x2 TAMAÑO
			mov x2,100
			mov x3,51										//seteo de donde quiero que empieze a dibujar  X3=Y X4=X 
			mov x4,350
			movz x11, 0xff, lsl 16	    //color rojo
      movk x11, 0xffff, lsl 00 
			bl direccion								//calcula el punto donde empieza a dibujar
			bl triangulo



//-----------------------------------------------------FIN-----------------------------------------------//

	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE

	// Atención: se utilizan registros w porque la documentación de broadcom
	// indica que los registros que estamos leyendo y escribiendo son de 32 bits

	// Setea gpios 0 - 9 como lectura
	str wzr, [x9, GPIO_GPFSEL0]

	// Lee el estado de los GPIO 0 - 31
	ldr w10, [x9, GPIO_GPLEV0]

	// And bit a bit mantiene el resultado del bit 2 en w10 (notar 0b... es binario)
	// al inmediato se lo refiere como "máscara" en este caso:
	// - Al hacer AND revela el estado del bit 2
	// - Al hacer OR "setea" el bit 2 en 1
	// - Al hacer AND con el complemento "limpia" el bit 2 (setea el bit 2 en 0)
	and w11, w10, 0b00000010

	// si w11 es 0 entonces el GPIO 1 estaba liberado
	// de lo contrario será distinto de 0, (en este caso particular 2)
	// significando que el GPIO 1 fue presionado

	//---------------------------------------------------------------
	// Infinite Loop


