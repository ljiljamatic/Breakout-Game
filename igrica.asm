; ---- Zadatak 13: Napisati asm program koji crta lopticu (kvadrat) koja se krece po ekranu

; ---- Data segment
dseg segment 'DATA'
	TIME_AUX DB 0 ; vremenska promenljiva 
	BALL_X DW 0 ; X pozicija (kolona) lopte
	BALL_Y DW 135 ; Y pozicija (linija) lopte
	BALL_SIZE DW 04h ; velicina lopte (koliko piksela u sirinu i u visinu)
	BALL_VELOCITY_X DW 05h ; x (horizontalna) komponenta brzine
	BALL_VELOCITY_Y DW 02h ; Y (vertikalna) komponenta brzine
    POINTS DW 0
	
	BLOCK1_X DW 30 ; X pozicija prvog bloka
	BLOCK2_X DW 102 ; X pozicija drugog bloka
	BLOCK3_X DW 172 ; X pozicija treceg bloka
	BLOCK4_X DW 242; X pozicija cetvrtog bloka
	BLOCK_ROW1_Y DW 5; Y pozicija prvog reda

	BLOCK5_X DW 30 ; X pozicija petog bloka
	BLOCK6_X DW 102; X pozicija sestog bloka
	BLOCK7_X DW 172 ; X pozicija sedmog bloka
	BLOCK8_X DW 242; X pozicija osmog bloka
	BLOCK_ROW2_Y DW 23; Y pozicija drugog reda
	
	BLOCK9_X DW 30 ; X pozicija devetog bloka
	BLOCK10_X DW 102 ; X pozicija desetog bloka
	BLOCK11_X DW 172 ; X pozicija jedanaestog bloka
	BLOCK12_X DW 242; X pozicija dvanaestog bloka
	BLOCK_ROW3_Y DW 41; Y pozicija treceg reda
	
	BLOCK_WIDTH DW 50 ; koliko piksela u sirinu bloka
        BLOCK_HEIGHT DW 9 ; koliko piksela u visinu bloka

	PLATFORM_WIDTH DW 66
        PLATFORM_HEIGHT DW 9
	PLATFORM_X DW 136
	PLATFORM_Y DW 193
	
	WINDOW_WIDTH DW 140h   ; sirina prozora (320 px)
	WINDOW_HEIGHT DW 0C8h  ;visina prozora (200 px)
	WINDOW_BOUNDS DW 0     ; promenljiva pomocu koje mozemo izvrsiti ranu detekciju sudara
	
	CHECK1 DW 0h ; provera da li je doslo do udara loptice o bloka O-NIJE 1-JESTE
	CHECK2 DW 0h
	CHECK3 DW 0h
	CHECK4 DW 0h
	CHECK5 DW 0h
	CHECK6 DW 0h
	CHECK7 DW 0h
	CHECK8 DW 0h
	CHECK9 DW 0h
	CHECK10 DW 0h
	CHECK11 DW 0h
	CHECK12 DW 0h
	
	BOJA DW 0h
	GOTOVO DB 'GAME OVER(press -> to exit)'
	WON DB 'YOU WON(press -> to exit)'
dseg ends
; ---- kraj segmenta


; ---- Code segment

cseg	segment	'CODE'
		assume cs:cseg, ds:dseg, ss:sseg
draw:	mov ax, dseg
        mov ds, ax
		
	CHECK_TIME:
	
		mov ah,2Ch ; prekid kojim se dobija sistemsko vreme
		int 21h    ; CH = sati, CL = minuti, DH = sekunde, DL = stotinke
		
		cmp dl,TIME_AUX  ; da li je trenutno vreme jednako prethodnom (TIME_AUX)?
		je CHECK_TIME    ; ako je isto, proveri ponovo; inace ucrtaj loptu, pomeri je....
		
		mov TIME_AUX,dl ; azuriraj vreme
		
		;da li su svi unisteni
		cmp CHECK1,1
		jne programm
		cmp CHECK2,1
		jne programm
		cmp CHECK3,1
		jne programm
		cmp CHECK4,1
		jne programm
		cmp CHECK5,1
		jne programm
		cmp CHECK6,1
		jne programm
		cmp CHECK7,1
		jne programm
		cmp CHECK8,1
		jne programm
		cmp CHECK9,1
		jne programm
		cmp CHECK10,1
		jne programm
		cmp CHECK11,1
		jne programm
		cmp CHECK12,1
		jne programm
		   mov ah,00h ; postaviti konfiguraciju za video mod
		   mov al,13h ;
		   int 10h    ; izvrsi konfiguraciju
		
		   mov ah,0bh ; postavi konfiguraciju  za boju pozadine
		   mov bh,00h ;
		   mov bl,00h ; boja pozadine = crna
		   int 10h    ; izvrsi konfiguraciju
			
		   mov ax,1300h
		   mov bh,00h
		   mov bl,0fh ;boja
		   mov cx,25 ;duzina
		   mov dl,120 ;x
		   mov dh,20 ;y
		   push ds
		   pop es
		   lea bp,WON ;ispise WON
		   int 10h
