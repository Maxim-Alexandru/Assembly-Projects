bits 32 ; assembling for the 32 bits architecture

global start        

extern exit, printf          
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data

    sir1 db 7, 33, 55, 19, 46
    sir1_length equ ($-sir1)
    sir2 db 33, 21, 7, 13, 27, 19, 55, 1, 46
    sir2_length equ ($-sir2)
    nou_sir times sir2_length db 0
    format db "%u, ", 0

segment code use32 class=code
   start:
       
        mov esi, 0
        mov edi, 0
        repeta:
            mov eax, 0
            mov ebx, 0
            mov ecx, 0
            mov al, [sir2+esi]
            repetaCautare:
                mov bl, [sir1+edi]
                cmp al, bl
                je modificareCL
                jmp omite1
                modificareCL:
                mov cl, 1
                omite1:
                cmp al, bl
                je adaugarePozitie
                inc edi
                cmp edi, sir1_length
                jne repetaCautare
            cmp cl, 0
            je adaugareZero
            jmp omite
            adaugarePozitie:
                mov eax, 0
                push edi
                pop eax
                inc eax
                mov [nou_sir+esi], al
            jmp omite
            adaugareZero:
                mov eax, 0
                mov [nou_sir+esi], al
            omite:
                inc esi
                mov edi, 0
                cmp esi, sir2_length
                jne repeta
        
        mov esi, 0
        printare:
            mov eax, 0
            mov al, byte [nou_sir+esi]
            push dword eax
            push dword format
            call [printf]
            add esp, 4*2
            inc esi
            cmp esi, sir2_length
            jne printare
        
        push    dword 0      
        call    [exit]       
