; NAME      =  ABDUL_AHAD
; CODE NAME =  ZAR
; ROLL_NUM  =  23i-2014


INCLUDE irvine32.inc
INCLUDE macros.inc
INCLUDELIB Winmm.lib

BUFFER = 5000
ENTRY  = 50


.data

    ;----------------------------
    ;-  SOME SOUND RELATED STUFF
    ;----------------------------

    BEGIN_GAME_SOUND db 'C:\Users\ABDUL\source\repos\Project5\Project5\pacman_intro.wav',0
    END_GAME_SOUND db 'C:\Users\ABDUL\source\repos\Project5\Project5\pacman_dies_y.wav',0
    
    PlaySound  PROTO, pszSound:PTR BYTE, hmod:DWORD, fdwSound:DWORD

    choice_01 DWORD ?
    GHOST_MOV_AUTO DWORD 0

    set_flag BYTE 0
    PAUS_FLAG BYTE 0

	;------------ [USER KA SCORE AND NAME] ---------

	save_name BYTE ENTRY DUP(?)
	save_score BYTE ?
	a1 DWORD ?
	a2 DWORD ?
    array byte BUFFER DUP(?)
    result byte BUFFER DUP(?)
    count DWORD 0
    v1 DWORD ?
    score_str DB 4 DUP(0)

	;------------ [FILE KA THORA DATA] ------------

	file byte "SCORE.txt", 0
	Handler Handle ?

    MOVE BYTE ?

	
    ;----------- MAIN STRUCTURAL REQUIREMENT OF THE PROGRAM ARE MENTIONED IN THIS SECTION. -----------
    
    H_BASE BYTE "------------------------------------------------------------------------------------------------------------------------",0
    TEMP BYTE ?
    LINE_BREAK BYTE "|",0ah,0

    x_pos BYTE 5
    y_pos BYTE 5

    
    ;-------------- SET COIN, STARS, ETC INFORMATION SECTION. ----------------
    
    coin_x BYTE ?
    coin_y BYTE ?
    STAR0_X BYTE ?
    STAR0_Y BYTE ?
    num_stars_1 BYTE 75
    star_coordinates db 150 dup(0)
    ;//SECTION - 

    
    STAR_X BYTE 7, 13, 13, 13, 13, 13, 13, 13, 19, 19, 19, 19, 19, 19, 19
            BYTE 7, 7, 7, 7, 7, 7, 26, 43, 60, 81, 98, 26, 43, 60, 81
            BYTE 98, 114, 105, 105, 105, 105, 105, 105, 105, 114, 114, 114
            BYTE 114, 114, 114, 30, 30, 30, 30, 30, 30, 94, 94, 94, 94
            BYTE 94, 94, 41, 41, 41, 41, 41, 41, 84, 84, 84, 84, 84, 84
            BYTE 45, 61, 78, 45, 60, 78

    
    STAR_Y BYTE 3, 3, 7, 11, 15, 19, 23, 27, 3, 7, 11, 15, 19, 23, 27
            BYTE 7, 11, 15, 19, 23, 27, 28, 28, 28, 28, 28, 3, 3, 3, 3
            BYTE 3, 3, 7, 11, 15, 19, 23, 27, 7, 11, 15, 19, 23, 27, 7
            BYTE 9, 14, 17, 21, 25, 3, 9, 15, 17, 21, 25, 3, 9, 12, 17
            BYTE 21, 25, 3, 9, 12, 17, 21, 25, 12, 10, 12, 17, 17, 17


    ;-------------- [BROAD CAST LIVES, LEVELS, & SCORE ] -------------

    LIVES BYTE 3
    LEVEL BYTE 1
    CHCEK BYTE 0
    SCORE BYTE 0

    ;-------------- [ SETTING GHOSTS ] ----------------

    ;-------------
    ;LVL_01 GHOSTS
    ;-------------

    GH1_L1_x db  11
    GH1_L1_y db  2
    mov_G1L1 db 'd'

    GH2_L1_x db  113
    GH2_L1_y db  20
    mov_G2L1 db 'd'

    ;-------------
    ;LVL_02 GHOSTS
    ;-------------

    GH1_L2_x db  18
    GH1_L2_y db  3
    mov_G1L2 db 'u'

    GH2_L2_x db  85
    GH2_L2_y db  3
    mov_G2L2 db 'd'

    GH3_L2_x db  60
    GH3_L2_y db  24
    mov_G3L2 db 'l'

    GH4_L2_x db  4
    GH4_L2_y db  4
    mov_G4L2 db 'r'

    GH5_L2_x db  48
    GH5_L2_y db  16
    mov_G5L2 db 'r'

    GH6_L2_x db  14
    GH6_L2_y db  5
    mov_G6L2 db 'd'

    GH7_L2_x db  77
    GH7_L2_y db  3
    mov_G7L2 db 'd'

    GH8_L2_x db  113
    GH8_L2_y db  5
    mov_G8L2 db 'd'

    GH9_L2_x db  3
    GH9_L2_y db  5
    mov_G9L2 db 'd'

    GH10_L2_x db  2
    GH10_L2_y db  15
    mov_G10L2 db 'd'

    GH11_L2_x db  116
    GH11_L2_y db  5
    mov_G11L2 db 'd'

    GH12_L2_x db  86
    GH12_L2_y db  3
    mov_G12L2 db 'd'

    GH13_L2_x db  44
    GH13_L2_y db  4
    mov_G13L2 db 'd'

    GH14_L2_x db  47
    GH14_L2_y db  3
    mov_G14L2 db 'd'

    ;--------------
    ;LVL_03 GHOSTS
    ;--------------

    partition byte "   -   ", 0


.code
main PROC

	mov eax, magenta (brown*1)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    call crlf
    mwrite "                       O)))))))         O)            O))     O))       O))        O)         O)))     O))  "
    call crlf
    mwrite "                       O))    O))      O) ))       O))   O))  O) O))   O)))       O) ))       O) O))   O))  "
    call crlf
    mwrite "                       O))    O))     O)  O))     O))         O)) O)) O O))      O)  O))      O)) O))  O))  "
    call crlf
    mwrite "                       O)))))))      O))   O))    O))         O))  O))  O))     O))   O))     O))  O)) O))  "
    call crlf
    mwrite "                       O))          O)))))) O))   O))         O))   O)  O))    O)))))) O))    O))   O) O))  "
    call crlf
    mwrite "                       O))         O))       O))   O))   O))  O))       O))   O))       O))   O))    O) ))  "
    call crlf
    mwrite "                       O))        O))         O))    O))))    O))       O))  O))         O))  O))      O))  "
    call crlf
    call crlf
    call crlf

    call crlf
    mwrite "                                              _      _____ _     ____  ____  _      _____  "
    call crlf                                    
    mwrite "                                             / \  /|/  __// \   /   _\/  _ \/ \__/|/  __/  "
    call crlf                                    
    mwrite "                                             | |  |||  \  | |   |  /  | / \|| |\/|||  \    "
    call crlf                                    
    mwrite "                                             | |/\|||  /_ | |_/\|  \__| \_/|| |  |||  /_   "
    call crlf                                    
    mwrite "                                             \_/  \|\____\\____/\____/\____/\_/  \|\____\  "
    call crlf                                    
    call crlf       
    
    mov eax, magenta (brown*1)
    call SetTextColor


    call waitmsg

    call CHOOSE_OPTIONS

    call clrscr

    call WRITE_TO_FILE

	exit
main ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INPUT_NAME PROC

    mov eax, magenta (black*16)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    mwrite "                             _____________________ ________.___  _________________________________________  "
    call crlf                      
    mwrite "                             \______   \_   _____//  _____/|   |/   _____/\__    ___/\_   _____/\______   \ "
    call crlf                      
    mwrite "                              |       _/|    __)_/   \  ___|   |\_____  \   |    |    |    __)_  |       _/ "
    call crlf                      
    mwrite "                              |    |   \|        \    \_\  \   |/        \  |    |    |        \ |    |   \ "
    call crlf                      
    mwrite "                              |____|_  /_______  /\______  /___/_______  /  |____|   /_______  / |____|_  / "
    call crlf                      
    mwrite "                                     \/        \/        \/            \/                    \/         \/  "
    call crlf                      
    call crlf

    mov dl,26
    mov dh,15
    call Gotoxy

	call crlf
    mwrite "                                                  -----------------------------------------"
    call crlf
	mwrite "                                                  | ==>  ENTER YOUR NAME :: {... "

	mov edx, OFFSET save_name
	mov ecx, ENTRY
	call readstring
	mov a2, eax

    call crlf
    mwrite "                                                   -----------------------------------------"
    call crlf
    mwrite "                                                   ==>  [ THANKS ALOT ] "
    call crlf
    mwrite "                                                   ==>  [ WILL SAVE DATA TO FILE.]"

    call crlf                               
    mwrite "                                                                 ------------------"
    call crlf                                                         
    mwrite "                                                                 |     DONE  :)    |"
    call crlf                                                         
    mwrite "                                                                 ------------------"
    call crlf
    call waitmsg

    mov set_flag, 1

	ret

INPUT_NAME ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
WRITE_TO_FILE PROC  

    mov edx, OFFSET file  
    call openinputfile  
    jc error_detected  
    mov Handler, eax  
    mov edx, OFFSET array  
    mov ecx, BUFFER  
    call readfromfile  
    mov eax, Handler  
    call closefile

    mov esi, 0  
    mov count, 0  
L:  
    mov al, array[esi]  
    mov result[esi], al  
    cmp al, 0  
    je bye  
    inc count  
    inc esi  
    jmp L  

bye:  
    mov edx, OFFSET file  
    call CREATEOUTPUTFILE  
    mov Handler, eax  

    mov result[esi], ' '  
    inc esi  

    mov ebx, 0  
M:  
    mov al, save_name[ebx]  
    mov result[esi], al  
    cmp al, 0  
    je append_score  
    inc esi  
    inc ebx  
    inc count  
    jmp M  

append_score:  
    mov result[esi], '-'  
    inc esi  
    inc count  

    movzx eax, SCORE  
    mov ecx, 10  
    xor edi, edi  
convert_loop:  
    mov edx, 0  
    div ecx  
    push dx  
    inc edi  
    test eax, eax  
    jnz convert_loop  

pop_loop:  
    pop dx  
    add dl, '0'  
    mov result[esi], dl  
    inc esi  
    inc count  
    dec edi  
    jnz pop_loop  

    ; Append '-LIVES'
    mov result[esi], '-'  
    inc esi  
    inc count  

    movzx eax, LIVES  
    mov ecx, 10  
    xor edi, edi  
lives_convert_loop:  
    xor edx, edx  
    div ecx  
    push dx  
    inc edi  
    test eax, eax  
    jnz lives_convert_loop  

lives_pop_loop:  
    pop dx  
    add dl, '0'  
    mov result[esi], dl  
    inc esi  
    inc count  
    dec edi  
    jnz lives_pop_loop  

    mov eax, esi  
    mov count, eax  
    mov eax, Handler  
    mov edx, OFFSET result  
    mov ecx, count  
    call WRITETOFILE  
    jc error_detected  
    jmp done  

error_detected:  
    call crlf  
    mwrite "UNABLE TO OPEN FILE."  

done:  
    call crlf  
    mwrite "DONE WITH THE PROGRAM. [TERMINATING]"  
    call crlf  

    ret  
WRITE_TO_FILE ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SHOW_HIGH_SCORE PROC

    mov eax, magenta (brown*1)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    call crlf
    mwrite "               __    __   __              __               ______                                               "
    call crlf
    mwrite "              |  \  |  \ |  \            |  \             /      \                                              "
    call crlf
    mwrite "              | $$  | $$  \$$   ______   | $$____        |  $$$$$$\   _______   ______     ______     ______    "
    call crlf
    mwrite "              | $$__| $$ |  \  /      \  | $$    \       | $$___\$$  /       \ /      \   /      \   /      \   "
    call crlf
    mwrite "              | $$    $$ | $$ |  $$$$$$\ | $$$$$$$\       \$$    \  |  $$$$$$$|  $$$$$$\ |  $$$$$$\ |  $$$$$$\  "
    call crlf
    mwrite "              | $$$$$$$$ | $$ | $$  | $$ | $$  | $$       _\$$$$$$\ | $$      | $$  | $$ | $$   \$$ | $$    $$  "
    call crlf
    mwrite "              | $$  | $$ | $$ | $$__| $$ | $$  | $$      |  \__| $$ | $$_____ | $$__/ $$ | $$       | $$$$$$$$  "
    call crlf
    mwrite "              | $$  | $$ | $$  \$$    $$ | $$  | $$       \$$    $$  \$$     \ \$$    $$ | $$        \$$     \  "
    call crlf
    mwrite "               \$$   \$$  \$$  _\$$$$$$$  \$$   \$$        \$$$$$$    \$$$$$$$  \$$$$$$   \$$         \$$$$$$$  "
    call crlf
    mwrite "                              |  \__| $$                                                                        "
    call crlf
    mwrite "                               \$$    $$                                                                        "
    call crlf
    mwrite "                                \$$$$$$                                                                         "
    call crlf
    call crlf
    call crlf
    
    mov edx, OFFSET file
    call openinputfile
    jc error_detected
    mov Handler, eax
    mov edx, OFFSET array
    mov ecx, BUFFER
    call READFROMFILE
    mov eax, Handler
    call closefile

    mov eax, red
    call SetTextColor

    call crlf
    mwrite "---------------------------------------------------------------------------------------------------------------"
    call crlf
    mov dh, 20
    mov dl, 4
    call gotoxy
    mov edx, OFFSET array
    call writestring
    call crlf
    mwrite "---------------------------------------------------------------------------------------------------------------"
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf

    call waitmsg

    error_detected:
        call crlf
        mwrite "UNABLE TO OPEN FILE."

    done:
        call crlf
        mwrite "DONE WITH THE PROGRAM. [TERMINATING]"
        call crlf

RET
SHOW_HIGH_SCORE ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHOOSE_OPTIONS PROC

    START_0:

    mov eax, magenta (brown*3)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    mwrite "                                   ____________________.____     _______________________________"
    call crlf
    mwrite "                                  /   _____/\_   _____/|    |    \_   _____/\_   ___ \__    ___/"
    call crlf
    mwrite "                                  \_____  \  |    __)_ |    |     |    __)_ /    \  \/ |    |   "
    call crlf
    mwrite "                                  /        \ |        \|    |___  |        \\     \____|    |   "
    call crlf
    mwrite "                                 /_______  //_______  /|_______ \/_______  / \______  /|____|   "
    call crlf
    mwrite "                                         \/         \/         \/        \/         \/          "
    call crlf
    call crlf

    call crlf                               
    mwrite "                                        -----------------------------------------"
    call crlf                               
    mwrite "                                        |       CHOOSE WHAT YOU WANT TO DO.     |"
    call crlf                               
    mwrite "                                        -----------------------------------------"
    call crlf                               
                                            
    call crlf                               
    mwrite "                                                      [1]. REGISTER. "
    call crlf                               
    mwrite "                                                      [2]. SEE RULES. "
    call crlf                                                 
    mwrite "                                                      [3]. HOW TO PLAY. "
    call crlf                               
    mwrite "                                                      [4]. { START PLAYING }"
    call crlf                               
    mwrite "                                                      [5]. { SEE HIGH SCORES}"
    call crlf
    mwrite "                                                      [0]. -> [EXIT] <- "
    call crlf                               
    mwrite "                                         -----------------------------------------"
    call crlf
    call crlf

    call readdec
    mov choice_01, eax

    cmp eax, 1
    je R_1

    cmp eax, 2
    je R_2

    cmp eax, 3
    je R_3

    cmp eax, 4
    je R_4

    cmp eax, 5
    je R_5

    cmp eax, 0
    je trying_exit_0
    
    jmp invalid_0

    R_1:
        call INPUT_NAME
        jmp START_0
    R_2:
        call SEE_RULES
        jmp START_0
    R_3:
        call PLAY_GUIDE
        jmp START_0
    R_4:
        call MAIN_GAME_FUN
        jmp trying_exit_0
    R_5:
        call SHOW_HIGH_SCORE
        jmp START_0

    invalid_0:
        call crlf
        mwrite "-------------------------------------------"
        call crlf
        mwrite "|       BAD INPUT DETECTED. RETURNING     |"
        call crlf
        mwrite "-------------------------------------------"
        call crlf
        call waitmsg
    jmp START_0

    trying_exit_0:
        ret

CHOOSE_OPTIONS ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SEE_RULES PROC

    mov eax,yellow (brown*17)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    mwrite "                                __________ ____ ___.____     ___________ _________  "
    call crlf                            
    mwrite "                                \______   \    |   \    |    \_   _____//   _____/  "
    call crlf                            
    mwrite "                                 |       _/    |   /    |     |    __)_ \_____  \   "
    call crlf                            
    mwrite "                                 |    |   \    |  /|    |___  |        \/        \  "
    call crlf                            
    mwrite "                                 |____|_  /______/ |_______ \/_______  /_______  /  "
    call crlf                            
    mwrite "                                        \/                 \/        \/        \/   "
    call crlf                            
    call crlf                            
    call crlf

    call crlf
    call crlf
    mwrite "                             ------------------------------------------------------------"
    call crlf
    mwrite "                             |            WELCOME TO THE FAIR PLAY ZONE!                |"
    call crlf                             
    mwrite "                             ------------------------------------------------------------"
    call crlf
    mwrite "                             |            HERE ARE THE RULES TO FOLLOW:                 |"
    call crlf                             
    mwrite "                             |       [1]. RESPECT ALL PARTICIPANTS.                     |"
    call crlf                             
    mwrite "                             |       [2]. PLAY FAIR AND AVOID CHEATING.                 |"
    call crlf                            
    mwrite "                             |       [3]. ANY DISPUTES WILL BE RESOLVED AMICABLY.       |"
    call crlf                             
    mwrite "                             |       [4]. ENJOY THE GAME AND HAVE FUN.                  |"
    call crlf                             
    mwrite "                             |          REMEMBER: GOOD SPORTSMANSHIP IS KEY.            |"
    call crlf                             
    mwrite "                             |     WINNING IS GREAT, BUT INTEGRITY MATTERS MORE.        |"
    call crlf                             
    mwrite "                             |          ENCOURAGE OTHERS TO DO THEIR BEST.              |"
    call crlf                             
    mwrite "                             |    LET'S MAKE THIS A MEMORABLE EXPERIENCE FOR EVERYONE.  |"
    call crlf                             
    mwrite "                             ------------------------------------------------------------"
    call crlf
    call crlf
    call waitmsg

ret
SEE_RULES ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PLAY_GUIDE PROC

    mov eax,yellow (brown*16)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    mwrite "                                   ________ ____ ___.___________  ___________  "
    call crlf                         
    mwrite "                                  /  _____/|    |   \   \______ \ \_   _____/  "
    call crlf                         
    mwrite "                                 /   \  ___|    |   /   ||    |  \ |    __)_   "
    call crlf                         
    mwrite "                                 \    \_\  \    |  /|   ||    `   \|        \  "
    call crlf                         
    mwrite "                                  \______  /______/ |___/_______  /_______  /  "
    call crlf                         
    mwrite "                                         \/                     \/        \/   "
    call crlf                         
    call crlf
    call crlf

    call crlf
    call crlf
    MWRITE "                             ------------------------------------------------------------"
    call crlf                        
    MWRITE "                             |               WELCOME TO THE INSTRUCTIONS  !             |"
    call crlf                             
    MWRITE "                             ------------------------------------------------------------"
    call crlf                        
    MWRITE "                             |         YOU HAVE TO FOLLOW THESE INSTRUCTIONS:           |"
    call crlf                             
    MWRITE "                             |       [1]. THERE ARE 3 LEVELS WITH DIFFERENT COMPLEXITY. |"
    call crlf                             
    MWRITE "                             |       [2]. PLAYER MOVEMENT IS CONTROLLED BY:             |"
    call crlf                        
    MWRITE "                             |           W = UP, A = LEFT, S = RIGHT, Z = DOWN.         |"
    call crlf                            
    MWRITE "                             |       [3]. COLLECT COINS TO INCREASE YOUR SCORE BY 1.    |"
    call crlf                             
    MWRITE "                             |       [4]. BEWARE OF THE GHOST.                          |"
    call crlf                             
    MWRITE "                             |       [5]. PRESS '1' TO START THE GAME.                  |"
    call crlf                             
    MWRITE "                             |       [6]. PRESS '0' TO QUIT THE GAME.                   |"
    call crlf                             
    MWRITE "                             |       [7]. FRUIT INCREASES YOUR SCORE BY 5.              |"
    call crlf
    MWRITE "                             |       [8]. BAD INPUT == { 3 SECONDS FREEZ }              |"
    call crlf
    MWRITE "                             ------------------------------------------------------------"
    call crlf
    call crlf
    call waitmsg

    ret