p:         mov ah, 00h
           int 16h
		   cmp ah,4Dh ;PROGRAM POSLE ISPISA YOU WON ZAVRSIM KAD KLIKNEM DESNU STRELICU
		   jne p
		   call kraj
		programm:
		
		call CLEAR_SCREEN ; obrisi sadrzaj ekrana
		call MOVE_BALL ; pomeri loptu
		call DRAW_BALL  ; ucrtaj  je
		call DRAW_PLATFORM ;  ucrtaj platformu
		call MOVE_PLATFORM ;  pomeri platformu
		
		mov ax,CHECK1 ;  ispitivanje koji blok je udaren
		cmp ax,0h
		jne no1
		call DRAW_BLOCK1
no1:
        mov ax,CHECK2
		cmp ax,0h
		jne no2
		call DRAW_BLOCK2
no2:    
        mov ax,CHECK3
		cmp ax,0h
		jne no3
		call DRAW_BLOCK3
no3:	
        mov ax,CHECK4
		cmp ax,0h
		jne no4
		call DRAW_BLOCK4
no4:    
        mov ax,CHECK5
		cmp ax,0h
		jne no5
		call DRAW_BLOCK5
no5:	
        mov ax,CHECK6
		cmp ax,0h
		jne no6
		call DRAW_BLOCK6
no6:    
        mov ax,CHECK7
		cmp ax,0h
		jne no7
		call DRAW_BLOCK7
no7:	
        mov ax,CHECK8
		cmp ax,0h
		jne no8
		call DRAW_BLOCK8
no8:    
        mov ax,CHECK9
		cmp ax,0h
		jne no9
		call DRAW_BLOCK9
no9:    
        mov ax,CHECK10
		cmp ax,0h
		jne no10
		call DRAW_BLOCK10
no10:	
        mov ax,CHECK11
		cmp ax,0h
		jne no11
		call DRAW_BLOCK11
no11:   
        mov ax,CHECK12
		cmp ax,0h
		jne no12
		call DRAW_BLOCK12
no12:	
        jmp CHECK_TIME ; proveri vreme ponovo
	jmp kraj
	
	
		MOVE_BALL PROC NEAR
		
		mov ax,BALL_VELOCITY_X    
		add BALL_X,ax             ; pomeri lopticu horizontalno
		
		mov ax,WINDOW_BOUNDS
		cmp BALL_X,ax                         
		jnl negg	; BALL_X < 0 + WINDOW_BOUNDS (sudar - leva ivica)
		mov BOJA,1h
        call NEG_VELOCITY_X 	
	
negg:	mov ax,WINDOW_WIDTH
		sub ax,BALL_SIZE
		sub ax,WINDOW_BOUNDS
		cmp BALL_X,ax
        jng negg1		;BALL_X > WINDOW_WIDTH - BALL_SIZE  - WINDOW_BOUNDS (sudar - desna ivica)
		mov BOJA,2h
		call NEG_VELOCITY_X
		
negg1:	mov ax,BALL_VELOCITY_Y
		add BALL_Y,ax             ; pomeri lopticu vertikalno
		
			;------PROVERA BLOKOVA POCETAK
blok1:		cmp CHECK1,1h
			je blok2
            mov ax,BLOCK1_X
			sub ax,BALL_SIZE
			cmp BALL_X,ax
			jg next1
			jng blok2
next1:      mov ax,BLOCK1_X
			add ax,BLOCK_WIDTH
			cmp BALL_X,ax
			jl next2
			jnl blok2
next2:      mov ax,BLOCK_ROW1_Y
			sub ax,BALL_SIZE
			cmp BALL_Y,ax
			jg next3
			jng blok2
