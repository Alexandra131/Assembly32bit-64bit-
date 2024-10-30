%include "../include/io.mac"
section .data

section .text
	global checkers
    extern printf
checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x col
    mov ebx, [ebp + 12]	; y linie
    mov ecx, [ebp + 16] ; table
   xor edx, edx
   add edx, eax
   sub edx, 1
  
   cmp edx, 0
   jl coltjos; toata partea de jso a matricei
   cmp edx, 5
   jle laterala; cazul in care ne aflam pe laterale
   add edx, 2
   cmp edx, 7
   jg sus ; in cazul in care avem doar partea de sus
   cmp ebx, 6
   jle mijloc; ne afla in cazurile in care nu atingem lateralele


 
 coltjos:
    xor esi, esi
    add esi, ebx
    sub esi, 1
    cmp esi, 0; cazul in care ne aflam stanga jos
    jl pune
    add esi, 1
    cmp esi, 6
    jle partejos ; toata partea de jso mai putin colturi
    add esi, 2
    cmp esi, 7; cazul in care ne aflam dreapta jos
    jg pune1 

 pune:
   ;adaugare pentru coltul stanga jos
    mov byte [ecx+9], 1
    jmp end
   
pune1:
   ;adaugare pentru coltul dreapta jos
    mov byte [ecx+14], 1 
    jmp end

sus:
   xor esi, esi
   add esi, ebx 
   cmp esi, 1
   jl pune2 ; colt stanga sus
   cmp esi, 6
   jle partesus ; partea de sus mai putin colturile
   cmp esi, 7
   jle pune3 ; colt dreapta sus

pune2: 
    ;punem 1 pt coltul de sus stanga
    mov byte [ecx + 49], 1   
    jmp end
pune3:
   ;punem 1 pt coltul de sus dreapta
   mov byte [ecx+54], 1
   jmp end

partejos:
   ;punere 1 in matrice pentru partea de jos
   mov byte [ecx+ebx+7], 1
   mov byte [ecx+ebx+9], 1
   jmp end

partesus:
  xor esi, esi
  add esi, 6*8
  sub esi, 1 
  add esi, ebx
  ;adaugarea 1 pentru partea de sus mai putin colturilor in functie de formula
   mov byte [ecx+esi+2], 1
   mov byte [ecx+esi], 1
   jmp end


laterala:
  cmp ebx, 0
  jle partestanga ;ne afla pe laterala stanga
  cmp ebx, 6
  jle mijloc
  cmp ebx, 7
  jle partedreapta ;ne afla pe laterala dreapta
  
  
 partestanga: 
   xor esi, esi
   add esi, eax
   sub esi, 1
   ;punem 1 pe pozitile pe care le.am calculat, vin doar 2 numere de 1
   mov byte [ecx+esi*8+1], 1
   mov byte [ecx+esi*8+17], 1
   jmp end

partedreapta:
  xor esi, esi
  add esi, eax
  sub esi, 1
  ;punem 1 pe pozitile pe care le.am calculat, vin doar 2 numere de 1
  mov byte [ecx+esi*8+6], 1
  mov byte [ecx+esi*8+22], 1
  jmp end

 mijloc:
  xor esi, esi
  add esi, eax
  imul esi, 8
  add esi, ebx
  ;adaugare 1 pentru elementele din mijloc
  mov byte [ecx +esi +7], 1
  mov byte [ecx +esi +9], 1
  mov byte [ecx +esi -7], 1
  mov byte [ecx +esi -9], 1
end:
    popa
    leave
    ret
    ;; DO NOT MODIFY