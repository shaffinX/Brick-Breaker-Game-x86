;;.286
.model small
.stack 0100h
.data
nameOfPerson db 0 dup()
entryString db "enter your name : ","$"
gameName db "BRICK BREAKER","$"
Yname db "name: ","$"
lvla db "LVL1 [a]","$"
lvlb db "LVL2 [b]","$"
lvlc db "LVL3 [c]","$"
stat db "highest scores [p]","$"
endgm db "EXIT [esc]","$"
hello db "Hello! ","$"
inst1 db "Start:","$"
inst2 db "Press left and right Key to move","$"
inst db "the paddle.","$"
inst3 db "Goal:","$"
inst4 db "Destroy all bricks.","$"
inst5 db "Beware:","$"
inst6 db "You have limited lives","$"
lozer db " game lost",'$'
sta1 db "Shaffin ---> 45 ---> lvl3","$"
sta2 db "Noman   ---> 43 ---> lvl3","$"
sta3 db "Fahad   ---> 31 ---> lvl2","$"
hsc db "High Scores","$"

paz db "pause",'$'
temp1 dw 0

;;;;;;;;;;;;;;;;;;;;;;file handling ;;;;;;;;;;;;;;
filerp db"BrickBreaker.txt",0
duffer db 100 dup('$')
gandle dw 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
abl1 dw 30
abl2 dw 1
abl3 dw 10
bbl2 dw 35
cbl2 dw 70
dbl2 dw 105
ebl2 dw 140
fbl2 dw 175
gbl2 dw 210
hbl2 dw 245
ibl2 dw 280

brr1 dw 10
brr2 dw 40

rec1 db 0
rec2 db 0
load db 2
;;;;;;;;;;;;;;;;;;;;;;;;;//////////////////
	ballx dw 82h 	;x-position
	bally dw 0B3h 	;y-position
	ballsize dw 05h	;size of ball
	ballz dw 05h
	temp dw 00h; 
	timy db 0 ;    timing variable
	v_x dw -05h;		velocity of ball in x-axis
	v_y dw -02h;		velocity of ball in y-axis
	x_boundary dw 12Ch;
	y_boundary dw 0BEh;
	pad_bound_x dw 120h

	rest_ballx dw 85h;
	rest_bally dw 0B3h;

	rest_paddle_x dw 82h;	for paddle starting-xposition
	rest_paddle_y dw 0BBh;	for paddle starting-yposition

	paddle_x dw 82h;	for paddle starting-xposition
	paddle_y dw 0BBh;	for paddle starting-yposition
	paddsize_x dw 022h;	paddle width
	paddsize_y dw 06h;	paddle thickness
	pad_spd dw 0Ah;


	pyr_1x dw 58h;this array for pyrammid x-axis
	pyr_1y dw 044h;this array for pyrammid y-axis
			;;00;;;02;;04;;06;;08;;10;;12;;14;;;;16
	brick_x dw 58h,65h,71h,7Dh,89h,95h,0A3h,0B1h,0BCh;
	brick_y	dw 044h,04Dh,56h,05Fh,68h;
	pyr_1sizex dw 0Eh; this array is for defining size in x-axis direction of pyrammid
	pyr_1sizey dw 08h; this array is for definign the isze of y-axis direction of pyramid bricks
	n_color db 1h,2h,3h,4h,5h,6h,9h,0Ah,0Bh,0Ch,0Dh,0Eh,0Fh,4h,1h;
			;;1;;2;;3;;4;;5;6;;7;;8;;9;10;;11;;12;;13;14;15
n_color2 db 1h,2h,3h,4h,5h,6h,9h,0Ah,0Bh,0Ch,0Dh,0Eh,0Fh,4h,1h,2h,5h,0Ah;
n_color3 db 1h,2h,3h,4h,5h,6h,9h,0Ah,0Bh,0Ch,0Dh,0Eh,0Fh,4h,1h,2h,5h,0Ah;
	check_pyr db 3h,2h,3h,2h,3h,3h,3h,4h,4h,3h,3h,3h,3h,3h,3h,3h,3h,3h,3h
	tt db 02d;
	score db 0;
	score_points DB '0','$'    ;text with the player one points
	score_1 db 0;
	score_points_2 DB '0','$'
	heart_symb dw ' ','$'

	lives db 51;
	living db '0','$'
congrats db "you win ",'$'



outline_x dw 04h;
outline_y dw 010h;

.code



mov ax,@data
mov ds,ax

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
shaffin proc

    call first_screen

    call second_screen

    call third_screen

    call fourth_screen

    call level1

shaffin endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadsq macro x1,y1
    mov cx,x1
    mov dx,y1

    mov rec1,5
    .while(rec1>0)
    mov rec2,5
    mov cx,x1
        .while(rec2>0)
        mov ah,0ch 
        mov al,9
        int 10h
        inc cx
        dec rec2
        .endw
    inc dx
    dec rec1
.endw

endm

first_screen proc

        mov ah,00h
        mov al,13h
        int 10h

        .while(load>0)
        mov ah,02h
        mov dl,13
        mov dh,11
        mov bx,0
        int 10h

        mov dx,offset gameName  ;Displaying game name
        mov ah,09h
        int 21h

        loadsq 140,110 
        MOV CX, 0FH
        MOV DX, 4240H
        MOV AH, 86H
        INT 15H
        loadsq 150,110
        MOV CX, 0FH
        MOV DX, 4240H
        MOV AH, 86H
        INT 15H
        loadsq 160,110
        MOV CX, 0FH
        MOV DX, 4240H
        MOV AH, 86H
        INT 15H
        loadsq 170,110
        MOV CX, 0FH
        MOV DX, 4240H
        MOV AH, 86H
        INT 15H

        mov ah,00h
        mov al,13
        int 10h
        dec load
        .endw

        ret

first_screen endp

second_screen proc

        mov ah,00h
        mov al,13h
        int 10h

        mov ah,02h
        mov dl,13
        mov dh,11
        mov bx,0
        int 10h

        mov dx,offset gameName  ;Displaying game name
        mov ah,09h
        int 21h

        mov ah,02h
        mov dl,0
        mov dh,21
        mov bx,0
        int 10h

        mov ah,09h
        mov dx,offset entryString	;displaying Entry Name
        int 21h

        mov dx,0

        mov dx,offset nameOfPerson	;Entering the name
        mov ah,0Ah
        int 21h

        ;TO add $ at last of string
        mov si, offset nameOfPerson + 1 	;number of characters entered.
        mov cl, [si]	
        mov ch, 0      				 
        inc cx 						
        add si, cx 					
        mov al, '$'
        mov [si], al 					;REPLACE CHR(13) BY '$'

        mov ah,00h
        mov al,13h
        int 10h

        ret