next3:      mov ax,BLOCK_ROW1_Y
			add ax,BLOCK_HEIGHT
			cmp BALL_Y,ax
			jl next4
			jnl blok2
next4:      mov CHECK1, 1h 
            inc POINTS
			inc POINTS
			inc POINTS
blok2:		cmp CHECK2,1h
			je blok3
            mov ax,BLOCK2_X
			sub ax,BALL_SIZE
			cmp BALL_X,ax
			jg next5
			jng blok3
next5:      mov ax,BLOCK2_X
			add ax,BLOCK_WIDTH
			cmp BALL_X,ax
			jl next6
			jnl blok3
next6:      mov ax,BLOCK_ROW1_Y
			sub ax,BALL_SIZE
			cmp BALL_Y,ax
			jg next7
			jng blok3
next7:      mov ax,BLOCK_ROW1_Y
			add ax,BLOCK_HEIGHT
			cmp BALL_Y,ax
			jl next8
			jnl blok3
next8:      mov CHECK2, 1h
            inc POINTS
			inc POINTS
			inc POINTS
blok3:		cmp CHECK3,1h
			je blok4
            mov ax,BLOCK3_X
			sub ax,BALL_SIZE
			cmp BALL_X,ax
			jg next9
			jng blok4
next9:      mov ax,BLOCK3_X
			add ax,BLOCK_WIDTH
			cmp BALL_X,ax
			jl next10
			jnl blok4
next10:     mov ax,BLOCK_ROW1_Y
			sub ax,BALL_SIZE
			cmp BALL_Y,ax
			jg next11
			jng blok4
next11:     mov ax,BLOCK_ROW1_Y
			add ax,BLOCK_HEIGHT
			cmp BALL_Y,ax
			jl next12
			jnl blok4
next12:     mov CHECK3, 1h
            inc POINTS
			inc POINTS
			inc POINTS
blok4:		cmp CHECK4,1h
			je blok5
            mov ax,BLOCK4_X
			sub ax,BALL_SIZE
			cmp BALL_X,ax
			jg next13
			jng blok5
next13:     mov ax,BLOCK4_X
			add ax,BLOCK_WIDTH
			cmp BALL_X,ax
			jl next14
			jnl blok5
next14:     mov ax,BLOCK_ROW1_Y
			sub ax,BALL_SIZE
			cmp BALL_Y,ax
			jg next15
			jng blok5
next15:     mov ax,BLOCK_ROW1_Y
			add ax,BLOCK_HEIGHT
			cmp BALL_Y,ax
			jl next16
			jnl blok5
next16:     mov CHECK4,1h
            inc POINTS
			inc POINTS
			inc POINTS
blok5:		cmp CHECK5,1h
			je blok6
            mov ax,BLOCK5_X
			sub ax,BALL_SIZE
			cmp BALL_X,ax
			jg next17
			jng blok6
next17:     mov ax,BLOCK5_X
			add ax,BLOCK_WIDTH
			cmp BALL_X,ax
			jl next18
			jnl blok6
next18:     mov ax,BLOCK_ROW2_Y
			sub ax,BALL_SIZE
			cmp BALL_Y,ax
			jg next19
			jng blok6
next19:     mov ax,BLOCK_ROW2_Y
			add ax,BLOCK_HEIGHT
			cmp BALL_Y,ax
			jl next20
			jnl blok6
next20:     mov CHECK5,1h
            inc POINTS
			inc POINTS
blok6:		cmp CHECK6,1h
			je blok7
            mov ax,BLOCK6_X
			sub ax,BALL_SIZE
			cmp BALL_X,ax
			jg next21
			jng blok7
next21:     mov ax,BLOCK6_X
			add ax,BLOCK_WIDTH
			cmp BALL_X,ax
			jl next22
			jnl blok7
next22:     mov ax,BLOCK_ROW2_Y
			sub ax,BALL_SIZE
			cmp BALL_Y,ax
			jg next23
			jng blok7
next23:     mov ax,BLOCK_ROW2_Y
			add ax,BLOCK_HEIGHT
			cmp BALL_Y,ax
			jl next24
			jnl blok7
next24:     mov CHECK6, 1h
            inc POINTS
			inc POINTS
blok7:		cmp CHECK7,1h
			je blok8
            mov ax,BLOCK7_X
			sub ax,BALL_SIZE
			cmp BALL_X,ax
			jg next25
			jng blok8