PLAY_GUIDE ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;//SECTION - 
MAIN_GAME_FUN PROC

    cmp set_flag, 1
    je already_registered

    call INPUT_NAME

    already_registered:

    call DISPLAY_LVL_01
    
    mov eax,black (black)
    call SetTextColor
    call clrscr

    mov eax,lightGreen (lightGreen * 16)
    call SetTextColor

    mov eax, 900
    call delay
    mov dl, 0
    mov dh, 29
    call Gotoxy
    mov edx,OFFSET H_BASE
    call WriteString

    mov dl, 0
    mov dh, 1
    call Gotoxy
    mov edx,OFFSET H_BASE
    call WriteString

    ; RIGHT SIDE VERTICAL LINE.

    mov ecx, 27
    mov dh, 2
    mov TEMP, dh
    L_1:
        mov dh, TEMP
        mov dl,0
        call Gotoxy
        mov edx,OFFSET LINE_BREAK
        call WriteString
        inc TEMP
    loop L_1

    mov ecx,27
    mov dh,2
    mov TEMP,dh
    L_2:
        mov dh,TEMP
        mov dl,119
        call Gotoxy
        mwrite "|"
        inc TEMP
    loop L_2

    ;-------------- MAKING FIRST 2 ----------------
    
    mov ecx,20
    mov dl,20
    mov TEMP,dl
    L_6:
        mov dl,TEMP
        mov dh,5
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_6

    mov ecx, 8
    mov dh, 5
    mov TEMP,dh
    L_6_1:
        mov dh,TEMP
        mov dl, 40
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_6_1

    mov ecx,20
    mov dl,20
    mov TEMP,dl
    L_6_2:
        mov dl,TEMP
        mov dh,13
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_6_2

    mov ecx, 8
    mov dh, 14
    mov TEMP,dh
    L_6_3:
        mov dh,TEMP
        mov dl, 20
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_6_3

    mov ecx,20
    mov dl,20
    mov TEMP,dl
    L_6_4:
        mov dl,TEMP
        mov dh, 22
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_6_4


    ;-------------  MAKING SECOND TWO. -----------------

    mov ecx, 20
    mov dl, 50
    mov TEMP,dl
    L_7:
        mov dl,TEMP
        mov dh,5
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_7

    ;//REVIEW -
    mov ecx, 8
    mov dh, 5
    mov TEMP,dh
    L_7_1:
        mov dh,TEMP
        mov dl, 70
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_7_1

    mov ecx,20
    mov dl, 50
    mov TEMP,dl
    L_7_2:
        mov dl,TEMP
        mov dh,13
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_7_2

    mov ecx, 8
    mov dh, 14
    mov TEMP,dh
    L_7_3:
        mov dh,TEMP
        mov dl, 50
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_7_3

    mov ecx, 20
    mov dl, 50
    mov TEMP,dl
    L_7_4:
        mov dl,TEMP
        mov dh, 22
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_7_4

    ;--------------  ONE MAKING HERE. --------------------

    mov ecx, 18
    mov dh, 5
    mov TEMP,dh
    L_8:
        mov dh,TEMP
        mov dl, 80
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_8

    ;--------------  FOUR MAKING HERE. --------------------

    mov ecx, 9
    mov dh, 5
    mov TEMP,dh
    L_9_1:
        mov dh,TEMP
        mov dl, 90
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_9_1
 

    mov ecx, 20
    mov dl, 90
    mov TEMP,dl
    L_9:
        mov dl,TEMP
        mov dh, 13
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_9

    mov ecx, 9
    mov dh, 5
    mov TEMP,dh
    L_9_3:
        mov dh,TEMP
        mov dl, 110
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_9_3

    mov ecx, 11
    mov dh, 12
    mov TEMP,dh
    L_9_2:
        mov dh,TEMP
        mov dl, 110
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_9_2

    ;ANDER[NECHY] WALI HORIZONTAL LINE.
    
    mov ecx,90
    mov dl,20
    mov TEMP,dl
    L_10:
        mov dl,TEMP
        mov dh,26
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_10

    call DRAW_PLAYER_LV1
    call PRINT_LVL1_STAR
    call BEGIN_GAME_01
    call crlf
    call waitmsg


ret
MAIN_GAME_FUN ENDP

;------------------- [THIS SECTION CONTAINS FUNCTION TO MAINTAIN THE MOVEMENT OF GHOSTAS AT LVL.1]

PRINT_G1_L1 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH1_L1_x
    mov dh, GH1_L1_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G1_L1 ENDP

;;;;;;;;;;;;;;;;
MOV_G1_L1  PROC
    mov dl,GH1_L1_x 
    mov dh,GH1_L1_y
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, mov_G1L1 
    cmp al, 'd'
    je CLICK
    
    dec GH1_L1_y 
    jmp endG1
        
    CLICK:
        inc GH1_L1_y   
    endG1:
        cmp GH1_L1_y , 28
        je pos_up
        cmp GH1_L1_y , 2
        je pos_down
        jmp done
    pos_up:
        mov mov_G1L1 , 'u'
        jmp done
    pos_down:
        mov mov_G1L1 , 'd'   
    done:
        ret
MOV_G1_L1 ENDP
;;;;;;;;;;;;;;;;
COLIDE_G1_L1 PROC
    cmp bh, GH1_L1_y
    jne done
    cmp bl, GH1_L1_x
    jne done
    dec LIVES
    mov al, 1
    done:
      ret
COLIDE_G1_L1 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;
PRINT_G2_L1 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH2_L1_x
    mov dh, GH2_L1_y 
    call Gotoxy
    mov al,"@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G2_L1 ENDP

MOV_G2_L1 PROC
    
    mov dl, GH2_L1_x
    mov dh, GH2_L1_y
    call Gotoxy
    mov al, " "
    call WriteChar

    cmp mov_G2L1, 'd'
    je CLICK
    
    dec GH2_L1_y
    jmp check_bounds

    CLICK:
        inc GH2_L1_y

    check_bounds:
        cmp GH2_L1_y, 28
        je pos_up       
        cmp GH2_L1_y, 2 
        je pos_down     
        jmp done

    pos_up:
        mov mov_G2L1, 'u' 
        jmp done

    pos_down:
        mov mov_G2L1, 'd'

    done:
        ret
MOV_G2_L1 ENDP


;;;;;;;;;;;;;;;;;;;
COLIDE_G2_L1 PROC
    cmp bh, GH2_L1_y 
    jne done
    cmp bl, GH2_L1_x 
    jne done

    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1
    done:
      ret
COLIDE_G2_L1 ENDP


;-----------------
; GHOST LVL_02 FUN
;-----------------

PRINT_G1_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH1_L2_x
    mov dh, GH1_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G1_L2 ENDP

;;;;;;;;;;;;;
MOV_G1_L2  PROC
    mov dl, GH1_L2_x 
    mov dh, GH1_L2_y
    call Gotoxy
    mov al, " "
    call WriteChar
    
    mov al, mov_G1L2 
    cmp al, 'd'
    je CLICK
    
    dec GH1_L2_y 
    jmp endG1    
    CLICK:
        inc GH1_L2_y   
    endG1:
        cmp GH1_L2_y , 28
        je pos_up
        cmp GH1_L2_y , 2
        je pos_down
        jmp done
    pos_up:
        mov mov_G1L2 , 'u'
        jmp done    
    pos_down:
        mov mov_G1L2 , 'd'   
    done:
        ret
MOV_G1_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G1_L2 PROC
    cmp bh, GH1_L2_y 
    jne done
    cmp bl, GH1_L2_x 
    jne done
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1
    done:
      ret
COLIDE_G1_L2 ENDP

;;;;;;;;;;;;;;;;;;;;;
PRINT_G2_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH2_L2_x
    mov dh, GH2_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G2_L2 ENDP

;;;;;;;;;;;;;
MOV_G2_L2  PROC
    mov dl,GH2_L2_x 
    mov dh,GH2_L2_y
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, mov_G2L2 
    cmp al, 'd'
    je CLICK
    
    dec GH2_L2_y 
    jmp endG1    
    CLICK:
        inc GH2_L2_y
    endG1:
        cmp GH2_L2_y , 25
        je pos_up
        cmp GH2_L2_y , 3
        je pos_down
        jmp done
    pos_up:
        mov mov_G2L2 , 'u'
        jmp done    
    pos_down:
        mov mov_G2L2 , 'd'   
    done:
        ret
MOV_G2_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G2_L2 PROC
    cmp bh, GH2_L2_y 
    jne done
    cmp bl, GH2_L2_x 
    jne done
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1
    done:
      ret
COLIDE_G2_L2 ENDP

;;;;;;;;;;;;;;;;;;;
PRINT_G3_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH3_L2_x
    mov dh, GH3_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G3_L2 ENDP

;;;;;;;;;;;;;
MOV_G3_L2  PROC
    mov dl, GH3_L2_x 
    mov dh, GH3_L2_y
    call Gotoxy
    mov al, " "
    call WriteChar
    
    mov al, mov_G3L2 
    cmp al, 'l'
    je left
    
    dec GH3_L2_x 
    jmp endG1    
    left:
        inc GH3_L2_x   
    endG1:
        cmp GH3_L2_x , 13
        je pos_left
        cmp GH3_L2_x , 118
        je pos_right
        jmp done
    pos_left:
        mov mov_G3L2 , 'l'
        jmp done    
    pos_right:
        mov mov_G3L2 , 'r'   
    done:
        ret
MOV_G3_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G3_L2 PROC
    cmp bh, GH2_L2_y 
    jne done
    cmp bl, GH2_L2_x 
    jne done
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1
    done:
      ret
COLIDE_G3_L2 ENDP

;;;;;;;;;;;;;;;;;;;
PRINT_G4_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH4_L2_x
    mov dh, GH4_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G4_L2 ENDP

;;;;;;;;;;;;;
MOV_G4_L2  PROC
    mov dl, GH4_L2_x
    mov dh, GH4_L2_y
    call Gotoxy
    mov al, " "
    call WriteChar
    
    mov al, mov_G4L2 
    cmp al, 'l'
    je left
    
    dec GH4_L2_x 
    jmp endG1    
    left:
        inc GH4_L2_x
        inc GH4_L2_x
    endG1:
        cmp GH4_L2_x , 2
        je pos_left
        cmp GH4_L2_x , 116
        je pos_right
        jmp done
    pos_left:
        mov mov_G4L2 , 'l'
        jmp done    
    pos_right:
        mov mov_G4L2 , 'r'   
    done:
        ret
MOV_G4_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G4_L2 PROC
    cmp bh, GH4_L2_y 
    jne done
    cmp bl, GH4_L2_x 
    jne done
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1
    done:
      ret
COLIDE_G4_L2 ENDP

;;;;;;;;;;;;;;;;;;
PRINT_G5_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH5_L2_x
    mov dh, GH5_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G5_L2 ENDP

;;;;;;;;;;;;;
MOV_G5_L2  PROC
    mov dl, GH5_L2_x 
    mov dh, GH5_L2_y
    call Gotoxy
    mov al, " "
    call WriteChar
    
    mov al, mov_G5L2 
    cmp al, 'l'
    je left
    
    dec GH5_L2_x 
    jmp endG1    
    left:
        inc GH5_L2_x   
    endG1:
        cmp GH5_L2_x , 24
        je pos_left
        cmp GH5_L2_x , 49
        je pos_right
        jmp done
    pos_left:
        mov mov_G5L2 , 'l'
        jmp done    
    pos_right:
        mov mov_G5L2 , 'r'   
    done:
        ret
MOV_G5_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G5_L2 PROC
    cmp bh, GH5_L2_y 
    jne done
    cmp bl, GH5_L2_x 
    jne done
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1
    done:
      ret
COLIDE_G5_L2 ENDP

;;;;;;;;;;;;;;;;;;;;;
PRINT_G6_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH6_L2_x
    mov dh, GH6_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G6_L2 ENDP

;;;;;;;;;;;;;
MOV_G6_L2  PROC
    mov dl,GH6_L2_x 
    mov dh,GH6_L2_y
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, mov_G6L2 
    cmp al, 'u'
    je CLICK
    
    dec GH6_L2_y 
    jmp endG1    
    CLICK:
        inc GH6_L2_y
    endG1:
        cmp GH6_L2_y , 3
        je pos_up
        cmp GH6_L2_y , 27
        je pos_down
        jmp done
    pos_up:
        mov mov_G6L2 , 'u'
        jmp done    
    pos_down:
        mov mov_G6L2 , 'd'   
    done:
        ret
MOV_G6_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G6_L2 PROC
    cmp bh, GH6_L2_y 
    jne done
    cmp bl, GH6_L2_x 
    jne done
    
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1

    done:
      ret
COLIDE_G6_L2 ENDP


;;;;;;;;;;;;;;;;;;;;;
PRINT_G7_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH7_L2_x
    mov dh, GH7_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G7_L2 ENDP

;;;;;;;;;;;;;
MOV_G7_L2  PROC
    mov dl,GH7_L2_x 
    mov dh,GH7_L2_y
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, mov_G7L2 
    cmp al, 'd'
    je CLICK
    
    dec GH7_L2_y 
    jmp endG1    
    CLICK:
        inc GH7_L2_y
    endG1:
        cmp GH7_L2_y , 25
        je pos_up
        cmp GH7_L2_y , 3
        je pos_down
        jmp done
    pos_up:
        mov mov_G7L2 , 'u'
        jmp done    
    pos_down:
        mov mov_G7L2 , 'd'   
    done:
        ret
MOV_G7_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G7_L2 PROC
    cmp bh, GH7_L2_y 
    jne done
    cmp bl, GH7_L2_x 
    jne done
    
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1

    done:
      ret
COLIDE_G7_L2 ENDP


;;;;;;;;;;;;;;;;;;;;;
PRINT_G8_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH8_L2_x
    mov dh, GH8_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G8_L2 ENDP

;;;;;;;;;;;;;
MOV_G8_L2  PROC
    mov dl,GH8_L2_x 
    mov dh,GH8_L2_y
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, mov_G8L2 
    cmp al, 'u'
    je CLICK
    
    dec GH8_L2_y 
    jmp endG1    
    CLICK:
        inc GH8_L2_y
    endG1:
        cmp GH8_L2_y , 3
        je pos_up
        cmp GH8_L2_y , 27
        je pos_down
        jmp done
    pos_up:
        mov mov_G8L2 , 'u'
        jmp done    
    pos_down:
        mov mov_G8L2 , 'd'   
    done:
        ret
MOV_G8_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G8_L2 PROC
    cmp bh, GH8_L2_y 
    jne done
    cmp bl, GH8_L2_x 
    jne done
    
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1

    done:
      ret
COLIDE_G8_L2 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;
PRINT_G9_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH9_L2_x
    mov dh, GH9_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G9_L2 ENDP

;;;;;;;;;;;;;
MOV_G9_L2  PROC
    mov dl,GH9_L2_x 
    mov dh,GH9_L2_y
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, mov_G9L2 
    cmp al, 'u'
    je CLICK
    
    dec GH9_L2_y 
    jmp endG1    
    CLICK:
        inc GH9_L2_y
    endG1:
        cmp GH9_L2_y , 3
        je pos_up
        cmp GH9_L2_y , 27
        je pos_down
        jmp done
    pos_up:
        mov mov_G9L2 , 'u'
        jmp done    
    pos_down:
        mov mov_G9L2 , 'd'   
    done:
        ret
MOV_G9_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G9_L2 PROC
    cmp bh, GH9_L2_y 
    jne done
    cmp bl, GH9_L2_x 
    jne done
    
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1

    done:
      ret
COLIDE_G9_L2 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;
PRINT_G10_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH10_L2_x
    mov dh, GH10_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G10_L2 ENDP

;;;;;;;;;;;;;
MOV_G10_L2  PROC
    mov dl,GH10_L2_x 
    mov dh,GH10_L2_y
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, mov_G10L2 
    cmp al, 'u'
    je CLICK
    
    dec GH10_L2_y 
    jmp endG1    
    CLICK:
        inc GH10_L2_y
    endG1:
        cmp GH10_L2_y , 3
        je pos_up
        cmp GH10_L2_y , 27
        je pos_down
        jmp done
    pos_up:
        mov mov_G10L2 , 'u'
        jmp done    
    pos_down:
        mov mov_G10L2 , 'd'   
    done:
        ret
MOV_G10_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G10_L2 PROC
    cmp bh, GH10_L2_y 
    jne done
    cmp bl, GH10_L2_x 
    jne done
    
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1

    done:
      ret
COLIDE_G10_L2 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;
PRINT_G11_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH11_L2_x
    mov dh, GH11_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G11_L2 ENDP

;;;;;;;;;;;;;
MOV_G11_L2  PROC
    mov dl,GH11_L2_x 
    mov dh,GH11_L2_y
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, mov_G11L2 
    cmp al, 'u'
    je CLICK
    
    dec GH11_L2_y 
    jmp endG1    
    CLICK:
        inc GH11_L2_y
    endG1:
        cmp GH11_L2_y , 3
        je pos_up
        cmp GH11_L2_y , 27
        je pos_down
        jmp done
    pos_up:
        mov mov_G11L2 , 'u'
        jmp done    
    pos_down:
        mov mov_G11L2 , 'd'   
    done:
        ret
MOV_G11_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G11_L2 PROC
    cmp bh, GH11_L2_y 
    jne done
    cmp bl, GH11_L2_x 
    jne done
    
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1

    done:
      ret
COLIDE_G11_L2 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;
PRINT_G12_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH12_L2_x
    mov dh, GH12_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G12_L2 ENDP

;;;;;;;;;;;;;
MOV_G12_L2  PROC
    mov dl,GH12_L2_x 
    mov dh,GH12_L2_y
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, mov_G12L2 
    cmp al, 'd'
    je CLICK
    
    dec GH12_L2_y 
    jmp endG1    
    CLICK:
        inc GH12_L2_y
    endG1:
        cmp GH12_L2_y , 25
        je pos_up
        cmp GH12_L2_y , 3
        je pos_down
        jmp done
    pos_up:
        mov mov_G12L2 , 'u'
        jmp done    
    pos_down:
        mov mov_G12L2 , 'd'   
    done:
        ret
MOV_G12_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G12_L2 PROC
    cmp bh, GH12_L2_y 
    jne done
    cmp bl, GH12_L2_x 
    jne done
    
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1

    done:
      ret
COLIDE_G12_L2 ENDP


;;;;;;;;;;;;;;;;;;;;;;;;
PRINT_G13_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH13_L2_x
    mov dh, GH13_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G13_L2 ENDP

;;;;;;;;;;;;;
MOV_G13_L2  PROC
    mov dl,GH13_L2_x 
    mov dh,GH13_L2_y
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, mov_G13L2 
    cmp al, 'd'
    je CLICK
    
    dec GH13_L2_y 
    jmp endG1    
    CLICK:
        inc GH13_L2_y
    endG1:
        cmp GH13_L2_y , 25
        je pos_up
        cmp GH13_L2_y , 3
        je pos_down
        jmp done
    pos_up:
        mov mov_G13L2 , 'u'
        jmp done    
    pos_down:
        mov mov_G13L2 , 'd'   
    done:
        ret
MOV_G13_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G13_L2 PROC
    cmp bh, GH13_L2_y 
    jne done
    cmp bl, GH13_L2_x 
    jne done
    
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1

    done:
      ret
COLIDE_G13_L2 ENDP


;;;;;;;;;;;;;;;;;;;;;;;;
PRINT_G14_L2 PROC

    mov eax, red (red*16)
    call SetTextColor

    mov dl, GH14_L2_x
    mov dh, GH14_L2_y 
    call Gotoxy
    mov al, "@"
    call WriteChar

    mov eax, white
    call SetTextColor

    ret
PRINT_G14_L2 ENDP

;;;;;;;;;;;;;
MOV_G14_L2  PROC
    mov dl,GH14_L2_x 
    mov dh,GH14_L2_y
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, mov_G14L2 
    cmp al, 'd'
    je CLICK
    
    dec GH14_L2_y 
    jmp endG1    
    CLICK:
        inc GH14_L2_y
    endG1:
        cmp GH14_L2_y , 25
        je pos_up
        cmp GH14_L2_y , 3
        je pos_down
        jmp done
    pos_up:
        mov mov_G14L2 , 'u'
        jmp done    
    pos_down:
        mov mov_G14L2 , 'd'   
    done:
        ret
MOV_G14_L2 ENDP

;;;;;;;;;;;;;
COLIDE_G14_L2 PROC
    cmp bh, GH14_L2_y 
    jne done
    cmp bl, GH14_L2_x 
    jne done
    
    cmp LIVES, 1
    jge DO_NEG
    jmp done

    DO_NEG:
        dec LIVES
        mov al, 1

    done:
      ret
COLIDE_G14_L2 ENDP


;--------------------
; GHOSTS LVL_03 FUN
;--------------------


;;;;;;;;;;;;;;;;;;;;;;;;;;
DRAW_PLAYER_LV1 PROC

    mov eax, brown (brown*16)
    call SetTextColor

    mov dl, x_pos
    mov dh, y_pos
    call Gotoxy
    
    mov al, "#"    
    call WriteChar

    mov eax, brown
    call SetTextColor

ret
DRAW_PLAYER_LV1 ENDP

;;;;;;;;;;;;;;;;;;;
CHANGE_PLAYER PROC

    mov dl, x_pos
    mov dh, y_pos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
CHANGE_PLAYER ENDP

;;;;;;;;;;;;;;;;;;
PRINT_COIN PROC

    mov eax,yellow
    call SetTextColor
    mov dl, coin_x
    mov dh, coin_y
    call Gotoxy
    mov al,"O"
    call WriteChar
    ret
PRINT_COIN ENDP

;;;;;;;;;;;;;;;;;;
PRINT_STAR PROC
    
    mov eax, lightRed
    call SetTextColor
    mov dl, STAR0_X
    mov dh, STAR0_Y
    call Gotoxy
    mov al, "*"
    call WriteChar
    ret

PRINT_STAR ENDP