second_screen endp
;----------------------------------------------------------------------------------------------------------------------------------------
third_screen proc

mov ah,00h
mov al,13h
int 10h

mov ah,02h
mov dl,10
mov dh,1
mov bx,0
int 10h

mov ah,09h
mov dx, offset hello
int 21h

mov ah,02h
mov dl,17
mov dh,1
mov bx,0
int 10h

mov dx, offset nameOfPerson     ;Displaying name of player
mov ah,09h
int 21h

mov ah,02h
mov dl,1
mov dh,5
mov bx,0
int 10h
mov ah,09h
mov dx, offset inst1
int 21h

mov ah,02h
mov dl,1
mov dh,7
mov bx,0
int 10h
mov ah,09h
mov dx, offset inst2
int 21h

mov ah,02h
mov dl,1
mov dh,8
mov bx,0
int 10h
mov ah,09h
mov dx, offset inst
int 21h

mov ah,02h
mov dl,1
mov dh,12
mov bx,0
int 10h
mov ah,09h
mov dx, offset inst3
int 21h

mov ah,02h
mov dl,1
mov dh,14
mov bx,0
int 10h
mov ah,09h
mov dx, offset inst4
int 21h

mov ah,02h
mov dl,1
mov dh,18
mov bx,0
int 10h
mov ah,09h
mov dx, offset inst5
int 21h

mov ah,02h
mov dl,1
mov dh,20
mov bx,0
int 10h
mov ah,09h
mov dx, offset inst6
int 21h

stoppp:
mov ah,1
int 16h
jnz stoppp
mov ah,0
int 16h
cmp ah,1ch
je returnfn
jmp stoppp
returnfn:
ret

third_screen endp
;-----------------------------------------------------------------------------------------------------------------------------------------

brick macro x1,y1
mov cx,x1
mov dx,y1

mov rec1,10
.while(rec1>0)
mov rec2,30
mov cx,x1
    .while(rec2>0)
    mov ah,0ch 
    mov al,12
    int 10h
    inc cx
    dec rec2
    .endw
inc dx
dec rec1
.endw

endm
;Menu Screen
fourth_screen proc

mov ah,00h
mov al,13h              ;setting Video Mode
int 10h

mov ah,02h
mov dl,14               ;setting curser
mov dh,1
mov bx,0
int 10h

mov dx,offset gameName      ;writing game name
mov ah,09h
int 21h

;DESIGN------------------
mov dx,20
a2:
mov cx,30
a1:
mov cx,abl2
mov ah,0ch
mov al,12
int 10h
inc abl2
mov cx,abl1
dec abl1
loop a1
mov abl1,30
mov abl2,1
inc dx
mov cx,abl3
dec abl3
loop a2

mov abl1,30
mov abl3,10

mov dx,20
b2:
mov cx,30
b1:
mov cx,bbl2
mov ah,0ch
mov al,12
int 10h
inc bbl2
mov cx,abl1
dec abl1
loop b1
mov abl1,30
mov bbl2,35
inc dx
mov cx,abl3
dec abl3
loop b2

mov abl1,30
mov abl3,10

mov dx,20
c2:
mov cx,30
c1:
	mov cx,cbl2
	mov ah,0ch
	mov al,12
	int 10h
	inc cbl2
	mov cx,abl1
	dec abl1
	loop c1
	mov abl1,30
	mov cbl2,70
	inc dx
	mov cx,abl3
	dec abl3
	loop c2

	mov abl1,30
	mov abl3,10

	mov dx,20
d2:
mov cx,30
d1:
	mov cx,dbl2
	mov ah,0ch
	mov al,12
	int 10h
	inc dbl2
	mov cx,abl1
	dec abl1
	loop d1
	mov abl1,30
	mov dbl2,105
	inc dx
	mov cx,abl3
	dec abl3
	loop d2

	mov abl1,30
	mov abl3,10

mov dx,20
e2:
	mov cx,30
e1:
	mov cx,ebl2
	mov ah,0ch
	mov al,12
	int 10h
	inc ebl2
	mov cx,abl1
	dec abl1
	loop e1
	mov abl1,30
	mov ebl2,140
	inc dx
	mov cx,abl3
	dec abl3
	loop e2

	mov abl1,30
	mov abl3,10

	mov dx,20
f2:
mov cx,30
f1:
	mov cx,fbl2
	mov ah,0ch
	mov al,12
	int 10h
	inc fbl2
	mov cx,abl1
	dec abl1
	loop f1
	mov abl1,30
	mov fbl2,175
	inc dx
	mov cx,abl3
	dec abl3
	loop f2

mov abl1,30
mov abl3,10

mov dx,20
g2:
mov cx,30
g1:
	mov cx,gbl2
	mov ah,0ch
	mov al,12
	int 10h
	inc gbl2
	mov cx,abl1
	dec abl1
	loop g1
	mov abl1,30
	mov gbl2,210
	inc dx
	mov cx,abl3
	dec abl3
	loop g2

	mov abl1,30
	mov abl3,10
	
	mov dx,20
h2:
	mov cx,30
h1:
	mov cx,hbl2
	mov ah,0ch
	mov al,12
	int 10h
	inc hbl2
	mov cx,abl1
	dec abl1
	loop h1
	mov abl1,30
	mov hbl2,245
	inc dx
	mov cx,abl3
	dec abl3
	loop h2

mov abl1,30
mov abl3,10

	mov dx,20
i2:
	mov cx,30
i1:
	mov cx,ibl2
	mov ah,0ch
	mov al,12
	int 10h
	inc ibl2
	mov cx,abl1
	dec abl1
	loop i1
	mov abl1,30
	mov ibl2,280
	inc dx
	mov cx,abl3
	dec abl3
	loop i2

	brick 0,165
	brick 35,165
	brick 70,165
	brick 105,165
	brick 140,165
	brick 175,165
	brick 210,165
	brick 245,165
	brick 280,165
	brick 315,165
	brick 315,20