next25:     mov ax,BLOCK7_X
			add ax,BLOCK_WIDTH
			cmp BALL_X,ax
			jl next26
			jnl blok8
next26:     mov ax,BLOCK_ROW2_Y
			sub ax,BALL_SIZE
			cmp BALL_Y,ax
			jg next27
			jng blok8
next27:     mov ax,BLOCK_ROW2_Y
			add ax,BLOCK_HEIGHT
			cmp BALL_Y,ax
			jl next28
			jnl blok8
next28:     mov CHECK7, 1h
            inc POINTS
			inc POINTS
blok8:		cmp CHECK8,1h
			je blok9
            mov ax,BLOCK8_X
			sub ax,BALL_SIZE
			cmp BALL_X,ax
			jg next29
			jng blok9
next29:     mov ax,BLOCK8_X
			add ax,BLOCK_WIDTH
			cmp BALL_X,ax
			jl next30
			jnl blok9
next30:     mov ax,BLOCK_ROW2_Y
			sub ax,BALL_SIZE
			cmp BALL_Y,ax
			jg next31
			jng blok9
next31:     mov ax,BLOCK_ROW2_Y
			add ax,BLOCK_HEIGHT
			cmp BALL_Y,ax
			jl next32
			jnl blok9
next32:     mov CHECK8, 1h
            inc POINTS
			inc POINTS
blok9:		cmp CHECK9,1h
			je blok10
            mov ax,BLOCK9_X
			sub ax,BALL_SIZE
			cmp BALL_X,ax
			jg next33
			jng blok10
next33:     mov ax,BLOCK9_X
			add ax,BLOCK_WIDTH
			cmp BALL_X,ax
			jl next34
			jnl blok10
next34:     mov ax,BLOCK_ROW3_Y
			sub ax,BALL_SIZE
			cmp BALL_Y,ax
			jg next35
			jng blok10
next35:     mov ax,BLOCK_ROW3_Y
			add ax,BLOCK_HEIGHT
			cmp BALL_Y,ax
			jl next36
			jnl blok10
next36:     mov CHECK9, 1h
            inc POINTS
blok10:		cmp CHECK10,1h
			je blok11
            mov ax,BLOCK10_X
			sub ax,BALL_SIZE
			cmp BALL_X,ax
			jg next37
			jng blok11
next37:     mov ax,BLOCK10_X
			add ax,BLOCK_WIDTH
			cmp BALL_X,ax
			jl next38
			jnl blok11
next38:     mov ax,BLOCK_ROW3_Y
			sub ax,BALL_SIZE
			cmp BALL_Y,ax
			jg next39
			jng blok11
next39:     mov ax,BLOCK_ROW3_Y
			add ax,BLOCK_HEIGHT
			cmp BALL_Y,ax
			jl next40
			jnl blok11
next40:     mov CHECK10, 1h
            inc POINTS
blok11:		cmp CHECK11,1h
			je blok12
            mov ax,BLOCK11_X
			sub ax,BALL_SIZE
			cmp BALL_X,ax
			jg next41
			jng blok12
next41:     mov ax,BLOCK11_X
			add ax,BLOCK_WIDTH
			cmp BALL_X,ax
			jl next42
			jnl blok12
next42:     mov ax,BLOCK_ROW3_Y
			sub ax,BALL_SIZE
			cmp BALL_Y,ax
			jg next43
			jng blok12
next43:     mov ax,BLOCK_ROW3_Y
			add ax,BLOCK_HEIGHT
			cmp BALL_Y,ax
			jl next44
			jnl blok12
next44:     mov CHECK11, 1h
            inc POINTS
blok12:		cmp CHECK12,1h
			je blok
            mov ax,BLOCK12_X
			sub ax,BALL_SIZE
			cmp BALL_X,ax
			jg next45
			jng blok
next45:     mov ax,BLOCK12_X
			add ax,BLOCK_WIDTH
			cmp BALL_X,ax
			jl next46
			jnl blok
next46:     mov ax,BLOCK_ROW3_Y
			sub ax,BALL_SIZE
			cmp BALL_Y,ax
			jg next47
			jng blok
next47:     mov ax,BLOCK_ROW3_Y
			add ax,BLOCK_HEIGHT
			cmp BALL_Y,ax
			jl next48
			jnl blok
