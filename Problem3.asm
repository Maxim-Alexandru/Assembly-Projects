bits 32 

global start        

extern exit, fprintf, fread, fopen, fclose, scanf, printf               
import exit msvcrt.dll   
import fprintf msvcrt.dll   
import fread msvcrt.dll   
import fopen msvcrt.dll   
import fclose msvcrt.dll   
import scanf msvcrt.dll   
import printf msvcrt.dll   
                          
segment data use32 class=data
   
   format times 9 db "%s", 0
   access_mode_input db "r", 0
   access_mode_output db "w", 0
   file_input_descriptor dd -1
   file_output_descriptor dd -1
   formatPrintare db "%d ", 0
   outputFileText db "output.txt"
   outputText times 4 db 0
   inputFileText times 10 db 0
   len equ 40
   text times len db 0
   
segment code use32 class=code
    start:
        
        push dword inputFileText
        push dword format 
        call [scanf]
        add esp, 4*2
        
        push dword access_mode_input     
        push dword inputFileText
        call [fopen]
        add esp, 4*2
        
        mov [file_input_descriptor], eax
        cmp eax, 0 
		je final
        
        push dword access_mode_output    
        push dword outputFileText
        call [fopen]
        add esp, 4*2  
        
        mov [file_output_descriptor], eax
        cmp eax, 0 
		je final
        
        push dword [file_input_descriptor]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4
        
        mov edx, eax
        
        mov esi, 0
        mov ebx, 0; the number of occurences of the number
        mov ecx, 0; the minimal value
        repeta:
            mov al,  byte [text+esi]
            cmp al, '0'
            ja verificare
            jmp omite
            verificare:
                cmp al, '9'
                jb adauga
                jmp omite
            adauga:
                cmp cl, 0
                je initializareCL
                cmp cl, al
                je crestereBL
                cmp cl, al
                ja modificareCL
            jmp omite
            initializareCL:
                mov cl, al
                inc bl
            jmp omite
            crestereBL:
                inc bl
            jmp omite
            modificareCL:
                mov cl, al
                mov bl, 0
                inc bl
            omite:
                inc esi
                cmp esi, edx
                jne repeta
            
        mov edi, 0
        mov [outputText+edi], bl
        mov al, ' '
        mov [outputText+edi+1], al
        mov [outputText+edi+2], cl
        
        printare:
            mov eax, 0
            mov al, bl
            push dword eax
            push dword formatPrintare
            call [printf]
            add esp, 4*2
            
		push dword [file_input_descriptor]
        call [fclose]
        add esp, 4
        
        push dword outputText
        push dword [file_output_descriptor]
        call [fprintf]
        add esp, 4*2 
        jmp final
    
        final:
        push    dword 0      
        call    [exit]       