;;;------------------------------
;;;------[LVL-1 STAR PRINT]------
;;;------------------------------
PRINT_LVL1_STAR PROC

    ; Star 1
    mov al, STAR_X[0]
    mov star_coordinates[0], al
    mov STAR0_X, al
    mov al, STAR_Y[0]
    mov star_coordinates[1], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 2
    mov al, STAR_X[1]
    mov star_coordinates[2], al
    mov STAR0_X, al
    mov al, STAR_Y[1]
    mov star_coordinates[3], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 3
    mov al, STAR_X[2]
    mov star_coordinates[4], al
    mov STAR0_X, al
    mov al, STAR_Y[2]
    mov star_coordinates[5], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 4
    mov al, STAR_X[3]
    mov star_coordinates[6], al
    mov STAR0_X, al
    mov al, STAR_Y[3]
    mov star_coordinates[7], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 5
    mov al, STAR_X[4]
    mov star_coordinates[8], al
    mov STAR0_X, al
    mov al, STAR_Y[4]
    mov star_coordinates[9], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 6
    mov al, STAR_X[5]
    mov star_coordinates[10], al
    mov STAR0_X, al
    mov al, STAR_Y[5]
    mov star_coordinates[11], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 7
    mov al, STAR_X[6]
    mov star_coordinates[12], al
    mov STAR0_X, al
    mov al, STAR_Y[6]
    mov star_coordinates[13], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 8
    mov al, STAR_X[7]
    mov star_coordinates[14], al
    mov STAR0_X, al
    mov al, STAR_Y[7]
    mov star_coordinates[15], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 9
    mov al, STAR_X[8]
    mov star_coordinates[16], al
    mov STAR0_X, al
    mov al, STAR_Y[8]
    mov star_coordinates[17], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 10
    mov al, STAR_X[9]
    mov star_coordinates[18], al
    mov STAR0_X, al
    mov al, STAR_Y[9]
    mov star_coordinates[19], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 11
    mov al, STAR_X[10]
    mov star_coordinates[20], al
    mov STAR0_X, al
    mov al, STAR_Y[10]
    mov star_coordinates[21], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 12
    mov al, STAR_X[11]
    mov star_coordinates[22], al
    mov STAR0_X, al
    mov al, STAR_Y[11]
    mov star_coordinates[23], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 13
    mov al, STAR_X[12]
    mov star_coordinates[24], al
    mov STAR0_X, al
    mov al, STAR_Y[12]
    mov star_coordinates[25], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 14
    mov al, STAR_X[13]
    mov star_coordinates[26], al
    mov STAR0_X, al
    mov al, STAR_Y[13]
    mov star_coordinates[27], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 15
    mov al, STAR_X[14]
    mov star_coordinates[28], al
    mov STAR0_X, al
    mov al, STAR_Y[14]
    mov star_coordinates[29], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 16
    mov al, STAR_X[15]
    mov star_coordinates[30], al
    mov STAR0_X, al
    mov al, STAR_Y[15]
    mov star_coordinates[31], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 17
    mov al, STAR_X[16]
    mov star_coordinates[32], al
    mov STAR0_X, al
    mov al, STAR_Y[16]
    mov star_coordinates[33], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 18
    mov al, STAR_X[17]
    mov star_coordinates[34], al
    mov STAR0_X, al
    mov al, STAR_Y[17]
    mov star_coordinates[35], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 19
    mov al, STAR_X[18]
    mov star_coordinates[36], al
    mov STAR0_X, al
    mov al, STAR_Y[18]
    mov star_coordinates[37], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 20
    mov al, STAR_X[19]
    mov star_coordinates[38], al
    mov STAR0_X, al
    mov al, STAR_Y[19]
    mov star_coordinates[39], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 21
    mov al, STAR_X[20]
    mov star_coordinates[40], al
    mov STAR0_X, al
    mov al, STAR_Y[20]
    mov star_coordinates[41], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 22
    mov al, STAR_X[21]
    mov star_coordinates[42], al
    mov STAR0_X, al
    mov al, STAR_Y[21]
    mov star_coordinates[43], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 23
    mov al, STAR_X[22]
    mov star_coordinates[44], al
    mov STAR0_X, al
    mov al, STAR_Y[22]
    mov star_coordinates[45], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 24
    mov al, STAR_X[23]
    mov star_coordinates[46], al
    mov STAR0_X, al
    mov al, STAR_Y[23]
    mov star_coordinates[47], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 25
    mov al, STAR_X[24]
    mov star_coordinates[48], al
    mov STAR0_X, al
    mov al, STAR_Y[24]
    mov star_coordinates[49], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 26
    mov al, STAR_X[25]
    mov star_coordinates[50], al
    mov STAR0_X, al
    mov al, STAR_Y[25]
    mov star_coordinates[51], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 27
    mov al, STAR_X[26]
    mov star_coordinates[52], al
    mov STAR0_X, al
    mov al, STAR_Y[26]
    mov star_coordinates[53], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 28
    mov al, STAR_X[27]
    mov star_coordinates[54], al
    mov STAR0_X, al
    mov al, STAR_Y[27]
    mov star_coordinates[55], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 29
    mov al, STAR_X[28]
    mov star_coordinates[56], al
    mov STAR0_X, al
    mov al, STAR_Y[28]
    mov star_coordinates[57], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 30
    mov al, STAR_X[29]
    mov star_coordinates[58], al
    mov STAR0_X, al
    mov al, STAR_Y[29]
    mov star_coordinates[59], al
    mov STAR0_Y, al
    call PRINT_STAR

    ; Star 31
    mov al, STAR_X[30]
    mov star_coordinates[60], al
    mov STAR0_X, al
    mov al, STAR_Y[30]
    mov star_coordinates[61], al
    mov STAR0_Y, al
    call PRINT_STAR

        ; Star 32  
    mov al, STAR_X[31]  
    mov star_coordinates[62], al  
    mov STAR0_X, al  
    mov al, STAR_Y[31]  
    mov star_coordinates[63], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 33  
    mov al, STAR_X[32]  
    mov star_coordinates[64], al  
    mov STAR0_X, al  
    mov al, STAR_Y[32]  
    mov star_coordinates[65], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 34  
    mov al, STAR_X[33]  
    mov star_coordinates[66], al  
    mov STAR0_X, al  
    mov al, STAR_Y[33]  
    mov star_coordinates[67], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 35  
    mov al, STAR_X[34]  
    mov star_coordinates[68], al  
    mov STAR0_X, al  
    mov al, STAR_Y[34]  
    mov star_coordinates[69], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 36  
    mov al, STAR_X[35]  
    mov star_coordinates[70], al  
    mov STAR0_X, al  
    mov al, STAR_Y[35]  
    mov star_coordinates[71], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 37  
    mov al, STAR_X[36]  
    mov star_coordinates[72], al  
    mov STAR0_X, al  
    mov al, STAR_Y[36]  
    mov star_coordinates[73], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 38  
    mov al, STAR_X[37]  
    mov star_coordinates[74], al  
    mov STAR0_X, al  
    mov al, STAR_Y[37]  
    mov star_coordinates[75], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 39  
    mov al, STAR_X[38]  
    mov star_coordinates[76], al  
    mov STAR0_X, al  
    mov al, STAR_Y[38]  
    mov star_coordinates[77], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 40  
    mov al, STAR_X[39]  
    mov star_coordinates[78], al  
    mov STAR0_X, al  
    mov al, STAR_Y[39]  
    mov star_coordinates[79], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 41  
    mov al, STAR_X[40]  
    mov star_coordinates[80], al  
    mov STAR0_X, al  
    mov al, STAR_Y[40]  
    mov star_coordinates[81], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 42  
    mov al, STAR_X[41]  
    mov star_coordinates[82], al  
    mov STAR0_X, al  
    mov al, STAR_Y[41]  
    mov star_coordinates[83], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 43  
    mov al, STAR_X[42]  
    mov star_coordinates[84], al  
    mov STAR0_X, al  
    mov al, STAR_Y[42]  
    mov star_coordinates[85], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 44  
    mov al, STAR_X[43]  
    mov star_coordinates[86], al  
    mov STAR0_X, al  
    mov al, STAR_Y[43]  
    mov star_coordinates[87], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 45  
    mov al, STAR_X[44]  
    mov star_coordinates[88], al  
    mov STAR0_X, al  
    mov al, STAR_Y[44]  
    mov star_coordinates[89], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 46  
    mov al, STAR_X[45]  
    mov star_coordinates[90], al  
    mov STAR0_X, al  
    mov al, STAR_Y[45]  
    mov star_coordinates[91], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 47  
    mov al, STAR_X[46]  
    mov star_coordinates[92], al  
    mov STAR0_X, al  
    mov al, STAR_Y[46]  
    mov star_coordinates[93], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 48  
    mov al, STAR_X[47]  
    mov star_coordinates[94], al  
    mov STAR0_X, al  
    mov al, STAR_Y[47]  
    mov star_coordinates[95], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 49  
    mov al, STAR_X[48]  
    mov star_coordinates[96], al  
    mov STAR0_X, al  
    mov al, STAR_Y[48]  
    mov star_coordinates[97], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 50  
    mov al, STAR_X[49]  
    mov star_coordinates[98], al  
    mov STAR0_X, al  
    mov al, STAR_Y[49]  
    mov star_coordinates[99], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 51  
    mov al, STAR_X[50]  
    mov star_coordinates[100], al  
    mov STAR0_X, al  
    mov al, STAR_Y[50]  
    mov star_coordinates[101], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 52  
    mov al, STAR_X[51]  
    mov star_coordinates[102], al  
    mov STAR0_X, al  
    mov al, STAR_Y[51]  
    mov star_coordinates[103], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 53  
    mov al, STAR_X[52]  
    mov star_coordinates[104], al  
    mov STAR0_X, al  
    mov al, STAR_Y[52]  
    mov star_coordinates[105], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 54  
    mov al, STAR_X[53]  
    mov star_coordinates[106], al  
    mov STAR0_X, al  
    mov al, STAR_Y[53]  
    mov star_coordinates[107], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 55  
    mov al, STAR_X[54]  
    mov star_coordinates[108], al  
    mov STAR0_X, al  
    mov al, STAR_Y[54]  
    mov star_coordinates[109], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 56  
    mov al, STAR_X[55]  
    mov star_coordinates[110], al  
    mov STAR0_X, al  
    mov al, STAR_Y[55]  
    mov star_coordinates[111], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 57  
    mov al, STAR_X[56]  
    mov star_coordinates[112], al  
    mov STAR0_X, al  
    mov al, STAR_Y[56]  
    mov star_coordinates[113], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 58  
    mov al, STAR_X[57]  
    mov star_coordinates[114], al  
    mov STAR0_X, al  
    mov al, STAR_Y[57]  
    mov star_coordinates[115], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 59  
    mov al, STAR_X[58]  
    mov star_coordinates[116], al  
    mov STAR0_X, al  
    mov al, STAR_Y[58]  
    mov star_coordinates[117], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 60  
    mov al, STAR_X[59]  
    mov star_coordinates[118], al  
    mov STAR0_X, al  
    mov al, STAR_Y[59]  
    mov star_coordinates[119], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 61  
    mov al, STAR_X[60]  
    mov star_coordinates[120], al  
    mov STAR0_X, al  
    mov al, STAR_Y[60]  
    mov star_coordinates[121], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 62  
    mov al, STAR_X[61]  
    mov star_coordinates[122], al  
    mov STAR0_X, al  
    mov al, STAR_Y[61]  
    mov star_coordinates[123], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 63  
    mov al, STAR_X[62]  
    mov star_coordinates[124], al  
    mov STAR0_X, al  
    mov al, STAR_Y[62]  
    mov star_coordinates[125], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 64  
    mov al, STAR_X[63]  
    mov star_coordinates[126], al  
    mov STAR0_X, al  
    mov al, STAR_Y[63]  
    mov star_coordinates[127], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 65  
    mov al, STAR_X[64]  
    mov star_coordinates[128], al  
    mov STAR0_X, al  
    mov al, STAR_Y[64]  
    mov star_coordinates[129], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 66  
    mov al, STAR_X[65]  
    mov star_coordinates[130], al  
    mov STAR0_X, al  
    mov al, STAR_Y[65]  
    mov star_coordinates[131], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 67  
    mov al, STAR_X[66]  
    mov star_coordinates[132], al  
    mov STAR0_X, al  
    mov al, STAR_Y[66]  
    mov star_coordinates[133], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 68  
    mov al, STAR_X[67]  
    mov star_coordinates[134], al  
    mov STAR0_X, al  
    mov al, STAR_Y[67]  
    mov star_coordinates[135], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 69  
    mov al, STAR_X[68]  
    mov star_coordinates[136], al  
    mov STAR0_X, al  
    mov al, STAR_Y[68]  
    mov star_coordinates[137], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 70  
    mov al, STAR_X[69]  
    mov star_coordinates[138], al  
    mov STAR0_X, al  
    mov al, STAR_Y[69]  
    mov star_coordinates[139], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 71  
    mov al, STAR_X[70]  
    mov star_coordinates[140], al  
    mov STAR0_X, al  
    mov al, STAR_Y[70]  
    mov star_coordinates[141], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 72  
    mov al, STAR_X[71]  
    mov star_coordinates[142], al  
    mov STAR0_X, al  
    mov al, STAR_Y[71]  
    mov star_coordinates[143], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 73  
    mov al, STAR_X[72]  
    mov star_coordinates[144], al  
    mov STAR0_X, al  
    mov al, STAR_Y[72]  
    mov star_coordinates[145], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 74  
    mov al, STAR_X[73]  
    mov star_coordinates[146], al  
    mov STAR0_X, al  
    mov al, STAR_Y[73]  
    mov star_coordinates[147], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    ; Star 75  
    mov al, STAR_X[74]  
    mov star_coordinates[148], al  
    mov STAR0_X, al  
    mov al, STAR_Y[74]  
    mov star_coordinates[149], al  
    mov STAR0_Y, al  
    call PRINT_STAR

ret
PRINT_LVL1_STAR ENDP



;;;------------------------------
;;;------[LVL-2 STAR PRINT]------
;;;------------------------------
PRINT_LVL2_STAR PROC

    ; Level 2 Star Printing  

    mov al, star_coordinates[0]  
    mov STAR_X[0], al  
    mov STAR0_X, al  
    mov al, star_coordinates[1]  
    mov STAR_Y[0], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[2]  
    mov STAR_X[1], al  
    mov STAR0_X, al  
    mov al, star_coordinates[3]  
    mov STAR_Y[1], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[4]  
    mov STAR_X[2], al  
    mov STAR0_X, al  
    mov al, star_coordinates[5]  
    mov STAR_Y[2], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[6]  
    mov STAR_X[3], al  
    mov STAR0_X, al  
    mov al, star_coordinates[7]  
    mov STAR_Y[3], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[8]  
    mov STAR_X[4], al  
    mov STAR0_X, al  
    mov al, star_coordinates[9]  
    mov STAR_Y[4], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[10]  
    mov STAR_X[5], al  
    mov STAR0_X, al 
    mov al, star_coordinates[11]  
    mov STAR_Y[5], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[12]  
    mov STAR_X[6], al  
    mov STAR0_X, al  
    mov al, star_coordinates[13]  
    mov STAR_Y[6], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[14]  
    mov STAR_X[7], al  
    mov STAR0_X, al  
    mov al, star_coordinates[15]  
    mov STAR_Y[7], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[16]  
    mov STAR_X[8], al  
    mov STAR0_X, al  
    mov al, star_coordinates[17]  
    mov STAR_Y[8], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[18]  
    mov STAR_X[9], al  
    mov STAR0_X, al  
    mov al, star_coordinates[19]  
    mov STAR_Y[9], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[20]  
    mov STAR_X[10], al  
    mov STAR0_X, al  
    mov al, star_coordinates[21]  
    mov STAR_Y[10], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[22]  
    mov STAR_X[11], al  
    mov STAR0_X, al  
    mov al, star_coordinates[23]  
    mov STAR_Y[11], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[24]  
    mov STAR_X[12], al  
    mov STAR0_X, al  
    mov al, star_coordinates[25]  
    mov STAR_Y[12], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[26]  
    mov STAR_X[13], al  
    mov STAR0_X, al  
    mov al, star_coordinates[27]  
    mov STAR_Y[13], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[28]  
    mov STAR_X[14], al  
    mov STAR0_X, al  
    mov al, star_coordinates[29]  
    mov STAR_Y[14], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[30]  
    mov STAR_X[15], al  
    mov STAR0_X, al  
    mov al, star_coordinates[31]  
    mov STAR_Y[15], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[32]  
    mov STAR_X[16], al  
    mov STAR0_X, al  
    mov al, star_coordinates[33]  
    mov STAR_Y[16], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[34]  
    mov STAR_X[17], al  
    mov STAR0_X, al  
    mov al, star_coordinates[35]  
    mov STAR_Y[17], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[36]  
    mov STAR_X[18], al  
    mov STAR0_X, al 
    mov al, star_coordinates[37]  
    mov STAR_Y[18], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[38]  
    mov STAR_X[19], al  
    mov STAR0_X, al  
    mov al, star_coordinates[39]  
    mov STAR_Y[19], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[40]  
    mov STAR_X[20], al  
    mov STAR0_X, al  
    mov al, star_coordinates[41]  
    mov STAR_Y[20], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[42]  
    mov STAR_X[21], al  
    mov STAR0_X, al  
    mov al, star_coordinates[43]  
    mov STAR_Y[21], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[44]  
    mov STAR_X[22], al  
    mov STAR0_X, al  
    mov al, star_coordinates[45]  
    mov STAR_Y[22], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[46]  
    mov STAR_X[23], al  
    mov STAR0_X, al  
    mov al, star_coordinates[47]  
    mov STAR_Y[23], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[48]  
    mov STAR_X[24], al  
    mov STAR0_X, al  
    mov al, star_coordinates[49]  
    mov STAR_Y[24], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[50]  
    mov STAR_X[25], al  
    mov STAR0_X, al  
    mov al, star_coordinates[51]  
    mov STAR_Y[25], al  
    mov STAR0_Y, al 
    call PRINT_STAR  

    mov al, star_coordinates[52]  
    mov STAR_X[26], al  
    mov STAR0_X, al 
    mov al, star_coordinates[53]  
    mov STAR_Y[26], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[54]  
    mov STAR_X[27], al  
    mov STAR0_X, al  
    mov al, star_coordinates[55]  
    mov STAR_Y[27], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[56]  
    mov STAR_X[28], al  
    mov STAR0_X, al  
    mov al, star_coordinates[57]  
    mov STAR_Y[28], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[58]  
    mov STAR_X[29], al  
    mov STAR0_X, al  
    mov al, star_coordinates[59]  
    mov STAR_Y[29], al  
    mov STAR0_Y, al  
    call PRINT_STAR

    mov al, star_coordinates[60]  
    mov STAR_X[30], al  
    mov STAR0_X, al  
    mov al, star_coordinates[61]  
    mov STAR_Y[30], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[62]  
    mov STAR_X[31], al  
    mov STAR0_X, al  
    mov al, star_coordinates[63]  
    mov STAR_Y[31], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[64]  
    mov STAR_X[32], al  
    mov STAR0_X, al  
    mov al, star_coordinates[65]  
    mov STAR_Y[32], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[66]  
    mov STAR_X[33], al  
    mov STAR0_X, al  
    mov al, star_coordinates[67]  
    mov STAR_Y[33], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[68]  
    mov STAR_X[34], al  
    mov STAR0_X, al  
    mov al, star_coordinates[69]  
    mov STAR_Y[34], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[70]  
    mov STAR_X[35], al  
    mov STAR0_X, al  
    mov al, star_coordinates[71]  
    mov STAR_Y[35], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[72]  
    mov STAR_X[36], al  
    mov STAR0_X, al  
    mov al, star_coordinates[73]  
    mov STAR_Y[36], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[74]  
    mov STAR_X[37], al  
    mov STAR0_X, al  
    mov al, star_coordinates[75]  
    mov STAR_Y[37], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[76]  
    mov STAR_X[38], al  
    mov STAR0_X, al  
    mov al, star_coordinates[77]  
    mov STAR_Y[38], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[78]  
    mov STAR_X[39], al  
    mov STAR0_X, al  
    mov al, star_coordinates[79]  
    mov STAR_Y[39], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[80]  
    mov STAR_X[40], al  
    mov STAR0_X, al  
    mov al, star_coordinates[81]  
    mov STAR_Y[40], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[82]  
    mov STAR_X[41], al  
    mov STAR0_X, al  
    mov al, star_coordinates[83]  
    mov STAR_Y[41], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[84]  
    mov STAR_X[42], al  
    mov STAR0_X, al  
    mov al, star_coordinates[85]  
    mov STAR_Y[42], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[86]  
    mov STAR_X[43], al  
    mov STAR0_X, al  
    mov al, star_coordinates[87]  
    mov STAR_Y[43], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[88]  
    mov STAR_X[44], al  
    mov STAR0_X, al  
    mov al, star_coordinates[89]  
    mov STAR_Y[44], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[90]  
    mov STAR_X[45], al  
    mov STAR0_X, al  
    mov al, star_coordinates[91]  
    mov STAR_Y[45], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[92]  
    mov STAR_X[46], al  
    mov STAR0_X, al  
    mov al, star_coordinates[93]  
    mov STAR_Y[46], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[94]  
    mov STAR_X[47], al  
    mov STAR0_X, al  
    mov al, star_coordinates[95]  
    mov STAR_Y[47], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[96]  
    mov STAR_X[48], al  
    mov STAR0_X, al  
    mov al, star_coordinates[97]  
    mov STAR_Y[48], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[98]  
    mov STAR_X[49], al  
    mov STAR0_X, al  
    mov al, star_coordinates[99]  
    mov STAR_Y[49], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[100]  
    mov STAR_X[50], al  
    mov STAR0_X, al  
    mov al, star_coordinates[101]  
    mov STAR_Y[50], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[102]  
    mov STAR_X[51], al  
    mov STAR0_X, al  
    mov al, star_coordinates[103]  
    mov STAR_Y[51], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[104]  
    mov STAR_X[52], al  
    mov STAR0_X, al  
    mov al, star_coordinates[105]  
    mov STAR_Y[52], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[106]  
    mov STAR_X[53], al  
    mov STAR0_X, al  
    mov al, star_coordinates[107]  
    mov STAR_Y[53], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[108]  
    mov STAR_X[54], al  
    mov STAR0_X, al  
    mov al, star_coordinates[109]  
    mov STAR_Y[54], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[110]  
    mov STAR_X[55], al  
    mov STAR0_X, al  
    mov al, star_coordinates[111]  
    mov STAR_Y[55], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[112]  
    mov STAR_X[56], al  
    mov STAR0_X, al  
    mov al, star_coordinates[113]  
    mov STAR_Y[56], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[114]  
    mov STAR_X[57], al  
    mov STAR0_X, al  
    mov al, star_coordinates[115]  
    mov STAR_Y[57], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[116]  
    mov STAR_X[58], al  
    mov STAR0_X, al  
    mov al, star_coordinates[117]  
    mov STAR_Y[58], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[118]  
    mov STAR_X[59], al  
    mov STAR0_X, al  
    mov al, star_coordinates[119]  
    mov STAR_Y[59], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[120]  
    mov STAR_X[60], al  
    mov STAR0_X, al  
    mov al, star_coordinates[121]  
    mov STAR_Y[60], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[122]  
    mov STAR_X[61], al  
    mov STAR0_X, al  
    mov al, star_coordinates[123]  
    mov STAR_Y[61], al  
    mov STAR0_Y, al  
    call PRINT_STAR 

    mov al, star_coordinates[124]  
    mov STAR_X[62], al  
    mov STAR0_X, al  
    mov al, star_coordinates[125]  
    mov STAR_Y[62], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[126]  
    mov STAR_X[63], al  
    mov STAR0_X, al  
    mov al, star_coordinates[127]  
    mov STAR_Y[63], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[128]  
    mov STAR_X[64], al  
    mov STAR0_X, al  
    mov al, star_coordinates[129]  
    mov STAR_Y[64], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[130]  
    mov STAR_X[65], al  
    mov STAR0_X, al  
    mov al, star_coordinates[131]  
    mov STAR_Y[65], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[132]  
    mov STAR_X[66], al  
    mov STAR0_X, al  
    mov al, star_coordinates[133]  
    mov STAR_Y[66], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[134]  
    mov STAR_X[67], al  
    mov STAR0_X, al  
    mov al, star_coordinates[135]  
    mov STAR_Y[67], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[136]  
    mov STAR_X[68], al  
    mov STAR0_X, al  
    mov al, star_coordinates[137]  
    mov STAR_Y[68], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[138]  
    mov STAR_X[69], al  
    mov STAR0_X, al  
    mov al, star_coordinates[139]  
    mov STAR_Y[69], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[140]  
    mov STAR_X[70], al  
    mov STAR0_X, al  
    mov al, star_coordinates[141]  
    mov STAR_Y[70], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[142]  
    mov STAR_X[71], al  
    mov STAR0_X, al  
    mov al, star_coordinates[143]  
    mov STAR_Y[71], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[144]  
    mov STAR_X[72], al  
    mov STAR0_X, al  
    mov al, star_coordinates[145]  
    mov STAR_Y[72], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[146]  
    mov STAR_X[73], al  
    mov STAR0_X, al  
    mov al, star_coordinates[147]  
    mov STAR_Y[73], al  
    mov STAR0_Y, al  
    call PRINT_STAR  

    mov al, star_coordinates[148]  
    mov STAR_X[74], al  
    mov STAR0_X, al  
    mov al, star_coordinates[149]  
    mov STAR_Y[74], al  
    mov STAR0_Y, al  
    call PRINT_STAR

    mov coin_x, 5 
    mov coin_y, 14
    call PRINT_COIN

    mov coin_x, 116 
    mov coin_y, 14
    call PRINT_COIN