next48:     mov CHECK12, 1h
            inc POINTS
blok:
		;------PROVERA BLOKOVA KRAJ

		mov ax,WINDOW_BOUNDS
		cmp BALL_Y,ax   		;BALL_Y < 0 + WINDOW_BOUNDS (sudar - gornja ivica)
		jnl w
		mov BOJA,3h
		call NEG_VELOCITY_Y   
     
		
w:		mov ax,WINDOW_HEIGHT	
		sub ax,BALL_SIZE
		sub ax,WINDOW_BOUNDS
		cmp BALL_Y,ax
		jng bocno
		CALL GAME_OVER

bocno:
		mov ax, PLATFORM_X ;BOCNE IVICE,ODBIJANJE PO X
		sub ax, BALL_SIZE
		cmp BALL_X,ax
		jl nastavi
		mov ax, PLATFORM_X
		add ax, PLATFORM_WIDTH
		cmp BALL_X, ax
		jg nastavi
		mov ax, PLATFORM_Y
		add ax, PLATFORM_HEIGHT
		sub ax,1
		cmp BALL_Y,ax
		jg nastavi
		mov ax, PLATFORM_Y
		add ax, 1
		cmp BALL_Y,ax
		jl nastavi
		call NEG_VELOCITY_X
		nastavi:
		
		
prov:   mov ax,PLATFORM_Y
		sub ax,BALL_SIZE
		cmp BALL_Y,ax
		jg label1
		ret
		
label1:	mov ax,PLATFORM_X
		sub ax,BALL_SIZE
		cmp BALL_X,ax
		jg label2
		ret
		
label2:	mov ax,PLATFORM_X
		add ax,PLATFORM_WIDTH
		cmp BALL_X,ax
		jl NEG_VELOCITY_Y
		ret

		
		NEG_VELOCITY_X:
			neg BALL_VELOCITY_X   ;BALL_VELOCITY_X = - BALL_VELOCITY_X
			ret
			
		NEG_VELOCITY_Y:
			neg BALL_VELOCITY_Y   ;BALL_VELOCITY_Y = - BALL_VELOCITY_Y
			ret
		GAME_OVER:
		   mov ah,00h ; postaviti konfiguraciju za video mod
		   mov al,13h ;
		   int 10h    ; izvrsi konfiguraciju
		
		   mov ah,0bh ; postavi konfiguraciju  za boju pozadine
		   mov bh,00h ;
		   mov bl,00h ; boja pozadine = crna
		   int 10h    ; izvrsi konfiguraciju
			
		   mov ax,1300h
		   mov bh,00h
		   mov bl,0fh ;boja
		   mov cx,27 ;duzina
		   mov dl,120 ;x
		   mov dh,20 ;y
		   push ds
		   pop es
		   lea bp,GOTOVO ;ispise game over
		   int 10h
		   
k:		   mov ah, 00h
           int 16h
		   cmp ah,4Dh ;PROGRAM POSLE ISPISA GAME OVER ZAVRSIM KAD KLIKNEM DESNU STRELICU
		   jne k
		   call kraj
		    
	MOVE_BALL ENDP
	
	
	DRAW_BALL PROC NEAR
		
		mov cx,BALL_X ; postavi inicijalnu kolonu (X)
		mov dx,BALL_Y ; postavi inicijalni red (Y)
		
		DRAW_BALL_HORIZONTAL:
			mov ax,BOJA
			cmp ax,0h
			je bela
			cmp ax,1h
			je boja1
			cmp ax,2h
			je boja2
			cmp ax,3h
			je boja3
bela:		mov ah,0Ch ; podesi konfiguraciju za ispis piksela
            mov al,0fh ; izaberi belu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			jmp incc
boja1:		mov ah,0Ch ; podesi konfiguraciju za ispis piksela
            mov al,96h ; izaberi cyan boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			jmp incc
boja2:		mov ah,0Ch ; podesi konfiguraciju za ispis piksela
            mov al,09h ; izaberi belu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			jmp incc	
boja3:		mov ah,0Ch ; podesi konfiguraciju za ispis piksela
            mov al,01h ; izaberi belu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
				