br1:
	mov dx,35
	mov bx,125
br2:
	mov cx,brr2
	mov al,7
	mov ah,0ch
	int 10h
	inc dx
	mov cx,bx
	dec bx
	loop br2
	inc brr2
	mov cx, brr1
	dec brr1
	loop br1

	mov cx,280
	mov dx,35
mov rec1,125
.while(rec1>0)
	mov rec2,10
	mov cx,280
	    .while(rec2>0)
	    mov ah,0ch 
	    mov al,7
	    int 10h
	    dec cx
	    dec rec2
	    .endw
inc dx
dec rec1
.endw


;DESIGN END---------------------------------------------


mov ah,02h
mov dl,25
mov dh,5
mov bx,0
int 10h

mov dx, offset nameOfPerson     ;Displaying name of player
mov ah,09h
int 21h

mov ah,02h
mov dl,20
mov dh,5
mov bx,0
int 10h

mov dx,offset Yname     ;Displaying name of player
mov ah,09h
int 21h


mov ah,02h
mov dl,14
mov dh,9
mov bx,0
int 10h

mov dx,offset lvla
mov ah,09h
int 21h

mov ah,02h
mov dl,14
mov dh,11
mov bx,0
int 10h

mov dx,offset lvlb
mov ah,09h
int 21h

mov ah,02h
mov dl,14
mov dh,13
mov bx,0
int 10h

mov dx,offset lvlc
mov ah,09h
int 21h

mov ah,02h
mov dl,11
mov dh,15
mov bx,0
int 10h

mov dx,offset stat
mov ah,09h
int 21h

mov ah,02h
mov dl,14
mov dh,17
mov bx,0
int 10h

mov dx,offset endgm
mov ah,09h
int 21h

;Detecting keys-----------
check1:
mov ah,1
int 16h
jnz check1          
mov ah,0
int 16h
cmp ah,1eh
je lvls_1
cmp ah,30h
je lvls_2
cmp ah,2eh
je lvls_3
cmp ah,1ch
je entry
.if(ah==19h)

;creat a file
mov ah, 3ch ;--------------------------------------- to create a file
mov cx, 0
mov dx, offset filerp
int 21h
;-------------------------------------------------------------------------------------------------


mov ah,3dh ; 3dh of dos services opens a file----------------------------------------------------------------
mov al,2 ; 0 - for reading. 1 - for writing. 2 - both
mov dx,offset filerp ; make a pointer to the filename
int 21h ; call dos
mov gandle,ax ; function 3dh returns the file handle in ax, here we save it for later


;writing into file----------------------------------------------------------------------------------------------


mov cx,0
mov dx, 0
mov ah,42h
mov al,2
int 21h
mov ah, 40h ; service to write to a file
mov bx, gandle
mov cx, lengthof sta1 -1 ;string length.
mov dx, offset sta1
int 21h

mov dx, offset sta2
mov ah,3fh
int 21h

mov cx,0
mov dx, 0
mov ah,42h
mov al,2
int 21h

mov ah, 40h ; service to write to a file
mov bx, gandle
mov cx, lengthof sta2 -1 ;string length.
mov dx, offset sta2
int 21h

mov dx, offset sta3
mov ah,3fh
int 21h

mov cx,0
mov dx, 0
mov ah,42h
mov al,2
int 21h

mov ah, 40h ; service to write to a file
mov bx, gandle
mov cx, lengthof sta3 -1 ;string length.
mov dx, offset sta3
int 21h



mov ah,00h
mov al,13h              ;setting Video Mode
int 10h

mov ah,02h
mov dl,12               ;setting curser
mov dh,1
mov bx,0
int 10h

mov dx,offset hsc
mov ah,09h
int 21h

mov ah,02h
mov dl,2               ;setting curser
mov dh,8
mov bx,0
int 10h

mov dx,offset sta1
mov ah,09h
int 21h

mov ah,02h
mov dl,2               ;setting curser
mov dh,10
mov bx,0
int 10h

mov dx,offset sta2
mov ah,09h
int 21h

mov ah,02h
mov dl,2               ;setting curser
mov dh,12
mov bx,0
int 10h

mov dx,offset sta3
mov ah,09h
int 21h

chkkkk:
mov ah,1
int 16h
jnz chkkkk
mov ah,0
int 16h
cmp ah,1ch
je resolve
jmp chkkkk

resolve:
.endif
cmp ah,01h
je exitg
jmp check1


lvls_1:
	call level1;callling level 1
lvls_2:
	call level2; calling level 2
lvls_3:
	call level3;
exitg:
call exited
entry:
ret

fourth_screen endp
;-------------------------------------------------------------------------------------------------------------------------------------------------



exited proc 
mov ah,00h
mov al,0dh
int 10h

mov ah,4ch
int 21h
exited endp






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;for escaping using 27 in decimal 

level1 proc

	call vid_mod;



   ; call exited;



timming:
mov di,0;
	mov ah,2ch; system timing
	int 21h;	ch for hr, cl for min, dh is for sec and dl for frame in dh/seconds
	cmp dl,timy
	je timming;

	mov timy,dl;
	;inc ballx

	
	mov ax,0;
	call ball_coll;	procedure for checking ball collsion and free-motion of ball;;;;; 
	call clrscr;    ;clear screen function
	call ball;		;balling proc
	call pyr1
	call score_ui;
	call padd_cont; ;paddle controls;;;;;;
	call outline;
	call paddle;	;calling paddle
	
	cmp lives,48;
	je gay;
.if(score_1==01h)&&(score==05h)
	add score,1h
	jmp nextlvl;
	ret;
.endif

	;;;////// level2 starts from mhere
jmp timming


nextlvl:
	call win;
	call ballreset;
	call level2;
	ret;
gay:
call lost
mov ah,4ch 		;
int 21h  	;	;
level1 endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;
level2 proc;


call vid_mod;

sub v_x,04h;VELOCITY OF BALLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
sub v_y,04h;SAME AS ABOVE IM TOO TIRED TO WRITE ANYTHING MAN
sub paddsize_y,01h;
sub paddsize_x,02h;
   ; call exited;
mov lives,52;
call ballreset;