ret
PRINT_LVL2_STAR ENDP
    

;;;;;;;;;;;;;;;;;;;;
BEGIN_GAME_01 PROC

    INVOKE PlaySound, OFFSET BEGIN_GAME_SOUND, NULL, 0h

    SEC_LVL_01:
        
        mov bl, x_pos
        mov bh, y_pos

        call MOV_G1_L1
        call PRINT_G1_L1

        call MOV_G2_L1
        call PRINT_G2_L1

        call MOV_G4_L2
        call PRINT_G4_L2

        call MOV_G3_L2
        call PRINT_G3_L2
    
        call COLIDE_G2_L1
        call COLIDE_G1_L1
        call COLIDE_G4_L2
        call COLIDE_G3_L2
        
        mov cx, 1
        mov dx, 75

        check_star1:
            
            mov bl, x_pos
            cmp bl, STAR_X[0]
            jne check_star2
            mov bl, y_pos
            cmp bl, STAR_Y[0]
            jne check_star2
            inc SCORE
            mov STAR_X[0], 0
            mov STAR_Y[0], 0

        check_star2:
            mov bl, x_pos
            cmp bl, STAR_X[1]
            jne check_star3
            mov bl, y_pos
            cmp bl, STAR_Y[1]
            jne check_star3
            inc SCORE
            mov STAR_X[1], 0
            mov STAR_Y[1], 0

        check_star3:
            mov bl, x_pos
            cmp bl, STAR_X[2]
            jne check_star4
            mov bl, y_pos
            cmp bl, STAR_Y[2]
            jne check_star4
            inc SCORE
            mov STAR_X[2], 0
            mov STAR_Y[2], 0

        check_star4:
            mov bl, x_pos
            cmp bl, STAR_X[3]
            jne check_star5
            mov bl, y_pos
            cmp bl, STAR_Y[3]
            jne check_star5
            inc SCORE
            mov STAR_X[3], 0
            mov STAR_Y[3], 0

        check_star5:
            mov bl, x_pos
            cmp bl, STAR_X[4]
            jne check_star6
            mov bl, y_pos
            cmp bl, STAR_Y[4]
            jne check_star6
            inc SCORE
            mov STAR_X[4], 0
            mov STAR_Y[4], 0

        check_star6:
            mov bl, x_pos
            cmp bl, STAR_X[5]
            jne check_star7
            mov bl, y_pos
            cmp bl, STAR_Y[5]
            jne check_star7
            inc SCORE
            mov STAR_X[5], 0
            mov STAR_Y[5], 0

        check_star7:
            mov bl, x_pos
            cmp bl, STAR_X[6]
            jne check_star8
            mov bl, y_pos
            cmp bl, STAR_Y[6]
            jne check_star8
            inc SCORE
            mov STAR_X[6], 0
            mov STAR_Y[6], 0

        check_star8:
            mov bl, x_pos
            cmp bl, STAR_X[7]
            jne check_star9
            mov bl, y_pos
            cmp bl, STAR_Y[7]
            jne check_star9
            inc SCORE
            mov STAR_X[7], 0
            mov STAR_Y[7], 0

        check_star9:
            mov bl, x_pos
            cmp bl, STAR_X[8]
            jne check_star10
            mov bl, y_pos
            cmp bl, STAR_Y[8]
            jne check_star10
            inc SCORE
            mov STAR_X[8], 0
            mov STAR_Y[8], 0

        check_star10:
            mov bl, x_pos
            cmp bl, STAR_X[9]
            jne check_star11
            mov bl, y_pos
            cmp bl, STAR_Y[9]
            jne check_star11
            inc SCORE
            mov STAR_X[9], 0
            mov STAR_Y[9], 0

        check_star11:
            mov bl, x_pos
            cmp bl, STAR_X[10]
            jne check_star12
            mov bl, y_pos
            cmp bl, STAR_Y[10]
            jne check_star12
            inc SCORE
            mov STAR_X[10], 0
            mov STAR_Y[10], 0

        check_star12:
            mov bl, x_pos
            cmp bl, STAR_X[11]
            jne check_star13
            mov bl, y_pos
            cmp bl, STAR_Y[11]
            jne check_star13
            inc SCORE
            mov STAR_X[11], 0
            mov STAR_Y[11], 0

        check_star13:
            mov bl, x_pos
            cmp bl, STAR_X[12]
            jne check_star14
            mov bl, y_pos
            cmp bl, STAR_Y[12]
            jne check_star14
            inc SCORE
            mov STAR_X[12], 0
            mov STAR_Y[12], 0

        check_star14:
            mov bl, x_pos
            cmp bl, STAR_X[13]
            jne check_star15
            mov bl, y_pos
            cmp bl, STAR_Y[13]
            jne check_star15
            inc SCORE
            mov STAR_X[13], 0
            mov STAR_Y[13], 0

        check_star15:
            mov bl, x_pos
            cmp bl, STAR_X[14]
            jne check_star16
            mov bl, y_pos
            cmp bl, STAR_Y[14]
            jne check_star16
            inc SCORE
            mov STAR_X[14], 0
            mov STAR_Y[14], 0

        check_star16:
            mov bl, x_pos
            cmp bl, STAR_X[15]
            jne check_star17
            mov bl, y_pos
            cmp bl, STAR_Y[15]
            jne check_star17
            inc SCORE
            mov STAR_X[15], 0
            mov STAR_Y[15], 0

        check_star17:
            mov bl, x_pos
            cmp bl, STAR_X[16]
            jne check_star18
            mov bl, y_pos
            cmp bl, STAR_Y[16]
            jne check_star18
            inc SCORE
            mov STAR_X[16], 0
            mov STAR_Y[16], 0

        check_star18:
            mov bl, x_pos
            cmp bl, STAR_X[17]
            jne check_star19
            mov bl, y_pos
            cmp bl, STAR_Y[17]
            jne check_star19
            inc SCORE
            mov STAR_X[17], 0
            mov STAR_Y[17], 0

        check_star19:
            mov bl, x_pos
            cmp bl, STAR_X[18]
            jne check_star20
            mov bl, y_pos
            cmp bl, STAR_Y[18]
            jne check_star20
            inc SCORE
            mov STAR_X[18], 0
            mov STAR_Y[18], 0

        check_star20:
            mov bl, x_pos
            cmp bl, STAR_X[19]
            jne check_star21
            mov bl, y_pos
            cmp bl, STAR_Y[19]
            jne check_star21
            inc SCORE
            mov STAR_X[19], 0
            mov STAR_Y[19], 0

        check_star21:
            mov bl, x_pos
            cmp bl, STAR_X[20]
            jne check_star22
            mov bl, y_pos
            cmp bl, STAR_Y[20]
            jne check_star22
            inc SCORE
            mov STAR_X[20], 0
            mov STAR_Y[20], 0

        check_star22:
            mov bl, x_pos
            cmp bl, STAR_X[21]
            jne check_star23
            mov bl, y_pos
            cmp bl, STAR_Y[21]
            jne check_star23
            inc SCORE
            mov STAR_X[21], 0
            mov STAR_Y[21], 0

        check_star23:
            mov bl, x_pos
            cmp bl, STAR_X[22]
            jne check_star24
            mov bl, y_pos
            cmp bl, STAR_Y[22]
            jne check_star24
            inc SCORE
            mov STAR_X[22], 0
            mov STAR_Y[22], 0

        check_star24:
            mov bl, x_pos
            cmp bl, STAR_X[23]
            jne check_star25
            mov bl, y_pos
            cmp bl, STAR_Y[23]
            jne check_star25
            inc SCORE
            mov STAR_X[23], 0
            mov STAR_Y[23], 0

        check_star25:
            mov bl, x_pos
            cmp bl, STAR_X[24]
            jne check_star26
            mov bl, y_pos
            cmp bl, STAR_Y[24]
            jne check_star26
            inc SCORE
            mov STAR_X[24], 0
            mov STAR_Y[24], 0

        check_star26:
            mov bl, x_pos
            cmp bl, STAR_X[25]
            jne check_star27
            mov bl, y_pos
            cmp bl, STAR_Y[25]
            jne check_star27
            inc SCORE
            mov STAR_X[25], 0
            mov STAR_Y[25], 0

        check_star27:
            mov bl, x_pos
            cmp bl, STAR_X[26]
            jne check_star28
            mov bl, y_pos
            cmp bl, STAR_Y[26]
            jne check_star28
            inc SCORE
            mov STAR_X[26], 0
            mov STAR_Y[26], 0

        check_star28:
            mov bl, x_pos
            cmp bl, STAR_X[27]
            jne check_star29
            mov bl, y_pos
            cmp bl, STAR_Y[27]
            jne check_star29
            inc SCORE
            mov STAR_X[27], 0
            mov STAR_Y[27], 0

        check_star29:
            mov bl, x_pos
            cmp bl, STAR_X[28]
            jne check_star30
            mov bl, y_pos
            cmp bl, STAR_Y[28]
            jne check_star30
            inc SCORE
            mov STAR_X[28], 0
            mov STAR_Y[28], 0

        check_star30:
            mov bl, x_pos
            cmp bl, STAR_X[29]
            jne check_star31
            mov bl, y_pos
            cmp bl, STAR_Y[29]
            jne check_star31
            inc SCORE
            mov STAR_X[29], 0
            mov STAR_Y[29], 0

        check_star31:
            mov bl, x_pos
            cmp bl, STAR_X[30]
            jne check_star32
            mov bl, y_pos
            cmp bl, STAR_Y[30]
            jne check_star32
            inc SCORE
            mov STAR_X[30], 0
            mov STAR_Y[30], 0

        check_star32:
            mov bl, x_pos
            cmp bl, STAR_X[31]
            jne check_star33
            mov bl, y_pos
            cmp bl, STAR_Y[31]
            jne check_star33
            inc SCORE
            mov STAR_X[31], 0
            mov STAR_Y[31], 0

        check_star33:
            mov bl, x_pos
            cmp bl, STAR_X[32]
            jne check_star34
            mov bl, y_pos
            cmp bl, STAR_Y[32]
            jne check_star34
            inc SCORE
            mov STAR_X[32], 0
            mov STAR_Y[32], 0

        check_star34:
            mov bl, x_pos
            cmp bl, STAR_X[33]
            jne check_star35
            mov bl, y_pos
            cmp bl, STAR_Y[33]
            jne check_star35
            inc SCORE
            mov STAR_X[33], 0
            mov STAR_Y[33], 0

        check_star35:
            mov bl, x_pos
            cmp bl, STAR_X[34]
            jne check_star36
            mov bl, y_pos
            cmp bl, STAR_Y[34]
            jne check_star36
            inc SCORE
            mov STAR_X[34], 0
            mov STAR_Y[34], 0

        check_star36:
            mov bl, x_pos
            cmp bl, STAR_X[35]
            jne check_star37
            mov bl, y_pos
            cmp bl, STAR_Y[35]
            jne check_star37
            inc SCORE
            mov STAR_X[35], 0
            mov STAR_Y[35], 0

        check_star37:
            mov bl, x_pos
            cmp bl, STAR_X[36]
            jne check_star38
            mov bl, y_pos
            cmp bl, STAR_Y[36]
            jne check_star38
            inc SCORE
            mov STAR_X[36], 0
            mov STAR_Y[36], 0

        check_star38:
            mov bl, x_pos
            cmp bl, STAR_X[37]
            jne check_star39
            mov bl, y_pos
            cmp bl, STAR_Y[37]
            jne check_star39
            inc SCORE
            mov STAR_X[37], 0
            mov STAR_Y[37], 0

        check_star39:
            mov bl, x_pos
            cmp bl, STAR_X[38]
            jne check_star40
            mov bl, y_pos
            cmp bl, STAR_Y[38]
            jne check_star40
            inc SCORE
            mov STAR_X[38], 0
            mov STAR_Y[38], 0

        check_star40:
            mov bl, x_pos
            cmp bl, STAR_X[39]
            jne check_star41
            mov bl, y_pos
            cmp bl, STAR_Y[39]
            jne check_star41
            inc SCORE
            mov STAR_X[39], 0
            mov STAR_Y[39], 0

        check_star41:
            mov bl, x_pos
            cmp bl, STAR_X[40]
            jne check_star42
            mov bl, y_pos
            cmp bl, STAR_Y[40]
            jne check_star42
            inc SCORE
            mov STAR_X[40], 0
            mov STAR_Y[40], 0

        check_star42:
            mov bl, x_pos
            cmp bl, STAR_X[41]
            jne check_star43
            mov bl, y_pos
            cmp bl, STAR_Y[41]
            jne check_star43
            inc SCORE
            mov STAR_X[41], 0
            mov STAR_Y[41], 0

        check_star43:
            mov bl, x_pos
            cmp bl, STAR_X[42]
            jne check_star44
            mov bl, y_pos
            cmp bl, STAR_Y[42]
            jne check_star44
            inc SCORE
            mov STAR_X[42], 0
            mov STAR_Y[42], 0

        check_star44:
            mov bl, x_pos
            cmp bl, STAR_X[43]
            jne check_star45
            mov bl, y_pos
            cmp bl, STAR_Y[43]
            jne check_star45
            inc SCORE
            mov STAR_X[43], 0
            mov STAR_Y[43], 0

        check_star45:
            mov bl, x_pos
            cmp bl, STAR_X[44]
            jne check_star46
            mov bl, y_pos
            cmp bl, STAR_Y[44]
            jne check_star46
            inc SCORE
            mov STAR_X[44], 0
            mov STAR_Y[44], 0

        check_star46:
            mov bl, x_pos
            cmp bl, STAR_X[45]
            jne check_star47
            mov bl, y_pos
            cmp bl, STAR_Y[45]
            jne check_star47
            inc SCORE
            mov STAR_X[45], 0
            mov STAR_Y[45], 0

        check_star47:
            mov bl, x_pos
            cmp bl, STAR_X[46]
            jne check_star48
            mov bl, y_pos
            cmp bl, STAR_Y[46]
            jne check_star48
            inc SCORE
            mov STAR_X[46], 0
            mov STAR_Y[46], 0

        check_star48:
            mov bl, x_pos
            cmp bl, STAR_X[47]
            jne check_star49
            mov bl, y_pos
            cmp bl, STAR_Y[47]
            jne check_star49
            inc SCORE
            mov STAR_X[47], 0
            mov STAR_Y[47], 0

        check_star49:
            mov bl, x_pos
            cmp bl, STAR_X[48]
            jne check_star50
            mov bl, y_pos
            cmp bl, STAR_Y[48]
            jne check_star50
            inc SCORE
            mov STAR_X[48], 0
            mov STAR_Y[48], 0

        check_star50:
            mov bl, x_pos
            cmp bl, STAR_X[49]
            jne check_star51
            mov bl, y_pos
            cmp bl, STAR_Y[49]
            jne check_star51
            inc SCORE
            mov STAR_X[49], 0
            mov STAR_Y[49], 0

        check_star51:
            mov bl, x_pos
            cmp bl, STAR_X[50]
            jne check_star52
            mov bl, y_pos
            cmp bl, STAR_Y[50]
            jne check_star52
            inc SCORE
            mov STAR_X[50], 0
            mov STAR_Y[50], 0

        check_star52:
            mov bl, x_pos
            cmp bl, STAR_X[51]
            jne check_star53
            mov bl, y_pos
            cmp bl, STAR_Y[51]
            jne check_star53
            inc SCORE
            mov STAR_X[51], 0
            mov STAR_Y[51], 0

        check_star53:
            mov bl, x_pos
            cmp bl, STAR_X[52]
            jne check_star54
            mov bl, y_pos
            cmp bl, STAR_Y[52]
            jne check_star54
            inc SCORE
            mov STAR_X[52], 0
            mov STAR_Y[52], 0

        check_star54:
            mov bl, x_pos
            cmp bl, STAR_X[53]
            jne check_star55
            mov bl, y_pos
            cmp bl, STAR_Y[53]
            jne check_star55
            inc SCORE
            mov STAR_X[53], 0
            mov STAR_Y[53], 0

        check_star55:
            mov bl, x_pos
            cmp bl, STAR_X[54]
            jne check_star56
            mov bl, y_pos
            cmp bl, STAR_Y[54]
            jne check_star56
            inc SCORE
            mov STAR_X[54], 0
            mov STAR_Y[54], 0

        check_star56:
            mov bl, x_pos
            cmp bl, STAR_X[55]
            jne check_star57
            mov bl, y_pos
            cmp bl, STAR_Y[55]
            jne check_star57
            inc SCORE
            mov STAR_X[55], 0
            mov STAR_Y[55], 0

        check_star57:
            mov bl, x_pos
            cmp bl, STAR_X[56]
            jne check_star58
            mov bl, y_pos
            cmp bl, STAR_Y[56]
            jne check_star58
            inc SCORE
            mov STAR_X[56], 0
            mov STAR_Y[56], 0

        check_star58:
            mov bl, x_pos
            cmp bl, STAR_X[57]
            jne check_star59
            mov bl, y_pos
            cmp bl, STAR_Y[57]
            jne check_star59
            inc SCORE
            mov STAR_X[57], 0
            mov STAR_Y[57], 0

        check_star59:
            mov bl, x_pos
            cmp bl, STAR_X[58]
            jne check_star60
            mov bl, y_pos
            cmp bl, STAR_Y[58]
            jne check_star60
            inc SCORE
            mov STAR_X[58], 0
            mov STAR_Y[58], 0

        check_star60:
            mov bl, x_pos
            cmp bl, STAR_X[59]
            jne check_star61
            mov bl, y_pos
            cmp bl, STAR_Y[59]
            jne check_star61
            inc SCORE
            mov STAR_X[59], 0
            mov STAR_Y[59], 0

        check_star61:
            mov bl, x_pos
            cmp bl, STAR_X[60]
            jne check_star62
            mov bl, y_pos
            cmp bl, STAR_Y[60]
            jne check_star62
            inc SCORE
            mov STAR_X[60], 0
            mov STAR_Y[60], 0

        check_star62:
            mov bl, x_pos
            cmp bl, STAR_X[61]
            jne check_star63
            mov bl, y_pos
            cmp bl, STAR_Y[61]
            jne check_star63
            inc SCORE
            mov STAR_X[61], 0
            mov STAR_Y[61], 0

        check_star63:
            mov bl, x_pos
            cmp bl, STAR_X[62]
            jne check_star64
            mov bl, y_pos
            cmp bl, STAR_Y[62]
            jne check_star64
            inc SCORE
            mov STAR_X[62], 0
            mov STAR_Y[62], 0

        check_star64:
            mov bl, x_pos
            cmp bl, STAR_X[63]
            jne check_star65
            mov bl, y_pos
            cmp bl, STAR_Y[63]
            jne check_star65
            inc SCORE
            mov STAR_X[63], 0
            mov STAR_Y[63], 0

        check_star65:
            mov bl, x_pos
            cmp bl, STAR_X[64]
            jne check_star66
            mov bl, y_pos
            cmp bl, STAR_Y[64]
            jne check_star66
            inc SCORE
            mov STAR_X[64], 0
            mov STAR_Y[64], 0

        check_star66:
            mov bl, x_pos
            cmp bl, STAR_X[65]
            jne check_star67
            mov bl, y_pos
            cmp bl, STAR_Y[65]
            jne check_star67
            inc SCORE
            mov STAR_X[65], 0
            mov STAR_Y[65], 0

        check_star67:
            mov bl, x_pos
            cmp bl, STAR_X[66]
            jne check_star68
            mov bl, y_pos
            cmp bl, STAR_Y[66]
            jne check_star68
            inc SCORE
            mov STAR_X[66], 0
            mov STAR_Y[66], 0

        check_star68:
            mov bl, x_pos
            cmp bl, STAR_X[67]
            jne check_star69
            mov bl, y_pos
            cmp bl, STAR_Y[67]
            jne check_star69
            inc SCORE
            mov STAR_X[67], 0
            mov STAR_Y[67], 0

        check_star69:
            mov bl, x_pos
            cmp bl, STAR_X[68]
            jne check_star70
            mov bl, y_pos
            cmp bl, STAR_Y[68]
            jne check_star70
            inc SCORE
            mov STAR_X[68], 0
            mov STAR_Y[68], 0

        check_star70:
            mov bl, x_pos
            cmp bl, STAR_X[69]
            jne check_star71
            mov bl, y_pos
            cmp bl, STAR_Y[69]
            jne check_star71
            inc SCORE
            mov STAR_X[69], 0
            mov STAR_Y[69], 0

        check_star71:
            mov bl, x_pos
            cmp bl, STAR_X[70]
            jne check_star72
            mov bl, y_pos
            cmp bl, STAR_Y[70]
            jne check_star72
            inc SCORE
            mov STAR_X[70], 0
            mov STAR_Y[70], 0

        check_star72:
            mov bl, x_pos
            cmp bl, STAR_X[71]
            jne check_star73
            mov bl, y_pos
            cmp bl, STAR_Y[71]
            jne check_star73
            inc SCORE
            mov STAR_X[71], 0
            mov STAR_Y[71], 0

        check_star73:
            mov bl, x_pos
            cmp bl, STAR_X[72]
            jne check_star74
            mov bl, y_pos
            cmp bl, STAR_Y[72]
            jne check_star74
            inc SCORE
            mov STAR_X[72], 0
            mov STAR_Y[72], 0

        check_star74:
            mov bl, x_pos
            cmp bl, STAR_X[73]
            jne check_star75
            mov bl, y_pos
            cmp bl, STAR_Y[73]
            jne check_star75
            inc SCORE
            mov STAR_X[73], 0
            mov STAR_Y[73], 0

        check_star75:
            
            mov bl, x_pos
            cmp bl, STAR_X[74]
            jne star_finish_1
            mov bl, y_pos
            cmp bl, STAR_Y[74]
            jne star_finish_1
            inc SCORE
            mov STAR_X[74], 0
            mov STAR_Y[74], 0

        star_finish_1:

        mov eax,white (black * 16)
        call SetTextColor

        mov dl, 0
        mov dh, 0
        call Gotoxy
        mwrite "SCORE : "
        mov eax, 0
        mov al, SCORE
        cmp SCORE, 2 ;//ANCHOR - 
        jge ENDED_LVL_01
        call Writedec

        mov dl, 57
        mov dh, 0
        call Gotoxy
        mwrite "LIVES : "
        mov eax,0
        mov al, LIVES
        call WRITEDEC
        cmp LIVES,0
        je TERMINATE

        mov dl, 110
        mov dh, 0
        call Gotoxy
        mwrite "LEVEL : "
        mov eax, 0
        mov al, LEVEL
        call WRITEDEC

        ITERATIVE:
            cmp y_pos,0
            jg TAKE_IP_AGAIN
            call CHANGE_PLAYER
            inc y_pos
            call DRAW_PLAYER_LV1
            mov eax,50
            call Delay
            jmp ITERATIVE

       TAKE_IP_AGAIN:
        
        call ReadKey
        jz NOT_ENTERED
            mov MOVE, al
        NOT_ENTERED:

        mov eax, 90
        call DELAY

       cmp MOVE, "p"
       je STOP_IT

        ; EXIT GAME AT 'E' INPUT
        cmp MOVE, "e"
        je TERMINATE

        cmp MOVE, "r"
        je UP_IP

        cmp MOVE, "z"
        je DOWN_IP

        cmp MOVE, "a"
        je LEFT_IP

        cmp MOVE, "s"
        je RIGHT_IP

    STOP_IT:
       call PAUSE_GAME

     UP_IP:

        cmp y_pos,2
        je SEC_LVL_01

        mov bl, x_pos
        mov bh, y_pos
        dec bh
        mov CHCEK, 0

        call L1_2_1
        cmp CHCEK, 1
        je REPEAT_01

        call L1_2_2
        cmp CHCEK, 1
        je REPEAT_01

        call L1_2_3
        cmp CHCEK, 1
        je REPEAT_01

        call L1_2_4
        cmp CHCEK, 1
        je REPEAT_01

        call L1_2_5
        cmp CHCEK, 1
        je REPEAT_01

        ;------------

        call L2_3_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_4
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_5
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_4_1
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_5_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_4
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L1_LINE13
        cmp CHCEK,1
        je REPEAT_01

        call CHANGE_PLAYER
        dec y_pos
        call DRAW_PLAYER_LV1
        jmp SEC_LVL_01

    DOWN_IP:

        cmp y_pos,28
        je SEC_LVL_01

        mov bl,x_pos
        mov bh,y_pos
        inc bh
        mov CHCEK,0

        ;------------

        call L1_2_1
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_2
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_3
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_4
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_5
        cmp CHCEK,1
        je REPEAT_01

        ;------------

        call L2_3_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_4
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_5
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_4_1
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_5_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_4
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L1_LINE13
        cmp CHCEK,1
        je REPEAT_01

        call CHANGE_PLAYER
        inc y_pos
        call DRAW_PLAYER_LV1
        jmp SEC_LVL_01

     LEFT_IP:

        cmp x_pos,1
        je SEC_LVL_01

        mov bl,x_pos
        mov bh,y_pos
        dec bl
        mov CHCEK,0

        ;------------

        call L1_2_1
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_2
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_3
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_4
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_5
        cmp CHCEK,1
        je REPEAT_01

        ;------------

        call L2_3_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_4
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_5
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_4_1
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_5_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_4
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L1_LINE13
        cmp CHCEK,1
        je REPEAT_01

        call CHANGE_PLAYER
        dec x_pos
        call DRAW_PLAYER_LV1
        jmp SEC_LVL_01

    RIGHT_IP:

        cmp x_pos,118
        je SEC_LVL_01

        mov bl,x_pos
        mov bh,y_pos
        inc bl
        mov CHCEK,0

        ;-------------

        call L1_2_1
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_2
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_3
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_4
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_5
        cmp CHCEK,1
        je REPEAT_01

        ;------------

        call L2_3_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_4
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_5
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_4_1
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_5_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_4
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L1_LINE13
        cmp CHCEK,1
        je REPEAT_01

        call CHANGE_PLAYER
        inc x_pos
        call DRAW_PLAYER_LV1
        jmp SEC_LVL_01

