bits 32

global start        

extern exit, printf               
import exit msvcrt.dll  
import printf msvcrt.dll             

segment data use32 class=data

    s db "ana are merem in cojoc ", 0
    length_sir equ ($-s)
    sir_final times length_sir db 0
    format db "%c"
   
segment code use32 class=code
    start:
       
        mov esi, 0
        mov edi, 0
        repetaParcurgereSir:
            mov eax, 0
            mov ebx, 0
            mov edx, 0
            push esi
            pop edx 
            mov bl, 0
            repetaParcurgereCuvant:
                mov al, [s+edi]
                inc bl
                inc edi
                cmp al, ' '
                jne repetaParcurgereCuvant
            dec edi
            dec edi
            push edx
            pop esi
            verificarePalindrom:
                mov al, [s+esi]
                mov ah, [s+edi]
                inc esi
                dec edi
                cmp al, ah
                je continuare
                jmp omiteDacaNuEPalindrom
                continuare:
                    cmp esi, edi
                    je adaugare
                    jmp verificarePalindrom
            adaugare:
                push edx
                pop esi
                mov ecx, 0
                repetaAdaugare:
                    mov al, [s+esi]
                    mov [sir_final+esi], al
                    inc esi
                    inc cl
                    cmp bl, cl
                    jne repetaAdaugare
                    jmp omite
                    
            omiteDacaNuEPalindrom:
                mov al, 0
                repeta:
                inc esi
                inc al
                cmp al, bl
                jne repeta
            omite:
            dec esi
            mov edi, esi
            cmp esi, length_sir
            jbe repetaParcurgereSir

       
        mov esi, 0
        printare:
            mov eax, 0
            mov al, byte [sir_final+esi]
            push dword eax
            push dword format
            call [printf]
            add esp, 4*2
            inc esi
            cmp esi, length_sir
            jne printare
        
        push    dword 0      
        call    [exit]      