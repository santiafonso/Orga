	/* .include "funciones.s" */
.ifndef data_s
.equ data_s, 0
	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 20 
    .equ HALF_HEIGH,    240
    .equ HALF_WIDTH,    320

  	.equ GPIO_BASE,    0x3f200000
	.equ GPIO_GPFSEL0, 0x00
	.equ GPIO_GPLEV0,  0x34

   

//--------------------------------------------------------DIRECCION--------------------------------------------------------------//

 direccion:

sub sp,sp, #16  //elimino mis 2 ultimos elementos de la pila
str x3,[sp,#0]	//guardo x3 y x4
str x4,[sp,#8]



		mov x21,SCREEN_WIDTH
		mov x13,xzr  				//auxiliar
		mov x0,x20					//seteo x0 al principio asi me muevo hasta las coordenadas deseadas
		madd x13,x3,x21,x4	// mi x3 y x4 son las coordenadas que deseo para ello utilizo la formula x13=x4+x3*640 siendo x3=a mi coordenada Y x21=ancho de pantalla x4=cooredana x 
		lsl x13,x13,2				//multiplico mi auxiliar por 4 para pasarlo a bits
		add x0,x0,x13				//cargo en x0 mi valor auxiliar o el punto donde empiezo a dibujar

ldr x4,[sp,#8]  				//cargo x3 y x4 a sus valores originales y decremento la pila en 2 
ldr x3, [sp,#0] 
add sp,sp, #16  

	ret

//--------------------------------------------------------FIN-DIRECCION--------------------------------------------------------------//


//--------------------------------------------------------FONDO--------------------------------------------------------------//

fondo:

    mov x2, x22         // Y Size

loop1:

    mov x1, x21        // X Size

loop0:

    stur w10,[x0]  // Colorear el pixel N
    add x0,x0,4    // Siguiente pixel
    sub x1,x1,1    // Decrementar contador X
   
	  cbnz x1,loop0  // Si no terminó la fila, salto
    sub x2,x2,1    // Decrementar contador Y
    cbnz x2,loop1  // Si no es la última fila, salto
		mov x0,x20
	
ret

//--------------------------------------------------------FIN-FONDO--------------------------------------------------------------//

//--------------------------------------------------------CUADRADO--------------------------------------------------------------//		

cuadrado:

	  mov x14, x2         // salvo Y Size

loop4:

    mov x15, x1         // salvo X Size

loop3:

    stur w11,[x0]  		// Colorear el pixel N
    add x0,x0,4  		 // Siguiente pixel
    sub x15,x15,1    // Decrementar contador X
    cbnz x15,loop3 	 // Si no terminó la fila, salto
		
		sub x14,x14,1   		// Decrementar contador Y
		msub x0,x19,x1,x0		//vuelvo al princio de la linea que estoy pintado x0=x0-x1*4
		madd x0,x21,x19,x0  //x0=x0+640*4
	  cbnz x14,loop4  		// Si no es la última fila, saltostur w11,[x20]
		mov x0,x20
ret

//--------------------------------------------------------FIN-CUADRADO--------------------------------------------------------------//

//--------------------------------------------------------TRIANGULO-RECTANGULO-1--------------------------------------------------------------//

triangulo:
		mov x17,xzr
		mov x16,xzr
	  mov x14, x2        		// salvo Y Size

loop5:

    mov x15, x1         	// salvo X Size
		sub x15,x15,x16

loop6:

    stur w11,[x0] 				// Colorear el pixel N
    add x0,x0,4   				// Siguiente pixel
    sub x15,x15,1    			// Decrementar contador X
    cbnz x15,loop6  			// Si no terminó la fila, salto
		
		sub x14,x14,1    			// Decrementar contador Y
		msub x0,x19,x1,x0			//vuelvo al princio de la linea que estoy pintado x0=x0-x1*4
		madd x0,x21,x19,x0  	//x0=x0+640*4
		add x16,x16,1
	  mul x17,x16,x19
		add x0,x0,x17
	  cbnz x14,loop5  			// Si no es la última fila, saltostur w11,[x20]

		mov x0,x20
ret


//--------------------------------------------------------FIN-TRIANGULO-RECTANGULO-1---------------------------------------------------------------//


//--------------------------------------------------------TRIANGULO-RECTANGULO-2--------------------------------------------------------------//

trianguloa:
		mov x17,xzr
		mov x16,xzr
	  mov x14, x2        		// salvo Y Size

loop5a:

    mov x15, x1         	// salvo X Size
		sub x15,x15,x16

loop6a:

    stur w11,[x0] 				// Colorear el pixel N
    add x0,x0,4   				// Siguiente pixel
    sub x15,x15,1    			// Decrementar contador X
    cbnz x15,loop6a  			// Si no terminó la fila, salto
		
		sub x14,x14,1    			// Decrementar contador Y
		msub x0,x19,x1,x0			//vuelvo al princio de la linea que estoy pintado x0=x0-x1*4
		msub x0,x21,x19,x0  	//x0=x0+640*4
		add x16,x16,1
	  mul x17,x16,x19
		add x0,x0,x17
	  cbnz x14,loop5a  			// Si no es la última fila, saltostur w11,[x20]

		mov x0,x20
ret


//--------------------------------------------------------FIN-TRIANGULO-RECTANGULO-2--------------------------------------------------------------//

//--------------------------------------------------------TRIANGULO-RECTANGULO-3--------------------------------------------------------------//

triangulob:
		mov x17,xzr
		mov x16,x1
	  mov x14, x2        		// salvo Y Size
		mov x18,1
loop5b:

    mov x15, x18         	// salvo X Size

loop6b:

    stur w11,[x0] 				// Colorear el pixel N
    add x0,x0,4   				// Siguiente pixel
    sub x15,x15,1    			// Decrementar contador X
    cbnz x15,loop6b  			// Si no terminó la fila, salto
		
		sub x14,x14,1    			// Decrementar contador Y
		msub x0,x19,x18,x0			//vuelvo al princio de la linea que estoy pintado x0=x0-x1*4
		madd x0,x21,x19,x0  	//x0=x0+640*4
		add x18,x18,1
	  
	  cbnz x14,loop5b  			// Si no es la última fila, saltostur w11,[x20]

		mov x0,x20
ret


//--------------------------------------------------------FIN-TRIANGULO-RECTANGULO-3--------------------------------------------------------------//

//--------------------------------------------------------TRIANGULO-RECTANGULO-4--------------------------------------------------------------//

trianguloc:
		mov x17,xzr
		mov x16,x1
	  mov x14, x2        		// salvo Y Size
		mov x18,1
loop5c:

    mov x15, x18         	// salvo X Size

loop6c:

    stur w11,[x0] 				// Colorear el pixel N
    add x0,x0,4   				// Siguiente pixel
    sub x15,x15,1    			// Decrementar contador X
    cbnz x15,loop6c  			// Si no terminó la fila, salto
		
		sub x14,x14,1    			// Decrementar contador Y
		msub x0,x19,x18,x0			//vuelvo al princio de la linea que estoy pintado x0=x0-x1*4
		msub x0,x21,x19,x0  	//x0=x0+640*4
		add x18,x18,1
	  
	  cbnz x14,loop5c  			// Si no es la última fila, saltostur w11,[x20]

		mov x0,x20
ret


//--------------------------------------------------------FIN-TRIANGULO-RECTANGULO-4--------------------------------------------------------------//

//--------------------------------------------------------CIRCULO--------------------------------------------------------------//
	circulo:				//x14=X0  x15=Y0	x16=X1 x17=Y1		x23=Xsize x24=Ysize
			mov x14,xzr
			mov x15,xzr
			mov x16,xzr
			mov x17,xzr
			mov x23,xzr
			mov x24,xzr
			mov x25,xzr
			mov x26,xzr
			mov x14,x4		//guardo mis coordenadas del centro
			mov x15,x3


			sub x16,x4,x1	//x16 y x17 tienen mis coordenadas del incio del cuadrado
			sub x17,x3,x1
			sub sp,sp, #8  //elimino mis 2 ultimos elementos de la pila
			str x30,[sp,#0]	//guardo x3 y x4



			
			//"pinto el cuadrado dependiendo si cumple las condiciones" de aca en adelante es muy parecido a la funcion cuadrado solo que pregunto si cumple la condicion de calculo para pintar el pixel
			lsl x24,x1,1		//Ysize

			loop7:
			mov x4,x16
			mov x3,x17



			bl direccion

			lsl x23,x1,1		//Xsize

			loop8:

			bl calculo				//hago los calculos necesarios con pitagora para ver si la hipotenusa geenerada por la linea entre el centro del circulo y el pixel que estoy viendo 
			b.le colorear			//coloreo el circulo
			bl direccion			//calculo la direccion de mi x0
			siguiente:	
   		add x0,x0,4  			// Siguiente pixel
			add x16,x16,1			//siguiente coordenada en x
    	sub x23,x23,1  	  // Decrementar contador de mi diametro
		
    	cbnz x23,loop8 		// Si no terminó la fila, salto
		
			sub x24,x24,1   		// Decrementar contador Y
			add x17,x17,1				//siguiente pixel en Y
			sub x16,x14,x1 			//pongo devuelta mi coordenadad de x En 0
			msub x0,x19,x1,x0		//vuelvo al princio de la linea que estoy pintado x0=x0-x1*4
			madd x0,x21,x19,x0  //x0=x0+640*4
	  	cbnz x24,loop7  		// Si no es la última fila, saltostur w11,[x20]


			ldr x30,[sp,#0]  				//cargo x3 y x4 a sus valores originales y decremento la pila en 2  
			add sp,sp, #8 


			ret

			colorear:
			stur w11,[x0]  		// Colorear el pixel N
			b siguiente				//sigo viendo mis demas pixeles

			calculo:						
			//x25 x26 x27 auxiliares
		 	mov x25,x16			//salvo mis x1 y1
		 	mov x26,x17
			

			sub x25,x25,x14		// x25=x1-x0
			mul x25,x25,x25		//x25=x25 al cuadrado
			sub x26,x26,x15		//x26=y1-y0
			mul x26,x26,x26		//x26=x26 al cuadrado

			add x25,x26,x25		//x25=x26+x25
			mov x26,x1				//x26 ahora es el radio

			mul x26,x26,x26		//x26 es radio cuadrado
			cmp x25,x26		//x25 = x25 - diametro

			b.gt siguiente		//si mi radio cuadrado en mayor extricto que mi x25 NO pinto ese pixel
			b colorear				//si es menor lo pinto
		
//--------------------------------------------------------FIN-CIRCULO--------------------------------------------------------------//


.endif
  