timming:
mov di,0;
	mov ah,2ch; system timing
	int 21h;	ch for hr, cl for min, dh is for sec and dl for frame in dh/seconds
	cmp dl,timy
	je timming;

	mov timy,dl;
	;inc ballx

	
	mov ax,0;
	call ball_coll;	procedure for checking ball collsion and free-motion of ball;;;;; 
	call clrscr;    ;clear screen function
	call ball;		;balling proc
	call pyr2
	call score_ui;
	call padd_cont; ;paddle controls;;;;;;
	call outline;
	call paddle;	;calling paddle
	
	cmp lives,48;
	je guy1;
.if(score_1==03h)&&(score==01h) ||(score_1==01h)&&(score==05h)
	sub score,1h;
	jmp nextlvl;
	ret;
.endif

	;;;////// level2 starts from mhere
jmp timming


nextlvl:
	call win;
	add score,1h;
	call ballreset;
	call level3;
	ret;

guy1:
call lost;
mov ah,4ch 		;
int 21h  	;	;




level2 endp;





level3 proc
call vid_mod;

sub v_x,01h;
sub v_y,01h;
;sub paddsize_y,01h;
;sub paddsize_x,02h;
   ; call exited;
mov lives,52;
call ballreset;
mov temp1,16
mov si,0;
.while(temp1>0)

mov check_pyr[si],4h;
inc si;
sub temp1,1
.endw

mov temp1,17
mov si,0;
.while(temp1>0)

mov al,n_color3[si];
mov n_color2[si],al;
inc si;
sub temp1,1
.endw

mov si,0;




timming:
mov di,0;
	mov ah,2ch; system timing
	int 21h;	ch for hr, cl for min, dh is for sec and dl for frame in dh/seconds
	cmp dl,timy
	je timming;

	mov timy,dl;
	;inc ballx

	
	mov ax,0;
	call ball_coll;	procedure for checking ball collsion and free-motion of ball;;;;; 
	call clrscr;    ;clear screen function
	call ball;		;balling proc
	call pyr2
	call score_ui;
	call padd_cont; ;paddle controls;;;;;;
	call outline;
	call paddle;	;calling paddle
	
	cmp lives,48;
	je guy1;
.if(score_1==04h)&&(score==06h) ||(score_1==01h)&&(score==05h)||(score_1==03h)&&(score==00h)
	sub score,1h;
	jmp nextlvl;
	ret;
.endif

	;;;////// level2 starts from mhere
jmp timming


nextlvl:
	call win;
	call ballreset;
	call exited;
	ret;

guy1:
call lost;
mov ah,4ch 		;
int 21h  	;	;



ret;
level3 endp;







win proc
		mov ah,02h                       ;set cursor position
		mov bh,00h                       ;set page number
		mov dh,0Ah                       ;set row 
		mov dl,59h						 ;set column
		int 10h							 
		
		mov ah,09h                       ;write string to standard output
		lea dx,congrats    ;
		int 21h  



	mov ah,01h; for inputing key;;;;
	int 16h;;;;;;;;;
	jnz ohio;
	mov ah,00h;
	int 16h;;


ohio:


ret;


win endp;

pause proc

		mov ah,02h                       ;set cursor position
		mov bh,00h                       ;set page number
		mov dh,0Ah                       ;set row 
		mov dl,59h						 ;set column
		int 10h							 
		
		mov ah,09h                       ;write string to standard output
		lea dx,paz    
		int 21h  



	mov ah,01h; for inputing key;;;;
	int 16h;;;;;;;;;
	jnz ohio;
	mov ah,00h;
	int 16h;;


ohio:


ret;




pause endp



lost proc
		mov ah,02h                       ;set cursor position
		mov bh,00h                       ;set page number
		mov dh,0Ah                       ;set row 
		mov dl,59h						 ;set column
		int 10h							 
		
		mov ah,09h                       ;write string to standard output
		lea dx,lozer    ;
		int 21h  



	mov ah,01h; for inputing key;;;;
	int 16h;;;;;;;;;
	jnz ohio;
	mov ah,00h;
	int 16h;;


ohio:


ret;


lost endp;

;;;;;;;;;
score_ui proc
		
;       Draw the points of the left player (player one)
		
		mov ah,02h                       ;set cursor position
		mov bh,00h                       ;set page number
		mov dh,01h                       ;set row 
		mov dl,02h						 ;set column
		int 10h							 
		
		mov ah,09h                       ;write string to standard output
		lea dx,score_points    
		int 21h                  		;print
		mov ah,02h                       ;set cursor position
		mov bh,00h                       ;set page number
		mov dh,01h                       ;set row 
		mov dl,01h						 ;set column
		int 10h							 
		
		mov ah,09h                       ;write string to standard output
		lea dx,score_points_2    ;
		int 21h
;////heart               		;print the string
		mov ah,02h                       ;set cursor position
		mov bh,00h                       ;set page number
		mov dh,01h                       ;set row 
		mov dl,014h						 ;set column
		int 10h							 
		
		mov ah,09h                       ;write string to standard output
		lea dx, heart_symb   
		int 21h



		mov ah,02h                       ;set cursor position
		mov bh,00h                       ;set page number
		mov dh,01h                       ;set row 
		mov dl,015h						 ;set column
		int 10h							 
		
		mov ah,09h                       ;write string to standard output
		lea dx, living   
		int 21h


	mov ah,02h                       ;set cursor position
		mov bh,00h                       ;set page number
		mov dh,01h                       ;set row 
		mov dl,20h						 ;set column
		int 10h							 
		
		mov ah,09h                       ;write string to standard output
		lea dx, nameOfPerson   ;
		int 21h


score_ui endp

UPDATE_POINTS PROC 
		
		xor ax,ax
.if(score>9)

	mov score,0;
	inc score_1;
.endif

		mov al,score 
	

		add al,30h                       
		mov [score_points],al

mov al,score_1 
add al,30h;
	mov [score_points_2],al


	mov [heart_symb],3h;

	mov al, lives;
	mov [living],al;

		ret;
UPDATE_POINTS ENDP




vid_mod proc
		mov ah,00h ;set to video mode
		mov al,0dh ; for vga graphics
		int 10h ;interupt for video

		mov ah,0bh ;set for background
		mov bh,00h 	;set to background

		mov bl,00h ;option for background-color
		int 10h 	;interupt for video

		mov ax,0;
		ret;
vid_mod endp;
;;;;;;


clrscr proc
	mov ah,02h; clear screen 
	int 10h

	mov ah,0;	
	mov al,0dh;
	int 10h;
	ret;