incc:		inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BALL_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BALL_SIZE
			jng DRAW_BALL_HORIZONTAL
			
			mov cx,BALL_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax,BALL_Y
			cmp ax,BALL_SIZE
			jng DRAW_BALL_HORIZONTAL
		
		ret
	DRAW_BALL ENDP
	   
   
    DRAW_BLOCK1 PROC NEAR
		
		mov cx,BLOCK1_X ; postavi inicijalnu kolonu (X)
		mov dx,BLOCK_ROW1_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_BLOCK1_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,04h ; izaberi crvenu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BLOCK1_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BLOCK_WIDTH
			jng DRAW_BLOCK1_HORIZONTAL;
			
			mov cx,BLOCK1_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax, BLOCK_ROW1_Y
			cmp ax, BLOCK_HEIGHT
			jng DRAW_BLOCK1_HORIZONTAL
		
		ret
	DRAW_BLOCK1 ENDP
	
	DRAW_BLOCK2 PROC NEAR
		
		mov cx,BLOCK2_X ; postavi inicijalnu kolonu (X)
		mov dx,BLOCK_ROW1_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_BLOCK2_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,04h ; izaberi crvenu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BLOCK2_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BLOCK_WIDTH
			jng DRAW_BLOCK2_HORIZONTAL;
			
			mov cx,BLOCK2_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax,BLOCK_ROW1_Y
			cmp ax,BLOCK_HEIGHT
			jng DRAW_BLOCK2_HORIZONTAL
		
		ret
	DRAW_BLOCK2 ENDP
	
	DRAW_BLOCK3 PROC NEAR
		
		mov cx,BLOCK3_X ; postavi inicijalnu kolonu (X)
		mov dx,BLOCK_ROW1_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_BLOCK3_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,04h ; izaberi crvenu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BLOCK3_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BLOCK_WIDTH
			jng DRAW_BLOCK3_HORIZONTAL;
			
			mov cx,BLOCK3_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax, BLOCK_ROW1_Y
			cmp ax,BLOCK_HEIGHT
			jng DRAW_BLOCK3_HORIZONTAL
		
		ret
	DRAW_BLOCK3 ENDP
	
	DRAW_BLOCK4 PROC NEAR
		
		mov cx,BLOCK4_X ; postavi inicijalnu kolonu (X)
		mov dx,BLOCK_ROW1_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_BLOCK4_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,04h ; izaberi crvenu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BLOCK4_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BLOCK_WIDTH
			jng DRAW_BLOCK4_HORIZONTAL;
			
			mov cx,BLOCK4_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax, BLOCK_ROW1_Y
			cmp ax,BLOCK_HEIGHT
			jng DRAW_BLOCK4_HORIZONTAL
		
		ret
	DRAW_BLOCK4 ENDP
	
	DRAW_BLOCK5 PROC NEAR
		
		mov cx,BLOCK5_X ; postavi inicijalnu kolonu (X)
		mov dx,BLOCK_ROW2_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_BLOCK5_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,06h ; izaberi zutu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BLOCK5_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BLOCK_WIDTH
			jng DRAW_BLOCK5_HORIZONTAL;
			
			mov cx,BLOCK5_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax, BLOCK_ROW2_Y
			cmp ax,BLOCK_HEIGHT
			jng DRAW_BLOCK5_HORIZONTAL
		
		ret
	DRAW_BLOCK5 ENDP
	
	DRAW_BLOCK6 PROC NEAR
		
		mov cx,BLOCK6_X ; postavi inicijalnu kolonu (X)
		mov dx,BLOCK_ROW2_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_BLOCK6_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,06h ; izaberi zutu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BLOCK6_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BLOCK_WIDTH
			jng DRAW_BLOCK6_HORIZONTAL;
			
			mov cx,BLOCK6_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax, BLOCK_ROW2_Y
			cmp ax,BLOCK_HEIGHT
			jng DRAW_BLOCK6_HORIZONTAL
		
		ret
	DRAW_BLOCK6 ENDP
	
	DRAW_BLOCK7 PROC NEAR
		
		mov cx,BLOCK7_X ; postavi inicijalnu kolonu (X)
		mov dx,BLOCK_ROW2_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_BLOCK7_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,06h ; izaberi zutu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BLOCK7_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BLOCK_WIDTH
			jng DRAW_BLOCK7_HORIZONTAL;
			
			mov cx,BLOCK7_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax, BLOCK_ROW2_Y
			cmp ax,BLOCK_HEIGHT
			jng DRAW_BLOCK7_HORIZONTAL
		
		ret
	DRAW_BLOCK7 ENDP
	
	DRAW_BLOCK8 PROC NEAR
		
		mov cx,BLOCK8_X ; postavi inicijalnu kolonu (X)
		mov dx,BLOCK_ROW2_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_BLOCK8_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,06h ; izaberi zutu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BLOCK8_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BLOCK_WIDTH
			jng DRAW_BLOCK8_HORIZONTAL;
			
			mov cx,BLOCK8_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax, BLOCK_ROW2_Y
			cmp ax,BLOCK_HEIGHT
			jng DRAW_BLOCK8_HORIZONTAL
		
		ret
	DRAW_BLOCK8 ENDP
	
	DRAW_BLOCK9 PROC NEAR
		
		mov cx,BLOCK9_X ; postavi inicijalnu kolonu (X)
		mov dx,BLOCK_ROW3_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_BLOCK9_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,02h ; izaberi zelenu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BLOCK9_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BLOCK_WIDTH
			jng DRAW_BLOCK9_HORIZONTAL;
			
			mov cx,BLOCK9_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax, BLOCK_ROW3_Y
			cmp ax,BLOCK_HEIGHT
			jng DRAW_BLOCK9_HORIZONTAL
		
		ret
	DRAW_BLOCK9 ENDP
	
	DRAW_BLOCK10 PROC NEAR
		
		mov cx,BLOCK10_X ; postavi inicijalnu kolonu (X)
		mov dx,BLOCK_ROW3_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_BLOCK10_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,02h ; izaberi zelenu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BLOCK10_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BLOCK_WIDTH
			jng DRAW_BLOCK10_HORIZONTAL;
			
			mov cx,BLOCK10_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax, BLOCK_ROW3_Y
			cmp ax,BLOCK_HEIGHT
			jng DRAW_BLOCK10_HORIZONTAL
		
		ret
	DRAW_BLOCK10 ENDP
	
	DRAW_BLOCK11 PROC NEAR
		
		mov cx,BLOCK11_X ; postavi inicijalnu kolonu (X)
		mov dx,BLOCK_ROW3_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_BLOCK11_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,02h ; izaberi zelenu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BLOCK11_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BLOCK_WIDTH
			jng DRAW_BLOCK11_HORIZONTAL;
			
			mov cx,BLOCK11_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax, BLOCK_ROW3_Y
			cmp ax,BLOCK_HEIGHT
			jng DRAW_BLOCK11_HORIZONTAL
		
		ret
	DRAW_BLOCK11 ENDP
	
	DRAW_BLOCK12 PROC NEAR
		
		mov cx,BLOCK12_X ; postavi inicijalnu kolonu (X)
		mov dx,BLOCK_ROW3_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_BLOCK12_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,02h ; izaberi zelenu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,BLOCK12_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,BLOCK_WIDTH
			jng DRAW_BLOCK12_HORIZONTAL;
			
			mov cx,BLOCK12_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax, BLOCK_ROW3_Y
			cmp ax,BLOCK_HEIGHT
			jng DRAW_BLOCK12_HORIZONTAL
		
		ret
	DRAW_BLOCK12 ENDP
	
	
	DRAW_PLATFORM PROC NEAR
		mov cx,PLATFORM_X ; postavi inicijalnu kolonu (X)
		mov dx,PLATFORM_Y ; postavi inicijalni red (Y)
		mov bl, 0h;
		DRAW_PLATFORM_HORIZONTAL:
			mov ah,0Ch ; podesi konfiguraciju za ispis piksela
			mov al,01h ; izaberi plavu boju
			mov bh,00h ; 
			int 10h    ; izvrsi konfiguraciju
			
			inc cx     ;cx = cx + 1
			mov ax,cx  
			sub ax,PLATFORM_X ;cx - BALL_X > BALL_SIZE (ako jeste, iscrtali smo za taj red sve kolone; inace nastavljamo dalje)
			cmp ax,PLATFORM_WIDTH
			jng DRAW_PLATFORM_HORIZONTAL;
			
			mov cx,PLATFORM_X ; vrati cx na inicijalnu kolonu
			inc dx        ; idemo u sledeci red
			
			mov ax,dx    ; dx - BALL_Y > BALL_SIZE (ako jeste, iscrtali smo sve redove piksela; inace nastavljamo dalje)
			sub ax, PLATFORM_Y
			cmp ax,PLATFORM_HEIGHT
			jng DRAW_PLATFORM_HORIZONTAL
		
		ret
	DRAW_PLATFORM ENDP

	
	MOVE_PLATFORM PROC NEAR
         	mov ah, 01h
			int 16h
			jz null
            mov ah, 00h
            int 16h
			cmp ah,4Bh
			je left
			cmp ah,4Dh
			je right
			ret
