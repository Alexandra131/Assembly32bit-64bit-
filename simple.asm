%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

   xor ebx, ebx
   nume2:
   cmp ebx, ecx
   jl nume3
   cmp ebx, ecx 
   jge nume1
   
   
nume3:
    xor eax, eax
    mov al, [esi + ebx]
    add al, dl
    cmp al,  'Z'
    jle nume4; cat nu e egal cu z mutam doar cu un element
    sub al, 26 ; daca e egal cu z scadem 26 sa ajungem la a
    
nume4:
    mov [edi + ebx], al
    inc ebx
    jmp nume2


nume1:
   
    popa
    leave
    ret
    