clrscr endp

ball proc

		mov cx,ballx;
		mov dx,bally;
	;	call ballz_x_axis
		call ballz_y_axis
		ret;

ball endp
;;;;;;
padd_cont proc
;;
	mov ah,01h; for inputing key;;;;
	int 16h;;;;;;;;;
	jz exit;
	mov ah,00h;
	int 16h;;
	cmp ah,4Bh
	je left
	cmp ah,4Dh
	je right
	cmp ah,01h
	je werto;
	cmp ah,39h
	je pos;
;;;	mov ah,0;
	ret
jmp exit;;;

pos:
	call pause;
	ret;
right:
	mov ax,paddle_x;
	add ax,pad_spd;
	mov bx,05h;
	cmp ax,pad_bound_x;
	jg exit;;
	 mov paddle_x,ax;
	jmp exit;;
left:
	
	mov ax,paddle_x;
	sub ax,pad_spd;
	cmp ax,00h;
	jl exit;
	mov paddle_x,ax;
	jmp exit;;
werto:
	call exited;		
exit:
	;;mov ah,0;
	ret;

padd_cont endp;
;;;;;;
ball_coll proc
;;for x-axis

	mov ax,v_x;		for movement in x- direction
	add ballx,ax;	for movment in x- direction

	cmp ballx,01h;	starting position of window
	jl neg_x;		jump to negative velocity

	mov ax,x_boundary; maximum limit of x-axis
	cmp ballx,ax;   ;comparing
	jg neg_x;
;;for y-axis

	mov ax,0;		clearing ax
	mov ax,v_y;		movement in y-direction
	add bally,ax;	movement in y-direction

	cmp bally,19h;	starting bound.. of window
	jl neg_y;		jump to negative velocity

	mov ax,y_boundary; maximum limit of y-axis
	cmp bally,ax;   ;comparing
	jg resetball;		my bottom part of the window that i will be resetting........
	

	;;;checking collison with the paddle here if u don't mind :)
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,paddle_x;
	jng exit;

	mov ax,paddle_x;
	add ax,paddsize_x;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,paddle_y;
	jng exit;

	mov ax,paddle_y;
	add ax,paddsize_y;
	cmp bally,ax;
	jnl exit;

	neg v_y;
	ret;

neg_x:
		neg v_x;
		ret;
neg_y:
		neg v_y;
		ret;
resetball:
		sub lives,01;
		call ballreset;
		
		ret;
exit:
	ret;
ball_coll endp
;;;;;;


outline proc



mov cx, outline_x;
mov dx, outline_y;


draw:
mov ah,0ch;
mov al,0fh;
mov bh,00h;

int 10h;

inc cx;
mov ax,cx;
sub ax,outline_x;
cmp ax,129h;

jng draw;

mov cx,outline_x;
inc dx;

mov ax,dx;

sub ax,outline_y;
inc dx;


mov ax,dx;
sub ax,outline_y;

cmp ax,02h;
jng draw;


ret;

outline endp;









ballreset proc

	mov ax, rest_ballx;
	mov ballx,ax;
	mov ax,0;
	mov ax,rest_bally;
	mov bally,ax;

	mov ax,0;
	mov ax,rest_paddle_x;
	mov paddle_x,ax;

	mov ax,0;
	mov ax,rest_paddle_y
	mov paddle_y,ax;
	neg v_x;
	neg v_y;


ret;
ballreset endp
;;;;;;

;;;;;;
paddle proc
		mov cx,paddle_x;
		mov dx,paddle_y;
	;	call ballz_x_axis
		call paddle_y_axis
		ret;
paddle endp
;;for making ball
ballz_x_axis proc
	
	ballxe:	
		mov ah,0ch 			;config pixel
		mov al,0ch 			;white color
		mov bh,00h 			;page number
		int 10h
		add cx,1   			;inc cx
		mov  ax,cx;			
		sub ax,ballx;		
		cmp ballsize,ax;	;comparing to check whether it has reached its given x-axis or not
		jnl ballxe;

	
	ret;
ballz_x_axis endp


paddle_x_axis proc
	padlexe:	
		mov ah,0ch 			;config pixel
		mov al,0bh 			;white color
		mov bh,00h 			;page number
		int 10h
		add cx,1   			;inc cx
		mov  ax,cx;			
		sub ax,paddle_x;		
		cmp paddsize_x,ax;	;comparing to check whether it has reached its given x-axis or not
		jnl padlexe;

	
	ret;

paddle_x_axis endp

paddle_y_axis proc

		ballye:	
		call paddle_x_axis
		mov cx,paddle_x;now resetting our x axis for it redrawn in y-axis
		add dx,1;now incrementing dx so that we can draw till ballsize

		mov ax,dx;
		sub ax,paddle_y
		cmp paddsize_y,ax;
jnl ballye;	;comparing to check whether it has reached its given y-axis or not
;;
ret
paddle_y_axis endp



ballz_y_axis proc
		ballxe:	
		call ballz_x_axis
		mov cx,ballx;now resetting our x axis for it redrawn in y-axis
		add dx,1;now incrementing dx so that we can draw till ballsize

		mov ax,dx;
		sub ax,bally
		cmp ballsize,ax;
jnl ballxe;	;comparing to check whether it has reached its given y-axis or not
;;
ret
ballz_y_axis endp
;;;;for making ball

pyr1 proc
mov si,0;
mov di,0;
mov tt,0d;
		
	
		call patt1;
			
		ret;


pyr1 endp

patt1 proc
mov di,0;
		;	mov n_color[0],1h;


inc di;
			mov ax,brick_y[0];
			mov pyr_1y,ax;
			mov ax,brick_x[0];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis

call patt1_coll;
inc di;			
		;	mov n_color[1],2h;
			mov ax,brick_y[0];
			mov pyr_1y,ax;
			mov ax,brick_x[4];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis

call patt1_coll2;
inc di;		
		;	mov n_color[2],3h
			mov ax,brick_y[0];
			mov pyr_1y,ax;
			mov ax,brick_x[8];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis

call patt1_coll3;
inc di;		
		;	mov n_color[3],0Ah
			mov ax,brick_y[0];
			mov pyr_1y,ax;
			mov ax,brick_x[12];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis
call patt1_coll4;
inc di;
		;	mov n_color[4],0Bh
			mov ax,brick_y[0];
			mov pyr_1y,ax;
			mov ax,brick_x[16];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis
;;;;;;;;;;;;;first row ends here		
call patt1_coll5;
		;	mov n_color[5],4h;
inc di;
			mov ax,brick_y[2];
			mov pyr_1y,ax;
			mov ax,brick_x[2];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis

call patt1_coll6;
inc di;		
		;	mov n_color[6],5h;
			mov ax,brick_y[2];
			mov pyr_1y,ax;
			mov ax,brick_x[6];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis

call patt1_coll7;
inc di;
		;	mov n_color[7],6h;
			mov ax,brick_y[2];
			mov pyr_1y,ax;
			mov ax,brick_x[10];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis
call patt1_coll8;
inc di;
		;	mov n_color[8],0Dh;
			mov ax,brick_y[2];
			mov pyr_1y,ax;
			mov ax,brick_x[14];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis
call patt1_coll9;
;;;;;;second row ends here
inc di;
		;	mov n_color[9],4h;
			mov ax,brick_y[4];
			mov pyr_1y,ax;
			mov ax,brick_x[4];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis
call patt1_coll10;		
inc di;
			;mov n_color[10],0Bh;
			mov ax,brick_y[4];
			mov pyr_1y,ax;
			mov ax,brick_x[8];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis
		
call patt1_coll11;
inc di;
			;mov n_color[11],0Ch;
			mov ax,brick_y[4];
			mov pyr_1y,ax;
			mov ax,brick_x[12];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis

call patt1_coll12;
;;;;third row ends here		
inc di;
			;mov n_color[12], 3h;
			mov ax,brick_y[6];
			mov pyr_1y,ax;
			mov ax,brick_x[6];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis
call patt1_coll13;
inc di;	
			;mov n_color[13], 5h;
			mov ax,brick_y[6];
			mov pyr_1y,ax;
			mov ax,brick_x[10];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis
call patt1_coll14;
;;;fourth row ends here
inc di;
			;mov n_color[14],2h;
			mov ax,brick_y[8];
			mov pyr_1y,ax;
			mov ax,brick_x[8];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr1_y_axis

call patt1_coll15;




ret;
patt1 endp;


patt1_coll proc uses di;

	;;;checking collison with the paddle here if u don't mind :)