left:   mov ax,PLATFORM_X
        cmp ax,0
		jle got
        dec PLATFORM_X
        dec PLATFORM_X
        dec PLATFORM_X
got: ret
right:  mov ax,PLATFORM_X
        add ax,PLATFORM_WIDTH
		cmp ax,WINDOW_WIDTH
		jge got1
        inc PLATFORM_X
        inc PLATFORM_X
		inc PLATFORM_X
got1: ret	
null:   add PLATFORM_X, 0h
        ret

	MOVE_PLATFORM ENDP
	
	DRAW_POINTS PROC NEAR
	       mov ax,1300h
		   mov bh,00h
		   mov bl,0fh ;boja
		   mov cx,2 ;duzina
		   mov dl,120 ;x
		   mov dh,20 ;y
		   push ds
		   pop es
		   lea bp,POINTS ;ispise poene
		   int 10h
	DRAW_POINTS ENDP
	
    CLEAR_SCREEN PROC NEAR
			mov ah,00h ; postaviti konfiguraciju za video mod
			mov al,13h ;
			int 10h    ; izvrsi konfiguraciju
		
			mov ah,0bh ; postavi konfiguraciju  za boju pozadine
			mov bh,00h ;
			mov bl,00h ; boja pozadine = crna
			int 10h    ; izvrsi konfiguraciju
			mov dl,32
		
		cmp POINTS,0
		jne sledece1
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece1:
		cmp POINTS,1
		jne sledece2
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece2:
		
		cmp POINTS,2
		jne sledece3
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'2'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece3:
		
		cmp POINTS,3
		jne sledece4
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'3'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece4:
		
		cmp POINTS,4
		jne sledece5
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'4'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece5:
		
		cmp POINTS,5
		jne sledece6
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'5'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece6:
		
		cmp POINTS,6
		jne sledece7
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'6'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece7:
		
		cmp POINTS,7
		jne sledece8
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'7'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece8:
		
		cmp POINTS,8
		jne sledece9
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'8'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece9:
		
		cmp POINTS,9
		jne sledece10
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'9'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece10:
		
		cmp POINTS,10
		jne sledece11
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece11:
		
		cmp POINTS,11
		jne sledece12
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece12:
		
		cmp POINTS,12
		jne sledece13
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'2'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece13:
		
		cmp POINTS,13
		jne sledece14
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'3'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece14:
		
		cmp POINTS,14
		jne sledece15
		mov dl,32
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,33
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'4'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece15:
		
		cmp POINTS,15
		jne sledece16
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'5'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece16:
		
		cmp POINTS,16
		jne sledece17
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'6'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece17:
		
		cmp POINTS,17
		jne sledece18
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'7'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece18:
		
		cmp POINTS,18
		jne sledece19
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'8'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece19:
		
		cmp POINTS,19
		jne sledece20
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'9'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece20:
		
		cmp POINTS,20
		jne sledece21
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'2'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'0'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece21:
		
		cmp POINTS,21
		jne sledece22
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'2'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'1'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece22:
		
		cmp POINTS,22
		jne sledece23
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'2'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'2'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece23:
		
		cmp POINTS,23
		jne sledece24
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'2'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'3'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece24:
		
		cmp POINTS,24
		jne sledece25
		mov dl,37
		mov dh,0
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'2'
		mov bh,0
		mov bl,0fh
		int 10h
		mov dl,38
		mov bh,0
		mov ah,02h
		int 10h
		mov ah,0eh
		mov al,'4'
		mov bh,0
		mov bl,0fh
		int 10h
		sledece25:
		ret	

       CLEAR_SCREEN ENDP

kraj:   mov ax, 4c00h		 ; exit
		int 21h
cseg 	ends
; ---- Zavrsen segment podataka


; ---- Stek segment
sseg segment stack 'STACK' 
     dw 64 dup(?)
sseg ends
; ---- Zavrsen stek segment

; ---- Definisanje ulazne tacke programa (video)
end draw




 
 