REPEAT_01:
   jmp SEC_LVL_01

ret
BEGIN_GAME_01 ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;
PAUSE_GAME PROC

    ;mov dh, 33
    ;mov dl, 17
    ;call Gotoxy
    ;call waitmsg

    mov eax, 3000
    call delay

    
    ;mov dh, 33
    ;mov dl, 17
    ;call Gotoxy
    ;
    ;mwrite "---------------------------------"
    ;call crlf
    ;
    ;mov dh, 34
    ;mov dl, 17
    ;call Gotoxy
    ;mwrite "|   GAME PAUSED :: "
    ;
    ;mov PAUS_FLAG, 1
    ;mov eax, 1
    ;call writedec
    ;
    ;mov dh, 35
    ;mov dl, 17
    ;call Gotoxy
    ;mwrite "---------------------------------"
    ;call crlf
    ;
    ;mov dh, 38
    ;mov dl, 17
    ;call Gotoxy
    ;call waitmsg
    ;mov PAUS_FLAG, 0
    ;
    ;mov dh, 33
    ;mov dl, 17
    ;call Gotoxy
    ;
    ;mwrite "---------------------------------"
    ;call crlf
    ;
    ;mov dh, 34
    ;mov dl, 17
    ;call Gotoxy
    ;mwrite "|   GAME PAUSED :: "
    ;
    ;mov PAUS_FLAG, 1
    ;mov eax, 0
    ;call writedec
    ;
    ;mov dh, 35
    ;mov dl, 17
    ;call Gotoxy
    ;mwrite "---------------------------------"
    ;call crlf

ret
PAUSE_GAME ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;
TERMINATE PROC

    INVOKE PlaySound, OFFSET END_GAME_SOUND, NULL, 0h

    mov eax, magenta (brown*1)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf

    mwrite "                                 __   _______ _   _            _     _____ _____ _____  "
    call crlf
    mwrite "                                 \ \ / /  _  | | | |          | |   |  _  /  ___|  ___| "
    call crlf
    mwrite "                                  \ V /| | | | | | |  ______  | |   | | | \ `--.| |__   "
    call crlf
    mwrite "                                   \ / | | | | | | | |______| | |   | | | |`--. \  __|  "
    call crlf
    mwrite "                                   | | \ \_/ / |_| |          | |___\ \_/ /\__/ / |___  "
    call crlf
    mwrite "                                   \_/  \___/ \___/           \_____/\___/\____/\____/  "
    call crlf
    call crlf
    call crlf
    mwrite "                                        ---------------------------------"
    call crlf
    mwrite "                                        |    NAME   : "
    mov edx, OFFSET save_name
    call writestring
    call crlf
    mwrite "                                        |    SCORE  : "
    mov al, SCORE
    call writedec
    call crlf
    mwrite "                                        ---------------------------------"
    call crlf
    call crlf
    call crlf

    call waitmsg

ret
TERMINATE ENDP


;---------------------------  [ LEVEL ONE COLLISON WALLS PREVENTION CODE. {START} ] ----------------------

;------------- [1ST 2 DETECTION]

L1_2_1 PROC
    cmp bh, 5
    jne done1
    cmp bl, 20
    jl done1
    cmp bl, 40
    jg done1
    mov CHCEK, 1
done1:
    ret
L1_2_1 ENDP

L1_2_2 PROC
    cmp bl, 40
    jne done2
    cmp bh, 5
    jl done2
    cmp bh, 13
    jg done2
    mov CHCEK, 1
done2:
    ret
L1_2_2 ENDP

L1_2_3 PROC
    cmp bh, 13
    jne done3
    cmp bl, 20
    jl done3
    cmp bl, 40
    jg done3
    mov CHCEK, 1
done3:
    ret
L1_2_3 ENDP

L1_2_4 PROC
    cmp bl, 20
    jne done4
    cmp bh, 14
    jl done4
    cmp bh, 22
    jg done4
    mov CHCEK, 1
done4:
    ret
L1_2_4 ENDP

L1_2_5 PROC
    cmp bh, 22
    jne done5
    cmp bl, 20
    jl done5
    cmp bl, 40
    jg done5
    mov CHCEK, 1
done5:
    ret
L1_2_5 ENDP


;------------- [2ND 2 DETECTION ]


L2_3_1 PROC
    cmp bh, 5
    jne done1
    cmp bl, 50
    jl done1
    cmp bl, 70
    jg done1
    mov CHCEK, 1
done1:
    ret
L2_3_1 ENDP

L2_3_2 PROC
    cmp bl, 70
    jne done2
    cmp bh, 5
    jl done2
    cmp bh, 13
    jg done2
    mov CHCEK, 1
done2:
    ret
L2_3_2 ENDP

L2_3_3 PROC
    cmp bh, 13
    jne done3
    cmp bl, 50
    jl done3
    cmp bl, 70
    jg done3
    mov CHCEK, 1
done3:
    ret
L2_3_3 ENDP

L2_3_4 PROC
    cmp bl, 50
    jne done4
    cmp bh, 14
    jl done4
    cmp bh, 22
    jg done4
    mov CHCEK, 1
done4:
    ret
L2_3_4 ENDP

L2_3_5 PROC
    cmp bh, 22
    jne done5
    cmp bl, 50
    jl done5
    cmp bl, 70
    jg done5
    mov CHCEK, 1
done5:
    ret
L2_3_5 ENDP


;------------- [1 COLLISION PREVENTION ]

L2_4_1 PROC
    cmp bl, 80
    jne done1
    cmp bh, 5
    jl done1
    cmp bh, 22
    jg done1
    mov CHCEK, 1
done1:
    ret
L2_4_1 ENDP

;------------- [4 COLLISION PREVENTION ]

L2_5_1 PROC
    cmp bl, 90
    jne done1
    cmp bh, 5
    jl done1
    cmp bh, 13
    jg done1
    mov CHCEK, 1
done1:
    ret
L2_5_1 ENDP

L2_5_2 PROC
    cmp bh, 13
    jne done2
    cmp bl, 90
    jl done2
    cmp bl, 110
    jg done2
    mov CHCEK, 1
done2:
    ret
L2_5_2 ENDP

L2_5_3 PROC
    cmp bl, 110
    jne done3
    cmp bh, 5
    jl done3
    cmp bh, 13
    jg done3
    mov CHCEK, 1
done3:
    ret
L2_5_3 ENDP

L2_5_4 PROC
    cmp bl, 110
    jne done4
    cmp bh, 12
    jl done4
    cmp bh, 22
    jg done4
    mov CHCEK, 1
done4:
    ret
L2_5_4 ENDP

;----------------------------

; LEFT WALI BARI LINE
L1_LINE13 PROC
        cmp bh, 26
        jne done
        cmp bl, 110
        jg done
        cmp bl, 20
        jl done
        mov CHCEK, 1
done:
        ret
L1_LINE13 ENDP


;---------------------------  [ LEVEL ONE COLLISON WALLS PREVENTION CODE. {END} ] ----------------------



;--------------------------- [ LEVEL TWO YAHA PRR BNNN RAHA HY ] ----------------------

MAIN_GAME_FUN_2 PROC

    call DISPLAY_LVL_02
    
    mov eax,black (black)
    call SetTextColor
    call clrscr

    mov eax,lightGreen (lightGreen * 16)
    call SetTextColor

    mov eax, 900
    call delay
    mov dl, 0
    mov dh, 29
    call Gotoxy
    mov edx,OFFSET H_BASE
    call WriteString

    mov dl, 0
    mov dh, 1
    call Gotoxy
    mov edx,OFFSET H_BASE
    call WriteString

    ; RIGHT SIDE VERTICAL LINE.

    mov ecx, 27
    mov dh, 2
    mov TEMP, dh
    L_1:
        mov dh, TEMP
        mov dl,0
        call Gotoxy
        mov edx,OFFSET LINE_BREAK
        call WriteString
        inc TEMP
    loop L_1

    mov ecx,27
    mov dh,2
    mov TEMP,dh
    L_2:
        mov dh,TEMP
        mov dl,119
        call Gotoxy
        mwrite "|"
        inc TEMP
    loop L_2

    ;-------------- MAKING FIRST 2 ----------------
    
    mov ecx,20
    mov dl,20
    mov TEMP,dl
    L_6:
        mov dl,TEMP
        mov dh,5
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_6

    mov ecx, 8
    mov dh, 5
    mov TEMP,dh
    L_6_1:
        mov dh,TEMP
        mov dl, 40
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_6_1

    mov ecx,20
    mov dl,20
    mov TEMP,dl
    L_6_2:
        mov dl,TEMP
        mov dh,13
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_6_2

    mov ecx, 8
    mov dh, 14
    mov TEMP,dh
    L_6_3:
        mov dh,TEMP
        mov dl, 20
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_6_3

    mov ecx,20
    mov dl,20
    mov TEMP,dl
    L_6_4:
        mov dl,TEMP
        mov dh, 22
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_6_4


    ;-------------  MAKING SECOND TWO. -----------------

    mov ecx, 20
    mov dl, 50
    mov TEMP,dl
    L_7:
        mov dl,TEMP
        mov dh,5
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_7

    ;//REVIEW -
    mov ecx, 8
    mov dh, 5
    mov TEMP,dh
    L_7_1:
        mov dh,TEMP
        mov dl, 70
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_7_1

    mov ecx,20
    mov dl, 50
    mov TEMP,dl
    L_7_2:
        mov dl,TEMP
        mov dh,13
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_7_2

    mov ecx, 8
    mov dh, 14
    mov TEMP,dh
    L_7_3:
        mov dh,TEMP
        mov dl, 50
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_7_3

    mov ecx, 20
    mov dl, 50
    mov TEMP,dl
    L_7_4:
        mov dl,TEMP
        mov dh, 22
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_7_4

    ;--------------  ONE MAKING HERE. --------------------

    mov ecx, 18
    mov dh, 5
    mov TEMP,dh
    L_8:
        mov dh,TEMP
        mov dl, 80
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_8

    ;--------------  FOUR MAKING HERE. --------------------

    mov ecx, 9
    mov dh, 5
    mov TEMP,dh
    L_9_1:
        mov dh,TEMP
        mov dl, 90
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_9_1
 

    mov ecx, 20
    mov dl, 90
    mov TEMP,dl
    L_9:
        mov dl,TEMP
        mov dh, 13
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_9

    mov ecx, 9
    mov dh, 5
    mov TEMP,dh
    L_9_3:
        mov dh,TEMP
        mov dl, 110
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_9_3

    mov ecx, 11
    mov dh, 12
    mov TEMP,dh
    L_9_2:
        mov dh,TEMP
        mov dl, 110
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_9_2

    ;ANDER[NECHY] WALI HORIZONTAL LINE.
    
    mov ecx,90
    mov dl,20
    mov TEMP,dl
    L_10:
        mov dl,TEMP
        mov dh,26
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_10

    call DRAW_PLAYER_LV1
    call PRINT_LVL2_STAR
    call BEGIN_GAME_02
    call crlf
    call waitmsg


ret
MAIN_GAME_FUN_2 ENDP