.if(n_color[1]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[0];
	jng exit;

	mov ax,brick_x[0];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[0];
	jng exit;

	mov ax,brick_y[0];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[1],00h;
	neg v_y;
	add score,1;

.endif
	ret;
exit:
	ret;;
patt1_coll endp

patt1_coll2 proc
	.if(n_color[2]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[4];
	jng exit;

	mov ax,brick_x[4];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[0];
	jng exit;

	mov ax,brick_y[0];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[2],00h;
	neg v_y;
	add score,1;
.endif
ret;;

exit:
ret;;

patt1_coll2 endp

patt1_coll3 proc
.if(n_color[3]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[8];
	jng exit;

	mov ax,brick_x[8];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[0];
	jng exit;

	mov ax,brick_y[0];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[3],00h;
	neg v_y;
	add score,1;
.endif
ret;
exit:
ret;
patt1_coll3 endp;


patt1_coll4 proc
.if(n_color[4]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[12];
	jng exit;

	mov ax,brick_x[12];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[0];
	jng exit;

	mov ax,brick_y[0];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[4],00h;
	neg v_y;
	add score,1;
.endif
ret;
exit:
ret;

patt1_coll4 endp;

patt1_coll5 proc
.if(n_color[5]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[16];
	jng exit;

	mov ax,brick_x[16];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[0];
	jng exit;

	mov ax,brick_y[0];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[5],00h;
	neg v_y;
	add score,1;
.endif
ret;
exit:;
ret
patt1_coll5 endp;
patt1_coll6 proc
.if(n_color[6]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[2];
	jng exit;

	mov ax,brick_x[2];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[2];
	jng exit;

	mov ax,brick_y[2];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[6],00h;
	neg v_y;
	add score,1;
.endif
ret;
exit:;
ret
patt1_coll6 endp;

patt1_coll7 proc
.if(n_color[7]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[6];
	jng exit;

	mov ax,brick_x[6];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[2];
	jng exit;

	mov ax,brick_y[2];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[7],00h;
	neg v_y;
	add score,1;
.endif

ret
exit:
ret;
patt1_coll7 endp;

patt1_coll8 proc
.if(n_color[8]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[10];
	jng exit;

	mov ax,brick_x[10];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[2];
	jng exit;

	mov ax,brick_y[2];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[8],00h;
	neg v_y;
	add score,1;
.endif
ret;
exit:;
ret

patt1_coll8 endp

patt1_coll9 proc
.if(n_color[9]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[14];
	jng exit;

	mov ax,brick_x[14];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[2];
	jng exit;

	mov ax,brick_y[2];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[9],00h;
	neg v_y;
	add score,1;
.endif
ret;
exit:;
ret
patt1_coll9 endp;

patt1_coll10 proc
.if(n_color[10]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[4];
	jng exit;

	mov ax,brick_x[4];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[4];
	jng exit;

	mov ax,brick_y[4];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[10],00h;
	neg v_y;
	add score,1;
.endif
ret;
exit:;
ret
patt1_coll10 endp;

patt1_coll11 proc;
.if(n_color[11]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[8];
	jng exit;

	mov ax,brick_x[8];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[4];
	jng exit;

	mov ax,brick_y[4];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[11],00h;
	neg v_y;
	add score,1;
.endif
ret;
exit:;
ret
patt1_coll11 endp;

patt1_coll12 proc
.if(n_color[12]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[12];
	jng exit;

	mov ax,brick_x[12];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[4];
	jng exit;

	mov ax,brick_y[4];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[12],00h;
	neg v_y;
	add score,1;
.endif
ret;
exit:;
ret
patt1_coll12 endp;

patt1_coll13 proc
.if(n_color[13]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[6];
	jng exit;

	mov ax,brick_x[6];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[6];
	jng exit;

	mov ax,brick_y[6];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[13],00h;
	neg v_y;
	add score,1;
.endif
ret;
exit:;
ret
patt1_coll13 endp;

patt1_coll14 proc
.if(n_color[14]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[10];
	jng exit;

	mov ax,brick_x[10];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[6];
	jng exit;

	mov ax,brick_y[6];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[14],00h;
	neg v_y;
	add score,1;
.endif
ret;
exit:;
ret

patt1_coll14 endp;

patt1_coll15 proc

.if(n_color[15]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[8];
	jng exit;

	mov ax,brick_x[8];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[8];
	jng exit;

	mov ax,brick_y[8];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	mov n_color[15],00h;
	neg v_y;
	add score,1;
.endif

ret;
exit:;
ret

patt1_coll15 endp






pyr1_x_axis proc uses di;

	pyrexe:	
		mov ah,0ch 			;config pixel
		mov al,n_color[di+0]			; color

		mov bh,00h 			;page number
		int 10h
		add cx,1   			;inc cx
		mov  ax,cx;			
		sub ax,pyr_1x;		
		cmp pyr_1sizex,ax;	;comparing to check whether it has reached its given x-axis or not
		jnl pyrexe;

	ret;



pyr1_x_axis endp;


pyr1_y_axis proc uses di;
	pyrye:	
		call pyr1_x_axis
		mov cx,pyr_1x;now resetting our x axis for it redrawn in y-axis
		add dx,1;now incrementing dx so that we can draw till ballsize

		mov ax,dx;
		sub ax,pyr_1y
		cmp pyr_1sizey,ax;
jnl pyrye;	;comparing to check whether it has reached its given y-axis or not
;;
ret




pyr1_y_axis endp


;;;///////////////////////////////////////////////////
;;;;/////////////////////////////////////////////////
pyr2_x_axis proc uses di;

	pyrexe:	
		mov ah,0ch 			;config pixel
		mov al,n_color2[di+0]			; color

		mov bh,00h 			;page number
		int 10h
		add cx,1   			;inc cx
		mov  ax,cx;			
		sub ax,pyr_1x;		
		cmp pyr_1sizex,ax;	;comparing to check whether it has reached its given x-axis or not
		jnl pyrexe;

	ret;



pyr2_x_axis endp;


pyr2_y_axis proc;
	pyrye:	
		call pyr2_x_axis
		mov cx,pyr_1x;now resetting our x axis for it redrawn in y-axis
		add dx,1;now incrementing dx so that we can draw till ballsize

		mov ax,dx;
		sub ax,pyr_1y
		cmp pyr_1sizey,ax;
jnl pyrye;	;comparing to check whether it has reached its given y-axis or not
;;
ret




pyr2_y_axis endp


pyr2 proc far 
mov si,0;
mov di,0;
mov tt,0d;
		
	
		call patt2;
			
		ret;


pyr2 endp

patt2 proc far;
mov di,0;
		;	mov n_color[0],1h;


inc di;
			mov ax,brick_y[0];
			mov pyr_1y,ax;
			mov ax,brick_x[0];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis

call patt2_coll;
inc di;			
		;	mov n_color[1],2h;
			mov ax,brick_y[0];
			mov pyr_1y,ax;
			mov ax,brick_x[4];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis

call patt2_coll2;
inc di;		
		;	mov n_color[2],3h
			mov ax,brick_y[0];
			mov pyr_1y,ax;
			mov ax,brick_x[8];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis

call patt2_coll3;
inc di;		
		;	mov n_color[3],0Ah
			mov ax,brick_y[0];
			mov pyr_1y,ax;
			mov ax,brick_x[12];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis
call patt2_coll4;
inc di;
		;	mov n_color[4],0Bh
			mov ax,brick_y[0];
			mov pyr_1y,ax;
			mov ax,brick_x[16];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis
;;;;;;;;;;;;;first row ends here		
call patt2_coll5;
		;	mov n_color[5],4h;
inc di;
			mov ax,brick_y[2];
			mov pyr_1y,ax;
			mov ax,brick_x[2];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis

call patt2_coll6;
inc di;		
		;	mov n_color[6],5h;
			mov ax,brick_y[2];
			mov pyr_1y,ax;
			mov ax,brick_x[6];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis

call patt2_coll7;
inc di;
		;	mov n_color[7],6h;
			mov ax,brick_y[2];
			mov pyr_1y,ax;
			mov ax,brick_x[10];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis
call patt2_coll8;
inc di;
		;	mov n_color[8],0Dh;
			mov ax,brick_y[2];
			mov pyr_1y,ax;
			mov ax,brick_x[14];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis
call patt2_coll9;
;;;;;;second row ends here
inc di;
		;	mov n_color[9],4h;
			mov ax,brick_y[4];
			mov pyr_1y,ax;
			mov ax,brick_x[4];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis
call patt2_coll10;		
inc di;
			;mov n_color[10],0Bh;
			mov ax,brick_y[4];
			mov pyr_1y,ax;
			mov ax,brick_x[8];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis
		
call patt2_coll11;
inc di;
			;mov n_color[11],0Ch;
			mov ax,brick_y[4];
			mov pyr_1y,ax;
			mov ax,brick_x[12];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis

call patt2_coll12;
;;;;third row ends here		
inc di;
			;mov n_color[12], 3h;
			mov ax,brick_y[6];
			mov pyr_1y,ax;
			mov ax,brick_x[6];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis
call patt2_coll13;
inc di;	
			;mov n_color[13], 5h;
			mov ax,brick_y[6];
			mov pyr_1y,ax;
			mov ax,brick_x[10];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis
call patt2_coll14;
;;;fourth row ends here
inc di;
			;mov n_color[14],2h;
			mov ax,brick_y[8];
			mov pyr_1y,ax;
			mov ax,brick_x[8];
			mov pyr_1x,ax;
			mov cx,pyr_1x;
			mov dx,pyr_1y;
		;	call ballz_x_axis
			call pyr2_y_axis

call patt2_coll15;




ret;
patt2 endp;


patt2_coll proc 

	;;;checking collison with the paddle here if u don't mind :)
.if(n_color2[1]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[0];
	jng exit;

	mov ax,brick_x[0];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[0];
	jng exit;

	mov ax,brick_y[0];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[1],1h;
	neg v_x;
;	add score,1;
		.if(check_pyr[1]==00h)
			mov n_color2[1],00h;
	
			add score,1;
		.endif
.endif
	ret;
exit:
	ret;;
patt2_coll endp

patt2_coll2 proc
.if(n_color2[2]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[4];
	jng exit;

	mov ax,brick_x[4];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[0];
	jng exit;

	mov ax,brick_y[0];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[2],1h;
	.if(check_pyr[2]==00h)
		mov n_color2[2],00h;
		add score,1;
	.endif
	neg v_x;
;	add score,1;
.endif
ret;;

exit:
ret;;

patt2_coll2 endp

patt2_coll3 proc
.if(n_color2[3]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[8];
	jng exit;

	mov ax,brick_x[8];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[0];
	jng exit;

	mov ax,brick_y[0];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;

	sub check_pyr[3],1h;
	.if(check_pyr[3]==00h)
		mov n_color2[3],00h;
		add score,1;
	.endif
	neg v_y;
;	add score,1;
.endif
ret;
exit:
ret;
patt2_coll3 endp;


patt2_coll4 proc
.if(n_color2[4]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[12];
	jng exit;

	mov ax,brick_x[12];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[0];
	jng exit;

	mov ax,brick_y[0];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[4],1h;
	.if(check_pyr[4]==00h)
		mov n_color2[4],00h;
		add score,1;
	.endif
	neg v_y;
	;add score,1;
.endif
ret;
exit:
ret;

patt2_coll4 endp;

patt2_coll5 proc
.if(n_color2[5]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[16];
	jng exit;

	mov ax,brick_x[16];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[0];
	jng exit;

	mov ax,brick_y[0];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[5],1h;
	.if(check_pyr[5]==00h)
		mov n_color2[5],00h;
		add score,1;
	.endif
	neg v_x;
	;
	;add score,1;
.endif
ret;
exit:;
ret
patt2_coll5 endp;
patt2_coll6 proc
.if(n_color2[6]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[2];
	jng exit;

	mov ax,brick_x[2];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[2];
	jng exit;

	mov ax,brick_y[2];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[6],1h;
	.if(check_pyr[6]==00h)
		mov n_color2[6],00h;
		add score,1;
	.endif
	neg v_x;
	;add score,1;
.endif
ret;
exit:;
ret
patt2_coll6 endp;

patt2_coll7 proc
.if(n_color2[7]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[6];
	jng exit;

	mov ax,brick_x[6];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[2];
	jng exit;

	mov ax,brick_y[2];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[7],1h;
	.if(check_pyr[7]==00h)
		mov n_color2[7],00h;
		add score,1;
	.endif
	neg v_y;
	;add score,1;
.endif

ret
exit:
ret;
patt2_coll7 endp;

patt2_coll8 proc
.if(n_color2[8]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[10];
	jng exit;

	mov ax,brick_x[10];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[2];
	jng exit;

	mov ax,brick_y[2];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[8],1h;
	.if(check_pyr[8]==00h)
		mov n_color2[8],00h;
		add score,1;
	.endif
	neg v_y;
	;add score,1;
.endif
ret;
exit:;
ret

patt2_coll8 endp

patt2_coll9 proc
.if(n_color2[9]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[14];
	jng exit;

	mov ax,brick_x[14];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[2];
	jng exit;

	mov ax,brick_y[2];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[9],1h;
	.if(check_pyr[9]==00h)
		mov n_color2[9],00h;
		add score,1;
	.endif
	neg v_x;
	;add score,1;
.endif
ret;
exit:;
ret
patt2_coll9 endp;

patt2_coll10 proc
.if(n_color2[10]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[4];
	jng exit;

	mov ax,brick_x[4];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[4];
	jng exit;

	mov ax,brick_y[4];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[10],1h;
	.if(check_pyr[10]==00h)
		mov n_color2[10],00h;
		add score,1;
	.endif
	neg v_x;
	;add score,1;
.endif
ret;
exit:;
ret
patt2_coll10 endp;

patt2_coll11 proc;
.if(n_color2[11]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[8];
	jng exit;

	mov ax,brick_x[8];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[4];
	jng exit;

	mov ax,brick_y[4];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[11],1h;
	.if(check_pyr[11]==00h)
		mov n_color2[11],00h;
		add score,1;
	.endif
	neg v_y;
	;add score,1;
.endif
ret;
exit:;
ret
patt2_coll11 endp;

patt2_coll12 proc
.if(n_color2[12]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[12];
	jng exit;

	mov ax,brick_x[12];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[4];
	jng exit;

	mov ax,brick_y[4];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[12],1h;
	.if(check_pyr[12]==00h)
		mov n_color2[12],00h;
		add score,1;
	.endif
	neg v_x;
	;add score,1;
.endif
ret;
exit:;
ret
patt2_coll12 endp;

patt2_coll13 proc
.if(n_color2[13]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[6];
	jng exit;

	mov ax,brick_x[6];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[6];
	jng exit;

	mov ax,brick_y[6];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[13],1h;
	.if(check_pyr[13]==00h)
		mov n_color2[13],00h;
		add score,1;
	.endif
	neg v_y;
	;add score,1;
.endif
ret;
exit:;
ret
patt2_coll13 endp;

patt2_coll14 proc
.if(n_color2[14]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[10];
	jng exit;

	mov ax,brick_x[10];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[6];
	jng exit;

	mov ax,brick_y[6];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[14],1h;
	.if(check_pyr[14]==00h)
		mov n_color2[14],00h;
		add score,1;
	.endif
	neg v_y;
;	add score,1;
.endif
ret;
exit:;
ret

patt2_coll14 endp;

patt2_coll15 proc

.if(n_color2[15]!=0h);
	mov ax,ballx;
	add ax,ballsize;
	cmp ax,brick_x[8];
	jng exit;

	mov ax,brick_x[8];
	add ax,pyr_1sizex;
	cmp ballx,ax;
	jnl exit;

	mov ax,bally;
	add ax,ballsize;
	cmp ax,brick_y[8];
	jng exit;

	mov ax,brick_y[8];
	add ax,pyr_1sizey;
	cmp bally,ax;
	jnl exit;
	sub check_pyr[15],1h;
	.if(check_pyr[15]==00h)
		mov n_color2[15],00h;
		add score,1;
	.endif
	;neg v_y;
	neg v_x;
.endif

ret;
exit:;
ret

patt2_coll15 endp
















































end;
;functions i made so far
;;ballz_y_axis proc
;;ballz_x_axis proc
;;ball proc
;;clrscr proc
;;vidmodproc
;;paddle proc
;;pad_cont proc
;;paddle_x_axis proc
;;paddle_y_axis proc
;;ballreset proc
;;ball_coll proc
;;main proc