;//NOTE - 
;;;;;;;;;;;;;;;;;;;;;;;;;;;
BEGIN_GAME_02 PROC


    SEC_LVL_02:
        mov bl,x_pos
        mov bh,y_pos

        call MOV_G1_L2
        call PRINT_G1_L2

        call MOV_G2_L2
        call PRINT_G2_L2

        call MOV_G3_L2
        call PRINT_G3_L2

        call MOV_G4_L2
        call PRINT_G4_L2

        call MOV_G5_L2
        call PRINT_G5_L2

        call MOV_G6_L2
        call PRINT_G6_L2

        call MOV_G7_L2
        call PRINT_G7_L2

        call MOV_G8_L2
        call PRINT_G8_L2
    
        call COLIDE_G1_L2
        call COLIDE_G2_L2
        call COLIDE_G3_L2
        call COLIDE_G4_L2
        call COLIDE_G5_L2
        call COLIDE_G6_L2
        call COLIDE_G7_L2
        call COLIDE_G8_L2

        mov cx, 1
        mov dx, 75

        check_star1:
            
            mov bl, x_pos
            cmp bl, STAR_X[0]
            jne check_star2
            mov bl, y_pos
            cmp bl, STAR_Y[0]
            jne check_star2
            inc SCORE
            mov STAR_X[0], 0
            mov STAR_Y[0], 0

        check_star2:
            mov bl, x_pos
            cmp bl, STAR_X[1]
            jne check_star3
            mov bl, y_pos
            cmp bl, STAR_Y[1]
            jne check_star3
            inc SCORE
            mov STAR_X[1], 0
            mov STAR_Y[1], 0

        check_star3:
            mov bl, x_pos
            cmp bl, STAR_X[2]
            jne check_star4
            mov bl, y_pos
            cmp bl, STAR_Y[2]
            jne check_star4
            inc SCORE
            mov STAR_X[2], 0
            mov STAR_Y[2], 0

        check_star4:
            mov bl, x_pos
            cmp bl, STAR_X[3]
            jne check_star5
            mov bl, y_pos
            cmp bl, STAR_Y[3]
            jne check_star5
            inc SCORE
            mov STAR_X[3], 0
            mov STAR_Y[3], 0

        check_star5:
            mov bl, x_pos
            cmp bl, STAR_X[4]
            jne check_star6
            mov bl, y_pos
            cmp bl, STAR_Y[4]
            jne check_star6
            inc SCORE
            mov STAR_X[4], 0
            mov STAR_Y[4], 0

        check_star6:
            mov bl, x_pos
            cmp bl, STAR_X[5]
            jne check_star7
            mov bl, y_pos
            cmp bl, STAR_Y[5]
            jne check_star7
            inc SCORE
            mov STAR_X[5], 0
            mov STAR_Y[5], 0

        check_star7:
            mov bl, x_pos
            cmp bl, STAR_X[6]
            jne check_star8
            mov bl, y_pos
            cmp bl, STAR_Y[6]
            jne check_star8
            inc SCORE
            mov STAR_X[6], 0
            mov STAR_Y[6], 0

        check_star8:
            mov bl, x_pos
            cmp bl, STAR_X[7]
            jne check_star9
            mov bl, y_pos
            cmp bl, STAR_Y[7]
            jne check_star9
            inc SCORE
            mov STAR_X[7], 0
            mov STAR_Y[7], 0

        check_star9:
            mov bl, x_pos
            cmp bl, STAR_X[8]
            jne check_star10
            mov bl, y_pos
            cmp bl, STAR_Y[8]
            jne check_star10
            inc SCORE
            mov STAR_X[8], 0
            mov STAR_Y[8], 0

        check_star10:
            mov bl, x_pos
            cmp bl, STAR_X[9]
            jne check_star11
            mov bl, y_pos
            cmp bl, STAR_Y[9]
            jne check_star11
            inc SCORE
            mov STAR_X[9], 0
            mov STAR_Y[9], 0

        check_star11:
            mov bl, x_pos
            cmp bl, STAR_X[10]
            jne check_star12
            mov bl, y_pos
            cmp bl, STAR_Y[10]
            jne check_star12
            inc SCORE
            mov STAR_X[10], 0
            mov STAR_Y[10], 0

        check_star12:
            mov bl, x_pos
            cmp bl, STAR_X[11]
            jne check_star13
            mov bl, y_pos
            cmp bl, STAR_Y[11]
            jne check_star13
            inc SCORE
            mov STAR_X[11], 0
            mov STAR_Y[11], 0

        check_star13:
            mov bl, x_pos
            cmp bl, STAR_X[12]
            jne check_star14
            mov bl, y_pos
            cmp bl, STAR_Y[12]
            jne check_star14
            inc SCORE
            mov STAR_X[12], 0
            mov STAR_Y[12], 0

        check_star14:
            mov bl, x_pos
            cmp bl, STAR_X[13]
            jne check_star15
            mov bl, y_pos
            cmp bl, STAR_Y[13]
            jne check_star15
            inc SCORE
            mov STAR_X[13], 0
            mov STAR_Y[13], 0

        check_star15:
            mov bl, x_pos
            cmp bl, STAR_X[14]
            jne check_star16
            mov bl, y_pos
            cmp bl, STAR_Y[14]
            jne check_star16
            inc SCORE
            mov STAR_X[14], 0
            mov STAR_Y[14], 0

        check_star16:
            mov bl, x_pos
            cmp bl, STAR_X[15]
            jne check_star17
            mov bl, y_pos
            cmp bl, STAR_Y[15]
            jne check_star17
            inc SCORE
            mov STAR_X[15], 0
            mov STAR_Y[15], 0

        check_star17:
            mov bl, x_pos
            cmp bl, STAR_X[16]
            jne check_star18
            mov bl, y_pos
            cmp bl, STAR_Y[16]
            jne check_star18
            inc SCORE
            mov STAR_X[16], 0
            mov STAR_Y[16], 0

        check_star18:
            mov bl, x_pos
            cmp bl, STAR_X[17]
            jne check_star19
            mov bl, y_pos
            cmp bl, STAR_Y[17]
            jne check_star19
            inc SCORE
            mov STAR_X[17], 0
            mov STAR_Y[17], 0

        check_star19:
            mov bl, x_pos
            cmp bl, STAR_X[18]
            jne check_star20
            mov bl, y_pos
            cmp bl, STAR_Y[18]
            jne check_star20
            inc SCORE
            mov STAR_X[18], 0
            mov STAR_Y[18], 0

        check_star20:
            mov bl, x_pos
            cmp bl, STAR_X[19]
            jne check_star21
            mov bl, y_pos
            cmp bl, STAR_Y[19]
            jne check_star21
            inc SCORE
            mov STAR_X[19], 0
            mov STAR_Y[19], 0

        check_star21:
            mov bl, x_pos
            cmp bl, STAR_X[20]
            jne check_star22
            mov bl, y_pos
            cmp bl, STAR_Y[20]
            jne check_star22
            inc SCORE
            mov STAR_X[20], 0
            mov STAR_Y[20], 0

        check_star22:
            mov bl, x_pos
            cmp bl, STAR_X[21]
            jne check_star23
            mov bl, y_pos
            cmp bl, STAR_Y[21]
            jne check_star23
            inc SCORE
            mov STAR_X[21], 0
            mov STAR_Y[21], 0

        check_star23:
            mov bl, x_pos
            cmp bl, STAR_X[22]
            jne check_star24
            mov bl, y_pos
            cmp bl, STAR_Y[22]
            jne check_star24
            inc SCORE
            mov STAR_X[22], 0
            mov STAR_Y[22], 0

        check_star24:
            mov bl, x_pos
            cmp bl, STAR_X[23]
            jne check_star25
            mov bl, y_pos
            cmp bl, STAR_Y[23]
            jne check_star25
            inc SCORE
            mov STAR_X[23], 0
            mov STAR_Y[23], 0

        check_star25:
            mov bl, x_pos
            cmp bl, STAR_X[24]
            jne check_star26
            mov bl, y_pos
            cmp bl, STAR_Y[24]
            jne check_star26
            inc SCORE
            mov STAR_X[24], 0
            mov STAR_Y[24], 0

        check_star26:
            mov bl, x_pos
            cmp bl, STAR_X[25]
            jne check_star27
            mov bl, y_pos
            cmp bl, STAR_Y[25]
            jne check_star27
            inc SCORE
            mov STAR_X[25], 0
            mov STAR_Y[25], 0

        check_star27:
            mov bl, x_pos
            cmp bl, STAR_X[26]
            jne check_star28
            mov bl, y_pos
            cmp bl, STAR_Y[26]
            jne check_star28
            inc SCORE
            mov STAR_X[26], 0
            mov STAR_Y[26], 0

        check_star28:
            mov bl, x_pos
            cmp bl, STAR_X[27]
            jne check_star29
            mov bl, y_pos
            cmp bl, STAR_Y[27]
            jne check_star29
            inc SCORE
            mov STAR_X[27], 0
            mov STAR_Y[27], 0

        check_star29:
            mov bl, x_pos
            cmp bl, STAR_X[28]
            jne check_star30
            mov bl, y_pos
            cmp bl, STAR_Y[28]
            jne check_star30
            inc SCORE
            mov STAR_X[28], 0
            mov STAR_Y[28], 0

        check_star30:
            mov bl, x_pos
            cmp bl, STAR_X[29]
            jne check_star31
            mov bl, y_pos
            cmp bl, STAR_Y[29]
            jne check_star31
            inc SCORE
            mov STAR_X[29], 0
            mov STAR_Y[29], 0

        check_star31:
            mov bl, x_pos
            cmp bl, STAR_X[30]
            jne check_star32
            mov bl, y_pos
            cmp bl, STAR_Y[30]
            jne check_star32
            inc SCORE
            mov STAR_X[30], 0
            mov STAR_Y[30], 0

        check_star32:
            mov bl, x_pos
            cmp bl, STAR_X[31]
            jne check_star33
            mov bl, y_pos
            cmp bl, STAR_Y[31]
            jne check_star33
            inc SCORE
            mov STAR_X[31], 0
            mov STAR_Y[31], 0

        check_star33:
            mov bl, x_pos
            cmp bl, STAR_X[32]
            jne check_star34
            mov bl, y_pos
            cmp bl, STAR_Y[32]
            jne check_star34
            inc SCORE
            mov STAR_X[32], 0
            mov STAR_Y[32], 0

        check_star34:
            mov bl, x_pos
            cmp bl, STAR_X[33]
            jne check_star35
            mov bl, y_pos
            cmp bl, STAR_Y[33]
            jne check_star35
            inc SCORE
            mov STAR_X[33], 0
            mov STAR_Y[33], 0

        check_star35:
            mov bl, x_pos
            cmp bl, STAR_X[34]
            jne check_star36
            mov bl, y_pos
            cmp bl, STAR_Y[34]
            jne check_star36
            inc SCORE
            mov STAR_X[34], 0
            mov STAR_Y[34], 0

        check_star36:
            mov bl, x_pos
            cmp bl, STAR_X[35]
            jne check_star37
            mov bl, y_pos
            cmp bl, STAR_Y[35]
            jne check_star37
            inc SCORE
            mov STAR_X[35], 0
            mov STAR_Y[35], 0

        check_star37:
            mov bl, x_pos
            cmp bl, STAR_X[36]
            jne check_star38
            mov bl, y_pos
            cmp bl, STAR_Y[36]
            jne check_star38
            inc SCORE
            mov STAR_X[36], 0
            mov STAR_Y[36], 0

        check_star38:
            mov bl, x_pos
            cmp bl, STAR_X[37]
            jne check_star39
            mov bl, y_pos
            cmp bl, STAR_Y[37]
            jne check_star39
            inc SCORE
            mov STAR_X[37], 0
            mov STAR_Y[37], 0

        check_star39:
            mov bl, x_pos
            cmp bl, STAR_X[38]
            jne check_star40
            mov bl, y_pos
            cmp bl, STAR_Y[38]
            jne check_star40
            inc SCORE
            mov STAR_X[38], 0
            mov STAR_Y[38], 0

        check_star40:
            mov bl, x_pos
            cmp bl, STAR_X[39]
            jne check_star41
            mov bl, y_pos
            cmp bl, STAR_Y[39]
            jne check_star41
            inc SCORE
            mov STAR_X[39], 0
            mov STAR_Y[39], 0

        check_star41:
            mov bl, x_pos
            cmp bl, STAR_X[40]
            jne check_star42
            mov bl, y_pos
            cmp bl, STAR_Y[40]
            jne check_star42
            inc SCORE
            mov STAR_X[40], 0
            mov STAR_Y[40], 0

        check_star42:
            mov bl, x_pos
            cmp bl, STAR_X[41]
            jne check_star43
            mov bl, y_pos
            cmp bl, STAR_Y[41]
            jne check_star43
            inc SCORE
            mov STAR_X[41], 0
            mov STAR_Y[41], 0

        check_star43:
            mov bl, x_pos
            cmp bl, STAR_X[42]
            jne check_star44
            mov bl, y_pos
            cmp bl, STAR_Y[42]
            jne check_star44
            inc SCORE
            mov STAR_X[42], 0
            mov STAR_Y[42], 0

        check_star44:
            mov bl, x_pos
            cmp bl, STAR_X[43]
            jne check_star45
            mov bl, y_pos
            cmp bl, STAR_Y[43]
            jne check_star45
            inc SCORE
            mov STAR_X[43], 0
            mov STAR_Y[43], 0

        check_star45:
            mov bl, x_pos
            cmp bl, STAR_X[44]
            jne check_star46
            mov bl, y_pos
            cmp bl, STAR_Y[44]
            jne check_star46
            inc SCORE
            mov STAR_X[44], 0
            mov STAR_Y[44], 0

        check_star46:
            mov bl, x_pos
            cmp bl, STAR_X[45]
            jne check_star47
            mov bl, y_pos
            cmp bl, STAR_Y[45]
            jne check_star47
            inc SCORE
            mov STAR_X[45], 0
            mov STAR_Y[45], 0

        check_star47:
            mov bl, x_pos
            cmp bl, STAR_X[46]
            jne check_star48
            mov bl, y_pos
            cmp bl, STAR_Y[46]
            jne check_star48
            inc SCORE
            mov STAR_X[46], 0
            mov STAR_Y[46], 0

        check_star48:
            mov bl, x_pos
            cmp bl, STAR_X[47]
            jne check_star49
            mov bl, y_pos
            cmp bl, STAR_Y[47]
            jne check_star49
            inc SCORE
            mov STAR_X[47], 0
            mov STAR_Y[47], 0

        check_star49:
            mov bl, x_pos
            cmp bl, STAR_X[48]
            jne check_star50
            mov bl, y_pos
            cmp bl, STAR_Y[48]
            jne check_star50
            inc SCORE
            mov STAR_X[48], 0
            mov STAR_Y[48], 0

        check_star50:
            mov bl, x_pos
            cmp bl, STAR_X[49]
            jne check_star51
            mov bl, y_pos
            cmp bl, STAR_Y[49]
            jne check_star51
            inc SCORE
            mov STAR_X[49], 0
            mov STAR_Y[49], 0

        check_star51:
            mov bl, x_pos
            cmp bl, STAR_X[50]
            jne check_star52
            mov bl, y_pos
            cmp bl, STAR_Y[50]
            jne check_star52
            inc SCORE
            mov STAR_X[50], 0
            mov STAR_Y[50], 0

        check_star52:
            mov bl, x_pos
            cmp bl, STAR_X[51]
            jne check_star53
            mov bl, y_pos
            cmp bl, STAR_Y[51]
            jne check_star53
            inc SCORE
            mov STAR_X[51], 0
            mov STAR_Y[51], 0

        check_star53:
            mov bl, x_pos
            cmp bl, STAR_X[52]
            jne check_star54
            mov bl, y_pos
            cmp bl, STAR_Y[52]
            jne check_star54
            inc SCORE
            mov STAR_X[52], 0
            mov STAR_Y[52], 0

        check_star54:
            mov bl, x_pos
            cmp bl, STAR_X[53]
            jne check_star55
            mov bl, y_pos
            cmp bl, STAR_Y[53]
            jne check_star55
            inc SCORE
            mov STAR_X[53], 0
            mov STAR_Y[53], 0

        check_star55:
            mov bl, x_pos
            cmp bl, STAR_X[54]
            jne check_star56
            mov bl, y_pos
            cmp bl, STAR_Y[54]
            jne check_star56
            inc SCORE
            mov STAR_X[54], 0
            mov STAR_Y[54], 0

        check_star56:
            mov bl, x_pos
            cmp bl, STAR_X[55]
            jne check_star57
            mov bl, y_pos
            cmp bl, STAR_Y[55]
            jne check_star57
            inc SCORE
            mov STAR_X[55], 0
            mov STAR_Y[55], 0

        check_star57:
            mov bl, x_pos
            cmp bl, STAR_X[56]
            jne check_star58
            mov bl, y_pos
            cmp bl, STAR_Y[56]
            jne check_star58
            inc SCORE
            mov STAR_X[56], 0
            mov STAR_Y[56], 0

        check_star58:
            mov bl, x_pos
            cmp bl, STAR_X[57]
            jne check_star59
            mov bl, y_pos
            cmp bl, STAR_Y[57]
            jne check_star59
            inc SCORE
            mov STAR_X[57], 0
            mov STAR_Y[57], 0

        check_star59:
            mov bl, x_pos
            cmp bl, STAR_X[58]
            jne check_star60
            mov bl, y_pos
            cmp bl, STAR_Y[58]
            jne check_star60
            inc SCORE
            mov STAR_X[58], 0
            mov STAR_Y[58], 0

        check_star60:
            mov bl, x_pos
            cmp bl, STAR_X[59]
            jne check_star61
            mov bl, y_pos
            cmp bl, STAR_Y[59]
            jne check_star61
            inc SCORE
            mov STAR_X[59], 0
            mov STAR_Y[59], 0

        check_star61:
            mov bl, x_pos
            cmp bl, STAR_X[60]
            jne check_star62
            mov bl, y_pos
            cmp bl, STAR_Y[60]
            jne check_star62
            inc SCORE
            mov STAR_X[60], 0
            mov STAR_Y[60], 0

        check_star62:
            mov bl, x_pos
            cmp bl, STAR_X[61]
            jne check_star63
            mov bl, y_pos
            cmp bl, STAR_Y[61]
            jne check_star63
            inc SCORE
            mov STAR_X[61], 0
            mov STAR_Y[61], 0

        check_star63:
            mov bl, x_pos
            cmp bl, STAR_X[62]
            jne check_star64
            mov bl, y_pos
            cmp bl, STAR_Y[62]
            jne check_star64
            inc SCORE
            mov STAR_X[62], 0
            mov STAR_Y[62], 0

        check_star64:
            mov bl, x_pos
            cmp bl, STAR_X[63]
            jne check_star65
            mov bl, y_pos
            cmp bl, STAR_Y[63]
            jne check_star65
            inc SCORE
            mov STAR_X[63], 0
            mov STAR_Y[63], 0

        check_star65:
            mov bl, x_pos
            cmp bl, STAR_X[64]
            jne check_star66
            mov bl, y_pos
            cmp bl, STAR_Y[64]
            jne check_star66
            inc SCORE
            mov STAR_X[64], 0
            mov STAR_Y[64], 0

        check_star66:
            mov bl, x_pos
            cmp bl, STAR_X[65]
            jne check_star67
            mov bl, y_pos
            cmp bl, STAR_Y[65]
            jne check_star67
            inc SCORE
            mov STAR_X[65], 0
            mov STAR_Y[65], 0

        check_star67:
            mov bl, x_pos
            cmp bl, STAR_X[66]
            jne check_star68
            mov bl, y_pos
            cmp bl, STAR_Y[66]
            jne check_star68
            inc SCORE
            mov STAR_X[66], 0
            mov STAR_Y[66], 0

        check_star68:
            mov bl, x_pos
            cmp bl, STAR_X[67]
            jne check_star69
            mov bl, y_pos
            cmp bl, STAR_Y[67]
            jne check_star69
            inc SCORE
            mov STAR_X[67], 0
            mov STAR_Y[67], 0

        check_star69:
            mov bl, x_pos
            cmp bl, STAR_X[68]
            jne check_star70
            mov bl, y_pos
            cmp bl, STAR_Y[68]
            jne check_star70
            inc SCORE
            mov STAR_X[68], 0
            mov STAR_Y[68], 0

        check_star70:
            mov bl, x_pos
            cmp bl, STAR_X[69]
            jne check_star71
            mov bl, y_pos
            cmp bl, STAR_Y[69]
            jne check_star71
            inc SCORE
            mov STAR_X[69], 0
            mov STAR_Y[69], 0

        check_star71:
            mov bl, x_pos
            cmp bl, STAR_X[70]
            jne check_star72
            mov bl, y_pos
            cmp bl, STAR_Y[70]
            jne check_star72
            inc SCORE
            mov STAR_X[70], 0
            mov STAR_Y[70], 0

        check_star72:
            mov bl, x_pos
            cmp bl, STAR_X[71]
            jne check_star73
            mov bl, y_pos
            cmp bl, STAR_Y[71]
            jne check_star73
            inc SCORE
            mov STAR_X[71], 0
            mov STAR_Y[71], 0

        check_star73:
            mov bl, x_pos
            cmp bl, STAR_X[72]
            jne check_star74
            mov bl, y_pos
            cmp bl, STAR_Y[72]
            jne check_star74
            inc SCORE
            mov STAR_X[72], 0
            mov STAR_Y[72], 0

        check_star74:
            mov bl, x_pos
            cmp bl, STAR_X[73]
            jne check_star75
            mov bl, y_pos
            cmp bl, STAR_Y[73]
            jne check_star75
            inc SCORE
            mov STAR_X[73], 0
            mov STAR_Y[73], 0

        check_star75:
            
            mov bl, x_pos
            cmp bl, STAR_X[74]
            jne check_coin1
            mov bl, y_pos
            cmp bl, STAR_Y[74]
            jne check_coin1
            inc SCORE
            mov STAR_X[74], 0
            mov STAR_Y[74], 0

        check_coin1:
            mov bl, x_pos
            cmp bl, 5
            jne check_coin2
            mov bl, y_pos
            cmp bl, 14
            jne check_coin2
            add SCORE, 5
            mov coin_x, 0
            mov coin_y, 0

        check_coin2:
            mov bl, x_pos
            cmp bl, 116
            jne star_finish_1
            mov bl, y_pos
            cmp bl, 14
            jne star_finish_1
            add SCORE, 5
            mov coin_x, 0
            mov coin_y, 0


        star_finish_1:

        mov eax,white
        call SetTextColor

        ; draw SCORE:
        mov dl, 0
        mov dh, 0
        call Gotoxy
        mwrite "SCORE : "
        mov eax, 0
        mov al, SCORE
        cmp SCORE, 5 ;//ANCHOR - 
        jge ENDED_LVL_02
        call WriteDEC

        mov dl, 57
        mov dh, 0
        call Gotoxy
        mwrite "LIVES : "
        mov eax,0
        mov al, LIVES
        call WRITEDEC
        cmp LIVES,0
        je TERMINATE

        mov dl, 110
        mov dh, 0
        call Gotoxy
        mwrite "LEVEL : "
        mov eax, 0
        mov al, 2
        call WRITEDEC

        ; ITERATIVE logic:
        ITERATIVE:
            cmp y_pos,0
            jg TAKE_IP_AGAIN

            call CHANGE_PLAYER
            inc y_pos
            call DRAW_PLAYER_LV1
            mov eax,80
            call Delay
            jmp ITERATIVE
        TAKE_IP_AGAIN:
        
        call ReadKey
        jz NOT_ENTERED
            mov MOVE, al
        NOT_ENTERED:

        mov eax, 60
        call DELAY

       cmp MOVE, "p"
       je STOP_IT

        cmp MOVE, "e"
        je TERMINATE

        cmp MOVE, "w"
        je UP_IP

        cmp MOVE, "z"
        je DOWN_IP

        cmp MOVE, "a"
        je LEFT_IP

        cmp MOVE, "s"
        je RIGHT_IP

    STOP_IT:
       call PAUSE_GAME

     ;----------------------
     ;   DETECT AND STOP IF COLLISION DETECETED IN UPPER INPUT.
     ;----------------------
     UP_IP:

        cmp y_pos,2
        je SEC_LVL_02

        mov bl,x_pos
        mov bh,y_pos
        dec bh
        mov CHCEK,0

        call L1_2_1
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_2
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_3
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_4
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_5
        cmp CHCEK,1
        je REPEAT_01

        ;------------

        call L2_3_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_4
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_5
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_4_1
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_5_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_4
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L1_LINE13
        cmp CHCEK,1
        je REPEAT_01

        call CHANGE_PLAYER
        dec y_pos
        call DRAW_PLAYER_LV1
        jmp SEC_LVL_02


    ;-------------------------------------------------------
    ;   DETECT AND STOP IF COLLISION DETECETED IN DOWN INPUT.
    ;-------------------------------------------------------
    DOWN_IP:

        cmp y_pos,28
        je SEC_LVL_02

        mov bl,x_pos
        mov bh,y_pos
        inc bh
        mov CHCEK,0

        ;------------

        call L1_2_1
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_2
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_3
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_4
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_5
        cmp CHCEK,1
        je REPEAT_01

        ;------------

        call L2_3_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_4
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_5
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_4_1
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_5_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_4
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L1_LINE13
        cmp CHCEK,1
        je REPEAT_01

        call CHANGE_PLAYER
        inc y_pos
        call DRAW_PLAYER_LV1
        jmp SEC_LVL_02


    
     ;-------------------------------------------------------
     ;   DETECT AND STOP IF COLLISION DETECETED IN LEFT INPUT.
     ;-------------------------------------------------------
     LEFT_IP:

        cmp x_pos,1
        je SEC_LVL_02

        mov bl,x_pos
        mov bh,y_pos
        dec bl
        mov CHCEK,0

        ;------------

        call L1_2_1
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_2
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_3
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_4
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_5
        cmp CHCEK,1
        je REPEAT_01

        ;------------

        call L2_3_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_4
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_5
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_4_1
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_5_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_4
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L1_LINE13
        cmp CHCEK,1
        je REPEAT_01

        call CHANGE_PLAYER
        dec x_pos
        call DRAW_PLAYER_LV1
        jmp SEC_LVL_02

    ;-------------------------------------------------------
    ;   DETECT AND STOP IF COLLISION DETECETED IN RIGHT INPUT.
    ;-------------------------------------------------------
    RIGHT_IP:

        cmp x_pos,118
        je SEC_LVL_02

        mov bl,x_pos
        mov bh,y_pos
        inc bl
        mov CHCEK,0

        ;-------------

        call L1_2_1
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_2
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_3
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_4
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_5
        cmp CHCEK,1
        je REPEAT_01

        ;------------

        call L2_3_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_4
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_5
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_4_1
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_5_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_4
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L1_LINE13
        cmp CHCEK,1
        je REPEAT_01

        call CHANGE_PLAYER
        inc x_pos
        call DRAW_PLAYER_LV1
        jmp SEC_LVL_02

REPEAT_01:
   jmp SEC_LVL_02

ret
BEGIN_GAME_02 ENDP


;//TODO - --------------------------------------------------------------------------
;----------------------- [STARTING THE THIRD LEVEL PRODUCTION] ------------
;--------------------------------------------------------------------------

MAIN_GAME_FUN_3 PROC

    call DISPLAY_LVL_03
    
    mov eax,black (black)
    call SetTextColor
    call clrscr

    mov eax, red (red * 16)
    call SetTextColor

    mov eax, 500
    call delay
    mov dl, 0
    mov dh, 29
    call Gotoxy
    mov edx,OFFSET H_BASE
    call WriteString

    mov dl, 0
    mov dh, 1
    call Gotoxy
    mov edx,OFFSET H_BASE
    call WriteString

    ; LEFT SIDE VERTICAL LINE.

    mov ecx, 25
    mov dh, 3
    mov TEMP, dh
    L_1:
        mov dh, TEMP
        mov dl,0
        call Gotoxy
        mov edx,OFFSET LINE_BREAK
        call WriteString
        inc TEMP
    loop L_1

    ; RIGHT SIDE VERTICAL LINE.

    mov ecx,25
    mov dh,3
    mov TEMP,dh
    L_2:
        mov dh,TEMP
        mov dl,119
        call Gotoxy
        mwrite "|"
        inc TEMP
    loop L_2

    ;-------------- MAKING FIRST 2 ----------------
    
    mov ecx,20
    mov dl,20
    mov TEMP,dl
    L_6:
        mov dl,TEMP
        mov dh,5
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_6

    mov ecx, 8
    mov dh, 5
    mov TEMP,dh
    L_6_1:
        mov dh,TEMP
        mov dl, 40
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_6_1

    mov ecx,20
    mov dl,20
    mov TEMP,dl
    L_6_2:
        mov dl,TEMP
        mov dh,13
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_6_2

    mov ecx, 8
    mov dh, 14
    mov TEMP,dh
    L_6_3:
        mov dh,TEMP
        mov dl, 20
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_6_3

    mov ecx,20
    mov dl,20
    mov TEMP,dl
    L_6_4:
        mov dl,TEMP
        mov dh, 22
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_6_4

    ;-------------  MAKING SECOND TWO. -----------------

    mov ecx, 20
    mov dl, 50
    mov TEMP,dl
    L_7:
        mov dl,TEMP
        mov dh,5
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_7

    ;//REVIEW -
    mov ecx, 8
    mov dh, 5
    mov TEMP,dh
    L_7_1:
        mov dh,TEMP
        mov dl, 70
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_7_1

    mov ecx,20
    mov dl, 50
    mov TEMP,dl
    L_7_2:
        mov dl,TEMP
        mov dh,13
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_7_2

    mov ecx, 8
    mov dh, 14
    mov TEMP,dh
    L_7_3:
        mov dh,TEMP
        mov dl, 50
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_7_3

    mov ecx, 20
    mov dl, 50
    mov TEMP,dl
    L_7_4:
        mov dl,TEMP
        mov dh, 22
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_7_4

    ;--------------  ONE MAKING HERE. --------------------

    mov ecx, 18
    mov dh, 5
    mov TEMP,dh
    L_8:
        mov dh,TEMP
        mov dl, 80
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_8

    ;--------------  FOUR MAKING HERE. --------------------

    mov ecx, 9
    mov dh, 5
    mov TEMP,dh
    L_9_1:
        mov dh,TEMP
        mov dl, 90
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_9_1
 

    mov ecx, 20
    mov dl, 90
    mov TEMP,dl
    L_9:
        mov dl,TEMP
        mov dh, 13
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_9

    mov ecx, 9
    mov dh, 5
    mov TEMP,dh
    L_9_3:
        mov dh,TEMP
        mov dl, 110
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_9_3

    mov ecx, 11
    mov dh, 12
    mov TEMP,dh
    L_9_2:
        mov dh,TEMP
        mov dl, 110
        call Gotoxy
        mwrite "|"
    inc TEMP
    loop L_9_2

    ;ANDER[NECHY] WALI HORIZONTAL LINE.
    
    mov ecx,90
    mov dl,20
    mov TEMP,dl
    L_10:
        mov dl,TEMP
        mov dh,26
        call Gotoxy
        mwrite "-"
        inc TEMP
    loop L_10

    call DRAW_PLAYER_LV1
    call PRINT_LVL2_STAR

    mov coin_x, 5 
    mov coin_y, 14
    call PRINT_COIN

    mov coin_x, 116 
    mov coin_y, 14
    call PRINT_COIN

    mov coin_x, 114
    mov coin_y, 5
    call PRINT_COIN

    call BEGIN_GAME_03

    call crlf
    call waitmsg

ret
MAIN_GAME_FUN_3 ENDP

; //NOTE - LVL_03


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;----------------------------------------------
;  THREE PORTALS WORKING, ENTER FROM LEFT EXIT FROM RIGHT
;----------------------------------------------

;;;;;;;;;;;;;WORKING
PORTAL_01 PROC

    cmp y_pos, 2
    jne done

    cmp x_pos, 1
    jne done

    cmp MOVE, 'a'
    jne done

    call CHANGE_PLAYER
    mov y_pos, 28
    mov x_pos, 118
    call CHANGE_PLAYER

    done:
        ret
PORTAL_01 ENDP

;;;;;;;;;;;;;;;;;;;;;WORKING
PORTAL_02 PROC

    cmp y_pos,2
    jne done

    cmp x_pos,118
    jne done

    cmp MOVE,'d'
    jne done

    call CHANGE_PLAYER
    mov y_pos,28
    mov x_pos,1
    call CHANGE_PLAYER

    done:
        ret
PORTAL_02 ENDP

;;;;;;;;;;;;;;;;;;;;;WORKING
PORTAL_03 PROC

    cmp y_pos,28
    jne done

    cmp x_pos,118
    jne done

    cmp MOVE,'s'
    jne done

    call CHANGE_PLAYER
    mov y_pos,2
    mov x_pos,1
    call CHANGE_PLAYER

    done:
        ret
PORTAL_03 ENDP

;;;;;;;;;;;;;;;;;;;;;
PORTAL_04 PROC

    cmp y_pos,28
    jne done

    cmp x_pos,1
    jne done

    call CHANGE_PLAYER
    mov y_pos,2
    mov x_pos,118
    call CHANGE_PLAYER

    done:
        ret
PORTAL_04 ENDP


;--------------------------------
;  ALL GHOSTS LEVEL THREE [3]
;--------------------------------

; SORRY WE WILL BE REUSING THE ONE IN LEVEL TWO IN LEVEL THREE WITH STRENGTH INCREASED.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BEGIN_GAME_03 PROC

SEC_LVL_03:

        mov bl,x_pos
        mov bh,y_pos

        call MOV_G1_L2
        call PRINT_G1_L2

        call MOV_G2_L2
        call PRINT_G2_L2

        call MOV_G3_L2
        call PRINT_G3_L2

        call MOV_G4_L2
        call PRINT_G4_L2

        call MOV_G5_L2
        call PRINT_G5_L2

        call MOV_G6_L2
        call PRINT_G6_L2

        call MOV_G7_L2
        call PRINT_G7_L2

        call MOV_G8_L2
        call PRINT_G8_L2

        call MOV_G9_L2
        call PRINT_G9_L2

        call MOV_G10_L2
        call PRINT_G10_L2

        call MOV_G11_L2
        call PRINT_G11_L2

        call MOV_G12_L2
        call PRINT_G12_L2

        call MOV_G13_L2
        call PRINT_G13_L2

        call MOV_G14_L2
        call PRINT_G14_L2
    
        call COLIDE_G1_L2
        call COLIDE_G2_L2
        call COLIDE_G3_L2
        call COLIDE_G4_L2
        call COLIDE_G5_L2
        call COLIDE_G6_L2
        call COLIDE_G7_L2
        call COLIDE_G8_L2
        call COLIDE_G9_L2
        call COLIDE_G10_L2
        call COLIDE_G11_L2
        call COLIDE_G12_L2
        call COLIDE_G13_L2
        call COLIDE_G14_L2

        ;//LINK - 

        mov cx, 1
        mov dx, 75

        check_star1:
            
            mov bl, x_pos
            cmp bl, STAR_X[0]
            jne check_star2
            mov bl, y_pos
            cmp bl, STAR_Y[0]
            jne check_star2
            inc SCORE
            mov STAR_X[0], 0
            mov STAR_Y[0], 0

        check_star2:
            mov bl, x_pos
            cmp bl, STAR_X[1]
            jne check_star3
            mov bl, y_pos
            cmp bl, STAR_Y[1]
            jne check_star3
            inc SCORE
            mov STAR_X[1], 0
            mov STAR_Y[1], 0

        check_star3:
            mov bl, x_pos
            cmp bl, STAR_X[2]
            jne check_star4
            mov bl, y_pos
            cmp bl, STAR_Y[2]
            jne check_star4
            inc SCORE
            mov STAR_X[2], 0
            mov STAR_Y[2], 0

        check_star4:
            mov bl, x_pos
            cmp bl, STAR_X[3]
            jne check_star5
            mov bl, y_pos
            cmp bl, STAR_Y[3]
            jne check_star5
            inc SCORE
            mov STAR_X[3], 0
            mov STAR_Y[3], 0

        check_star5:
            mov bl, x_pos
            cmp bl, STAR_X[4]
            jne check_star6
            mov bl, y_pos
            cmp bl, STAR_Y[4]
            jne check_star6
            inc SCORE
            mov STAR_X[4], 0
            mov STAR_Y[4], 0

        check_star6:
            mov bl, x_pos
            cmp bl, STAR_X[5]
            jne check_star7
            mov bl, y_pos
            cmp bl, STAR_Y[5]
            jne check_star7
            inc SCORE
            mov STAR_X[5], 0
            mov STAR_Y[5], 0

        check_star7:
            mov bl, x_pos
            cmp bl, STAR_X[6]
            jne check_star8
            mov bl, y_pos
            cmp bl, STAR_Y[6]
            jne check_star8
            inc SCORE
            mov STAR_X[6], 0
            mov STAR_Y[6], 0

        check_star8:
            mov bl, x_pos
            cmp bl, STAR_X[7]
            jne check_star9
            mov bl, y_pos
            cmp bl, STAR_Y[7]
            jne check_star9
            inc SCORE
            mov STAR_X[7], 0
            mov STAR_Y[7], 0

        check_star9:
            mov bl, x_pos
            cmp bl, STAR_X[8]
            jne check_star10
            mov bl, y_pos
            cmp bl, STAR_Y[8]
            jne check_star10
            inc SCORE
            mov STAR_X[8], 0
            mov STAR_Y[8], 0

        check_star10:
            mov bl, x_pos
            cmp bl, STAR_X[9]
            jne check_star11
            mov bl, y_pos
            cmp bl, STAR_Y[9]
            jne check_star11
            inc SCORE
            mov STAR_X[9], 0
            mov STAR_Y[9], 0

        check_star11:
            mov bl, x_pos
            cmp bl, STAR_X[10]
            jne check_star12
            mov bl, y_pos
            cmp bl, STAR_Y[10]
            jne check_star12
            inc SCORE
            mov STAR_X[10], 0
            mov STAR_Y[10], 0

        check_star12:
            mov bl, x_pos
            cmp bl, STAR_X[11]
            jne check_star13
            mov bl, y_pos
            cmp bl, STAR_Y[11]
            jne check_star13
            inc SCORE
            mov STAR_X[11], 0
            mov STAR_Y[11], 0

        check_star13:
            mov bl, x_pos
            cmp bl, STAR_X[12]
            jne check_star14
            mov bl, y_pos
            cmp bl, STAR_Y[12]
            jne check_star14
            inc SCORE
            mov STAR_X[12], 0
            mov STAR_Y[12], 0

        check_star14:
            mov bl, x_pos
            cmp bl, STAR_X[13]
            jne check_star15
            mov bl, y_pos
            cmp bl, STAR_Y[13]
            jne check_star15
            inc SCORE
            mov STAR_X[13], 0
            mov STAR_Y[13], 0

        check_star15:
            mov bl, x_pos
            cmp bl, STAR_X[14]
            jne check_star16
            mov bl, y_pos
            cmp bl, STAR_Y[14]
            jne check_star16
            inc SCORE
            mov STAR_X[14], 0
            mov STAR_Y[14], 0

        check_star16:
            mov bl, x_pos
            cmp bl, STAR_X[15]
            jne check_star17
            mov bl, y_pos
            cmp bl, STAR_Y[15]
            jne check_star17
            inc SCORE
            mov STAR_X[15], 0
            mov STAR_Y[15], 0

        check_star17:
            mov bl, x_pos
            cmp bl, STAR_X[16]
            jne check_star18
            mov bl, y_pos
            cmp bl, STAR_Y[16]
            jne check_star18
            inc SCORE
            mov STAR_X[16], 0
            mov STAR_Y[16], 0

        check_star18:
            mov bl, x_pos
            cmp bl, STAR_X[17]
            jne check_star19
            mov bl, y_pos
            cmp bl, STAR_Y[17]
            jne check_star19
            inc SCORE
            mov STAR_X[17], 0
            mov STAR_Y[17], 0

        check_star19:
            mov bl, x_pos
            cmp bl, STAR_X[18]
            jne check_star20
            mov bl, y_pos
            cmp bl, STAR_Y[18]
            jne check_star20
            inc SCORE
            mov STAR_X[18], 0
            mov STAR_Y[18], 0

        check_star20:
            mov bl, x_pos
            cmp bl, STAR_X[19]
            jne check_star21
            mov bl, y_pos
            cmp bl, STAR_Y[19]
            jne check_star21
            inc SCORE
            mov STAR_X[19], 0
            mov STAR_Y[19], 0

        check_star21:
            mov bl, x_pos
            cmp bl, STAR_X[20]
            jne check_star22
            mov bl, y_pos
            cmp bl, STAR_Y[20]
            jne check_star22
            inc SCORE
            mov STAR_X[20], 0
            mov STAR_Y[20], 0

        check_star22:
            mov bl, x_pos
            cmp bl, STAR_X[21]
            jne check_star23
            mov bl, y_pos
            cmp bl, STAR_Y[21]
            jne check_star23
            inc SCORE
            mov STAR_X[21], 0
            mov STAR_Y[21], 0

        check_star23:
            mov bl, x_pos
            cmp bl, STAR_X[22]
            jne check_star24
            mov bl, y_pos
            cmp bl, STAR_Y[22]
            jne check_star24
            inc SCORE
            mov STAR_X[22], 0
            mov STAR_Y[22], 0

        check_star24:
            mov bl, x_pos
            cmp bl, STAR_X[23]
            jne check_star25
            mov bl, y_pos
            cmp bl, STAR_Y[23]
            jne check_star25
            inc SCORE
            mov STAR_X[23], 0
            mov STAR_Y[23], 0

        check_star25:
            mov bl, x_pos
            cmp bl, STAR_X[24]
            jne check_star26
            mov bl, y_pos
            cmp bl, STAR_Y[24]
            jne check_star26
            inc SCORE
            mov STAR_X[24], 0
            mov STAR_Y[24], 0

        check_star26:
            mov bl, x_pos
            cmp bl, STAR_X[25]
            jne check_star27
            mov bl, y_pos
            cmp bl, STAR_Y[25]
            jne check_star27
            inc SCORE
            mov STAR_X[25], 0
            mov STAR_Y[25], 0

        check_star27:
            mov bl, x_pos
            cmp bl, STAR_X[26]
            jne check_star28
            mov bl, y_pos
            cmp bl, STAR_Y[26]
            jne check_star28
            inc SCORE
            mov STAR_X[26], 0
            mov STAR_Y[26], 0

        check_star28:
            mov bl, x_pos
            cmp bl, STAR_X[27]
            jne check_star29
            mov bl, y_pos
            cmp bl, STAR_Y[27]
            jne check_star29
            inc SCORE
            mov STAR_X[27], 0
            mov STAR_Y[27], 0

        check_star29:
            mov bl, x_pos
            cmp bl, STAR_X[28]
            jne check_star30
            mov bl, y_pos
            cmp bl, STAR_Y[28]
            jne check_star30
            inc SCORE
            mov STAR_X[28], 0
            mov STAR_Y[28], 0

        check_star30:
            mov bl, x_pos
            cmp bl, STAR_X[29]
            jne check_star31
            mov bl, y_pos
            cmp bl, STAR_Y[29]
            jne check_star31
            inc SCORE
            mov STAR_X[29], 0
            mov STAR_Y[29], 0

        check_star31:
            mov bl, x_pos
            cmp bl, STAR_X[30]
            jne check_star32
            mov bl, y_pos
            cmp bl, STAR_Y[30]
            jne check_star32
            inc SCORE
            mov STAR_X[30], 0
            mov STAR_Y[30], 0

        check_star32:
            mov bl, x_pos
            cmp bl, STAR_X[31]
            jne check_star33
            mov bl, y_pos
            cmp bl, STAR_Y[31]
            jne check_star33
            inc SCORE
            mov STAR_X[31], 0
            mov STAR_Y[31], 0

        check_star33:
            mov bl, x_pos
            cmp bl, STAR_X[32]
            jne check_star34
            mov bl, y_pos
            cmp bl, STAR_Y[32]
            jne check_star34
            inc SCORE
            mov STAR_X[32], 0
            mov STAR_Y[32], 0

        check_star34:
            mov bl, x_pos
            cmp bl, STAR_X[33]
            jne check_star35
            mov bl, y_pos
            cmp bl, STAR_Y[33]
            jne check_star35
            inc SCORE
            mov STAR_X[33], 0
            mov STAR_Y[33], 0

        check_star35:
            mov bl, x_pos
            cmp bl, STAR_X[34]
            jne check_star36
            mov bl, y_pos
            cmp bl, STAR_Y[34]
            jne check_star36
            inc SCORE
            mov STAR_X[34], 0
            mov STAR_Y[34], 0

        check_star36:
            mov bl, x_pos
            cmp bl, STAR_X[35]
            jne check_star37
            mov bl, y_pos
            cmp bl, STAR_Y[35]
            jne check_star37
            inc SCORE
            mov STAR_X[35], 0
            mov STAR_Y[35], 0

        check_star37:
            mov bl, x_pos
            cmp bl, STAR_X[36]
            jne check_star38
            mov bl, y_pos
            cmp bl, STAR_Y[36]
            jne check_star38
            inc SCORE
            mov STAR_X[36], 0
            mov STAR_Y[36], 0

        check_star38:
            mov bl, x_pos
            cmp bl, STAR_X[37]
            jne check_star39
            mov bl, y_pos
            cmp bl, STAR_Y[37]
            jne check_star39
            inc SCORE
            mov STAR_X[37], 0
            mov STAR_Y[37], 0

        check_star39:
            mov bl, x_pos
            cmp bl, STAR_X[38]
            jne check_star40
            mov bl, y_pos
            cmp bl, STAR_Y[38]
            jne check_star40
            inc SCORE
            mov STAR_X[38], 0
            mov STAR_Y[38], 0

        check_star40:
            mov bl, x_pos
            cmp bl, STAR_X[39]
            jne check_star41
            mov bl, y_pos
            cmp bl, STAR_Y[39]
            jne check_star41
            inc SCORE
            mov STAR_X[39], 0
            mov STAR_Y[39], 0

        check_star41:
            mov bl, x_pos
            cmp bl, STAR_X[40]
            jne check_star42
            mov bl, y_pos
            cmp bl, STAR_Y[40]
            jne check_star42
            inc SCORE
            mov STAR_X[40], 0
            mov STAR_Y[40], 0

        check_star42:
            mov bl, x_pos
            cmp bl, STAR_X[41]
            jne check_star43
            mov bl, y_pos
            cmp bl, STAR_Y[41]
            jne check_star43
            inc SCORE
            mov STAR_X[41], 0
            mov STAR_Y[41], 0

        check_star43:
            mov bl, x_pos
            cmp bl, STAR_X[42]
            jne check_star44
            mov bl, y_pos
            cmp bl, STAR_Y[42]
            jne check_star44
            inc SCORE
            mov STAR_X[42], 0
            mov STAR_Y[42], 0

        check_star44:
            mov bl, x_pos
            cmp bl, STAR_X[43]
            jne check_star45
            mov bl, y_pos
            cmp bl, STAR_Y[43]
            jne check_star45
            inc SCORE
            mov STAR_X[43], 0
            mov STAR_Y[43], 0

        check_star45:
            mov bl, x_pos
            cmp bl, STAR_X[44]
            jne check_star46
            mov bl, y_pos
            cmp bl, STAR_Y[44]
            jne check_star46
            inc SCORE
            mov STAR_X[44], 0
            mov STAR_Y[44], 0

        check_star46:
            mov bl, x_pos
            cmp bl, STAR_X[45]
            jne check_star47
            mov bl, y_pos
            cmp bl, STAR_Y[45]
            jne check_star47
            inc SCORE
            mov STAR_X[45], 0
            mov STAR_Y[45], 0

        check_star47:
            mov bl, x_pos
            cmp bl, STAR_X[46]
            jne check_star48
            mov bl, y_pos
            cmp bl, STAR_Y[46]
            jne check_star48
            inc SCORE
            mov STAR_X[46], 0
            mov STAR_Y[46], 0

        check_star48:
            mov bl, x_pos
            cmp bl, STAR_X[47]
            jne check_star49
            mov bl, y_pos
            cmp bl, STAR_Y[47]
            jne check_star49
            inc SCORE
            mov STAR_X[47], 0
            mov STAR_Y[47], 0

        check_star49:
            mov bl, x_pos
            cmp bl, STAR_X[48]
            jne check_star50
            mov bl, y_pos
            cmp bl, STAR_Y[48]
            jne check_star50
            inc SCORE
            mov STAR_X[48], 0
            mov STAR_Y[48], 0

        check_star50:
            mov bl, x_pos
            cmp bl, STAR_X[49]
            jne check_star51
            mov bl, y_pos
            cmp bl, STAR_Y[49]
            jne check_star51
            inc SCORE
            mov STAR_X[49], 0
            mov STAR_Y[49], 0

        check_star51:
            mov bl, x_pos
            cmp bl, STAR_X[50]
            jne check_star52
            mov bl, y_pos
            cmp bl, STAR_Y[50]
            jne check_star52
            inc SCORE
            mov STAR_X[50], 0
            mov STAR_Y[50], 0

        check_star52:
            mov bl, x_pos
            cmp bl, STAR_X[51]
            jne check_star53
            mov bl, y_pos
            cmp bl, STAR_Y[51]
            jne check_star53
            inc SCORE
            mov STAR_X[51], 0
            mov STAR_Y[51], 0

        check_star53:
            mov bl, x_pos
            cmp bl, STAR_X[52]
            jne check_star54
            mov bl, y_pos
            cmp bl, STAR_Y[52]
            jne check_star54
            inc SCORE
            mov STAR_X[52], 0
            mov STAR_Y[52], 0

        check_star54:
            mov bl, x_pos
            cmp bl, STAR_X[53]
            jne check_star55
            mov bl, y_pos
            cmp bl, STAR_Y[53]
            jne check_star55
            inc SCORE
            mov STAR_X[53], 0
            mov STAR_Y[53], 0

        check_star55:
            mov bl, x_pos
            cmp bl, STAR_X[54]
            jne check_star56
            mov bl, y_pos
            cmp bl, STAR_Y[54]
            jne check_star56
            inc SCORE
            mov STAR_X[54], 0
            mov STAR_Y[54], 0

        check_star56:
            mov bl, x_pos
            cmp bl, STAR_X[55]
            jne check_star57
            mov bl, y_pos
            cmp bl, STAR_Y[55]
            jne check_star57
            inc SCORE
            mov STAR_X[55], 0
            mov STAR_Y[55], 0

        check_star57:
            mov bl, x_pos
            cmp bl, STAR_X[56]
            jne check_star58
            mov bl, y_pos
            cmp bl, STAR_Y[56]
            jne check_star58
            inc SCORE
            mov STAR_X[56], 0
            mov STAR_Y[56], 0

        check_star58:
            mov bl, x_pos
            cmp bl, STAR_X[57]
            jne check_star59
            mov bl, y_pos
            cmp bl, STAR_Y[57]
            jne check_star59
            inc SCORE
            mov STAR_X[57], 0
            mov STAR_Y[57], 0

        check_star59:
            mov bl, x_pos
            cmp bl, STAR_X[58]
            jne check_star60
            mov bl, y_pos
            cmp bl, STAR_Y[58]
            jne check_star60
            inc SCORE
            mov STAR_X[58], 0
            mov STAR_Y[58], 0

        check_star60:
            mov bl, x_pos
            cmp bl, STAR_X[59]
            jne check_star61
            mov bl, y_pos
            cmp bl, STAR_Y[59]
            jne check_star61
            inc SCORE
            mov STAR_X[59], 0
            mov STAR_Y[59], 0

        check_star61:
            mov bl, x_pos
            cmp bl, STAR_X[60]
            jne check_star62
            mov bl, y_pos
            cmp bl, STAR_Y[60]
            jne check_star62
            inc SCORE
            mov STAR_X[60], 0
            mov STAR_Y[60], 0

        check_star62:
            mov bl, x_pos
            cmp bl, STAR_X[61]
            jne check_star63
            mov bl, y_pos
            cmp bl, STAR_Y[61]
            jne check_star63
            inc SCORE
            mov STAR_X[61], 0
            mov STAR_Y[61], 0

        check_star63:
            mov bl, x_pos
            cmp bl, STAR_X[62]
            jne check_star64
            mov bl, y_pos
            cmp bl, STAR_Y[62]
            jne check_star64
            inc SCORE
            mov STAR_X[62], 0
            mov STAR_Y[62], 0

        check_star64:
            mov bl, x_pos
            cmp bl, STAR_X[63]
            jne check_star65
            mov bl, y_pos
            cmp bl, STAR_Y[63]
            jne check_star65
            inc SCORE
            mov STAR_X[63], 0
            mov STAR_Y[63], 0

        check_star65:
            mov bl, x_pos
            cmp bl, STAR_X[64]
            jne check_star66
            mov bl, y_pos
            cmp bl, STAR_Y[64]
            jne check_star66
            inc SCORE
            mov STAR_X[64], 0
            mov STAR_Y[64], 0

        check_star66:
            mov bl, x_pos
            cmp bl, STAR_X[65]
            jne check_star67
            mov bl, y_pos
            cmp bl, STAR_Y[65]
            jne check_star67
            inc SCORE
            mov STAR_X[65], 0
            mov STAR_Y[65], 0

        check_star67:
            mov bl, x_pos
            cmp bl, STAR_X[66]
            jne check_star68
            mov bl, y_pos
            cmp bl, STAR_Y[66]
            jne check_star68
            inc SCORE
            mov STAR_X[66], 0
            mov STAR_Y[66], 0

        check_star68:
            mov bl, x_pos
            cmp bl, STAR_X[67]
            jne check_star69
            mov bl, y_pos
            cmp bl, STAR_Y[67]
            jne check_star69
            inc SCORE
            mov STAR_X[67], 0
            mov STAR_Y[67], 0

        check_star69:
            mov bl, x_pos
            cmp bl, STAR_X[68]
            jne check_star70
            mov bl, y_pos
            cmp bl, STAR_Y[68]
            jne check_star70
            inc SCORE
            mov STAR_X[68], 0
            mov STAR_Y[68], 0

        check_star70:
            mov bl, x_pos
            cmp bl, STAR_X[69]
            jne check_star71
            mov bl, y_pos
            cmp bl, STAR_Y[69]
            jne check_star71
            inc SCORE
            mov STAR_X[69], 0
            mov STAR_Y[69], 0

        check_star71:
            mov bl, x_pos
            cmp bl, STAR_X[70]
            jne check_star72
            mov bl, y_pos
            cmp bl, STAR_Y[70]
            jne check_star72
            inc SCORE
            mov STAR_X[70], 0
            mov STAR_Y[70], 0

        check_star72:
            mov bl, x_pos
            cmp bl, STAR_X[71]
            jne check_star73
            mov bl, y_pos
            cmp bl, STAR_Y[71]
            jne check_star73
            inc SCORE
            mov STAR_X[71], 0
            mov STAR_Y[71], 0

        check_star73:
            mov bl, x_pos
            cmp bl, STAR_X[72]
            jne check_star74
            mov bl, y_pos
            cmp bl, STAR_Y[72]
            jne check_star74
            inc SCORE
            mov STAR_X[72], 0
            mov STAR_Y[72], 0

        check_star74:
            mov bl, x_pos
            cmp bl, STAR_X[73]
            jne check_star75
            mov bl, y_pos
            cmp bl, STAR_Y[73]
            jne check_star75
            inc SCORE
            mov STAR_X[73], 0
            mov STAR_Y[73], 0

        check_star75:
            
            mov bl, x_pos
            cmp bl, STAR_X[74]
            jne check_coin1
            mov bl, y_pos
            cmp bl, STAR_Y[74]
            jne check_coin1
            inc SCORE
            mov STAR_X[74], 0
            mov STAR_Y[74], 0
        
        check_coin1:
            mov bl, x_pos
            cmp bl, 5
            jne check_coin2
            mov bl, y_pos
            cmp bl, 14
            jne check_coin2
            add SCORE, 5
            mov coin_x, 0
            mov coin_y, 0

        check_coin2:
            mov bl, x_pos
            cmp bl, 116
            jne check_coin3
            mov bl, y_pos
            cmp bl, 14
            jne check_coin3
            add SCORE, 5
            mov coin_x, 0
            mov coin_y, 0

        check_coin3:
            mov bl, x_pos
            cmp bl, 114
            jne star_finish_1
            mov bl, y_pos
            cmp bl, 5
            jne star_finish_1
            add SCORE, 5
            mov coin_x, 0
            mov coin_y, 0


        star_finish_1:
        
        mov eax, white
        call SetTextColor

        ; draw SCORE:
        mov dl, 0
        mov dh, 0
        call Gotoxy
        mwrite "SCORE : "
        mov eax, 0
        mov al, SCORE
        cmp SCORE, 7 ;//ANCHOR - 
        jge ENDED_LVL_03
        call Writedec

        mov dl, 57
        mov dh, 0
        call Gotoxy
        mwrite "LIVES : "
        mov eax,0
        mov al, LIVES
        call WRITEDEC
        cmp LIVES,0
        je TERMINATE

        mov dl, 110
        mov dh, 0
        call Gotoxy
        mwrite "LEVEL : "
        mov eax, 0
        mov al, 3
        call WriteDEC

        call PORTAL_01
        call PORTAL_02
        call PORTAL_03
        call PORTAL_04

        ITERATIVE:
            cmp y_pos,0
            jg TAKE_IP_AGAIN

            call CHANGE_PLAYER
            inc y_pos
            call DRAW_PLAYER_LV1
            mov eax,50
            call Delay
        jmp ITERATIVE
        
        TAKE_IP_AGAIN:
        
        call ReadKey
        jz NOT_ENTERED
            mov MOVE, al
        NOT_ENTERED:

        mov eax, 15
        call DELAY

        cmp MOVE, "p"
        je STOP_IT

        cmp MOVE, "e"
        je TERMINATE

        cmp MOVE, "w"
        je UP_IP

        cmp MOVE, "z"
        je DOWN_IP

        cmp MOVE, "a"
        je LEFT_IP

        cmp MOVE, "s"
        je RIGHT_IP

    STOP_IT:
       call PAUSE_GAME

     UP_IP:

        cmp y_pos,2
        je SEC_LVL_03

        mov bl,x_pos
        mov bh,y_pos
        dec bh
        mov CHCEK,0

        call L1_2_1
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_2
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_3
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_4
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_5
        cmp CHCEK,1
        je REPEAT_01

        ;------------

        call L2_3_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_4
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_5
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_4_1
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_5_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_4
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L1_LINE13
        cmp CHCEK,1
        je REPEAT_01

        call CHANGE_PLAYER
        dec y_pos
        call DRAW_PLAYER_LV1
        jmp SEC_LVL_03

    DOWN_IP:

        cmp y_pos,28
        je SEC_LVL_03

        mov bl,x_pos
        mov bh,y_pos
        inc bh
        mov CHCEK,0

        ;------------

        call L1_2_1
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_2
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_3
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_4
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_5
        cmp CHCEK,1
        je REPEAT_01

        ;------------

        call L2_3_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_4
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_5
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_4_1
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_5_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_4
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L1_LINE13
        cmp CHCEK,1
        je REPEAT_01

        call CHANGE_PLAYER
        inc y_pos
        call DRAW_PLAYER_LV1
        jmp SEC_LVL_03

     LEFT_IP:

        cmp x_pos,1
        je SEC_LVL_03

        mov bl,x_pos
        mov bh,y_pos
        dec bl
        mov CHCEK,0

        ;------------

        call L1_2_1
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_2
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_3
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_4
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_5
        cmp CHCEK,1
        je REPEAT_01

        ;------------

        call L2_3_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_4
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_5
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_4_1
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_5_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_4
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L1_LINE13
        cmp CHCEK,1
        je REPEAT_01

        call CHANGE_PLAYER
        dec x_pos
        call DRAW_PLAYER_LV1
        jmp SEC_LVL_03

    RIGHT_IP:

        cmp x_pos,118
        je SEC_LVL_03

        mov bl,x_pos
        mov bh,y_pos
        inc bl
        mov CHCEK,0

        ;-------------

        call L1_2_1
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_2
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_3
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_4
        cmp CHCEK,1
        je REPEAT_01

        call L1_2_5
        cmp CHCEK,1
        je REPEAT_01

        ;------------

        call L2_3_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_4
        cmp CHCEK,1
        je REPEAT_01

        call L2_3_5
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_4_1
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L2_5_1
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_2
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_3
        cmp CHCEK,1
        je REPEAT_01

        call L2_5_4
        cmp CHCEK,1
        je REPEAT_01

        ;-----------

        call L1_LINE13
        cmp CHCEK,1
        je REPEAT_01

        call CHANGE_PLAYER
        inc x_pos
        call DRAW_PLAYER_LV1
        jmp SEC_LVL_03

REPEAT_01:
   jmp SEC_LVL_03

ret
BEGIN_GAME_03 ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPLAY_LVL_01 PROC

    mov eax, magenta (brown*1)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    mwrite "                                .____     _______________   _______________.____                 ____  "
    call crlf
    mwrite "                                |    |    \_   _____/\   \ /   /\_   _____/|    |               /_   | "
    call crlf
    mwrite "                                |    |     |    __)_  \   Y   /  |    __)_ |    |       ______   |   | "
    call crlf
    mwrite "                                |    |___  |        \  \     /   |        \|    |___   /_____/   |   | "
    call crlf
    mwrite "                                |_______ \/_______  /   \___/   /_______  /|_______ \            |___| "
    call crlf
    mwrite "                                        \/        \/                    \/         \/                  "
    call crlf
    call crlf
    call crlf
    call crlf

    call waitmsg

ret
DISPLAY_LVL_01 ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPLAY_LVL_02 PROC

    mov eax, magenta (brown*1)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    mwrite "                                .____     _______________   _______________.____                ________    "
    call crlf
    mwrite "                                |    |    \_   _____/\   \ /   /\_   _____/|    |               \_____  \   "
    call crlf
    mwrite "                                |    |     |    __)_  \   Y   /  |    __)_ |    |       ______   /  ____/   "
    call crlf
    mwrite "                                |    |___  |        \  \     /   |        \|    |___   /_____/  /       \   "
    call crlf
    mwrite "                                |_______ \/_______  /   \___/   /_______  /|_______ \           \_______ \  "
    call crlf
    mwrite "                                        \/        \/                    \/         \/                   \/  "
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf

    call waitmsg

RET
DISPLAY_LVL_02 ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPLAY_LVL_03 PROC

    mov eax, magenta (brown*1)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    mwrite "                                .____      ___________ ____   ____ ___________ .____                  ________     "
    call crlf
    mwrite "                                |    |     \_   _____/ \   \ /   / \_   _____/ |    |                 \_____  \    "
    call crlf
    mwrite "                                |    |      |    __)_   \   Y   /   |    __)_  |    |        ______     _(__  <    "
    call crlf
    mwrite "                                |    |___   |        \   \     /    |        \ |    |___    /_____/    /       \   "
    call crlf
    mwrite "                                |_______ \ /_______  /    \___/    /_______  / |_______ \             /______  /   "
    call crlf
    mwrite "                                        \/         \/                      \/          \/                    \/    "
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf

    call waitmsg

RET
DISPLAY_LVL_03 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;
ENDED_LVL_01 PROC

    mov eax, magenta (brown*1)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    mwrite "                                       /$$$$$$$$ /$$   /$$ /$$$$$$$                        /$$    "
    call crlf
    mwrite "                                      | $$_____/| $$$ | $$| $$__  $$                     /$$$$    "
    call crlf
    mwrite "                                      | $$      | $$$$| $$| $$  \ $$                    |_  $$    "
    call crlf
    mwrite "                                      | $$$$$   | $$ $$ $$| $$  | $$       /$$$$$$        | $$    "
    call crlf
    mwrite "                                      | $$__/   | $$  $$$$| $$  | $$      |______/        | $$    "
    call crlf
    mwrite "                                      | $$      | $$\  $$$| $$  | $$                      | $$    "
    call crlf
    mwrite "                                      | $$$$$$$$| $$ \  $$| $$$$$$$/                     /$$$$$$  "
    call crlf
    mwrite "                                      |________/|__/  \__/|_______/                     |______/  "
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf                                                   
                                                          
    call waitmsg
    call MAIN_GAME_FUN_2
RET
ENDED_LVL_01 ENDP

ENDED_LVL_02 PROC

    mov eax, magenta (brown*1)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    mwrite "                                    /$$$$$$$$ /$$   /$$ /$$$$$$$                       /$$$$$$   "
    call crlf
    mwrite "                                   | $$_____/| $$$ | $$| $$__  $$                     /$$__  $$  "
    call crlf
    mwrite "                                   | $$      | $$$$| $$| $$  \ $$                    |__/  \ $$  "
    call crlf
    mwrite "                                   | $$$$$   | $$ $$ $$| $$  | $$       /$$$$$$        /$$$$$$/  "
    call crlf
    mwrite "                                   | $$__/   | $$  $$$$| $$  | $$      |______/       /$$____/   "
    call crlf
    mwrite "                                   | $$      | $$\  $$$| $$  | $$                    | $$        "
    call crlf
    mwrite "                                   | $$$$$$$$| $$ \  $$| $$$$$$$/                    | $$$$$$$$  "
    call crlf
    mwrite "                                   |________/|__/  \__/|_______/                     |________/  "
    call crlf
    call crlf
    call crlf
    call crlf    

    call waitmsg
    call MAIN_GAME_FUN_3                                  

ret                                                           
ENDED_LVL_02 ENDP                                                            


ENDED_LVL_03 PROC

    mov eax, magenta (brown*1)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    mwrite "                                          /$$$$$$$$ /$$   /$$ /$$$$$$$                       /$$$$$$     "
    call crlf
    mwrite "                                         | $$_____/| $$$ | $$| $$__  $$                     /$$__  $$    "
    call crlf
    mwrite "                                         | $$      | $$$$| $$| $$  \ $$                    |__/  \ $$    "
    call crlf
    mwrite "                                         | $$$$$   | $$ $$ $$| $$  | $$       /$$$$$$         /$$$$$/    "
    call crlf
    mwrite "                                         | $$__/   | $$  $$$$| $$  | $$      |______/        |___  $$    "
    call crlf
    mwrite "                                         | $$      | $$\  $$$| $$  | $$                     /$$  \ $$    "
    call crlf
    mwrite "                                         | $$$$$$$$| $$ \  $$| $$$$$$$/                    |  $$$$$$/    "
    call crlf
    mwrite "                                         |________/|__/  \__/|_______/                      \______/     "
    call crlf
    call crlf
    call crlf
    call crlf
    
    call waitmsg
    call YOU_WON_THANKS

RET
ENDED_LVL_03 ENDP


YOU_WON_THANKS PROC

    mov eax, lightGreen (lightGreen*8)
    call SetTextColor
    call clrscr

    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    call Crlf
    call crlf
    call crlf
    mwrite "                           wWw  wWw   .-.     wWw  wWw                (O))  ((O)    .-.   \\\  ///  "
    call crlf
    mwrite "                           (O)  (O) c(O_O)c   (O)  (O)                 ||    ||   c(O_O)c ((O)(O))  "
    call crlf
    mwrite "                           ( \  / ),'.---.`,  / )  ( \                 || /\ ||  ,'.---.`, | \ ||   "
    call crlf
    mwrite "                            \ \/ // /|_|_|\ \/ /    \ \     _____      ||//\\|| / /|_|_|\ \||\\||   "
    call crlf
    mwrite "                             \o / | \_____/ || \____/ |    [_____]     / /  \ \ | \_____/ ||| \ |   "
    call crlf
    mwrite "                            _/ /  '. `---' .`'. `--' .`               ( /    \ )'. `---' .`||  ||   "
    call crlf
    mwrite "                           (_.'     `-...-'    `-..-'                  )      (   `-...-' (_/  \_)  "
    call crlf
    call crlf
    call crlf

    mwrite "                                        ---------------------------------"
    call crlf
    mwrite "                                        |    NAME   : "
    mov edx, OFFSET save_name
    call writestring
    call crlf
    mwrite "                                        |    SCORE  : "
    mov al, SCORE
    call writedec
    call crlf
    mwrite "                                        ---------------------------------"
    call crlf
    call crlf
    call crlf

    call waitmsg

RET
YOU_WON_THANKS ENDP

END main