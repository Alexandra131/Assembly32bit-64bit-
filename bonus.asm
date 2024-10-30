%include "../include/io.mac"
section .data
  
section .text
    global bonus
    extern printf
bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

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
   push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, 9
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx+4], edi
    jmp end
   
pune1:
   ;adaugare pentru coltul dreapta jos
    push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, 14
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx+4], edi
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
     push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, 49
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx], edi
    
    jmp end
pune3:
   ;punem 1 pt coltul de sus dreapta
    push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, 54
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx], edi
   jmp end

partejos:
   ;punere 1 in matrice pentru partea de jos
    push ecx
   xor ecx, ecx
   xor edi, edi
   xor esi, esi
   add esi, ebx
   add esi, 7
   mov ecx, esi
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx+4], edi
    push ecx
   xor ecx, ecx
   xor edi, edi
   xor esi, esi
   add esi, ebx
   add esi, 9
   mov ecx, esi
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx+4], edi
   jmp end

partesus:
   ;adaugarea 1 pentru partea de sus mai putin colturilor in functie de formula
 push ecx
   xor ecx, ecx
   xor edi, edi
    xor esi, esi
  add esi, 6*8
  sub esi, 1 
  add esi, ebx
  add esi, 2
   mov ecx, esi; pun in ecx, valoarea pe care am calculat-o pt esi
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx], edi
    push ecx
   xor ecx, ecx
   xor edi, edi
    xor esi, esi
  add esi, 6*8
  sub esi, 1 
  add esi, ebx
   mov ecx, esi ; pun in ecx, valoarea pe care am calculat-o pt esi
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx], edi

   jmp end


laterala:
  cmp ebx, 0
  jle partestanga ;ne afla pe laterala stanga
  cmp ebx, 6
  jle mijloc
  cmp ebx, 7
  jle partedreapta ;ne afla pe laterala dreapta
  
  
 partestanga: 
   ;punem 1 in partea din stanga, laterala
   xor esi, esi
   add esi, eax
   sub esi, 1
   imul esi, 8
   add esi, 1
    push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, esi
   mov edi, 1
   shl edi, cl
   pop ecx
  cmp eax, 1
    jle punere_lateral_stanga_bord_0
    jmp punere_lateral_stanga_bord_1

  
  
  punere_lateral_stanga_bord_0:
  ;cazul in care ne afla pe bordul 0
  or [ecx+4], edi
   xor esi, esi
   add esi, eax
   sub esi, 1
   imul esi, 8
   add esi, 17
   push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, esi
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx+4], edi
   jmp end
  
  punere_lateral_stanga_bord_1:
  ;cazul in care ne afla pe bordul 1
  or [ecx], edi
   xor esi, esi
   add esi, eax
   sub esi, 1
   imul esi, 8
   add esi, 17
   push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, esi
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx], edi
   jmp end


partedreapta:
  ;punem 1 pe laterala dreapta
  xor esi, esi
  add esi, eax
  sub esi, 1
  imul esi, 8
  add esi, 6
  PRINTF32 `%d %d \n\x0`, ebx, eax
    push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, esi
   mov edi, 1
   shl edi, cl
   pop ecx
  cmp eax, 1
    jle punere_lateral_dreapta_bord_0
    jmp punere_lateral_dreapta_bord_1
 

punere_lateral_dreapta_bord_0:
   ;cazul in care ne alfam pe bordul 0
   or [ecx+4], edi
   xor esi, esi
  add esi, eax
  sub esi, 1
  imul esi, 8
  add esi, 22
   push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, esi
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx+4], edi
   jmp end

punere_lateral_dreapta_bord_1:
   ;cazul in care ne aflam pe bordul 1
   or [ecx], edi
   xor esi, esi
  add esi, eax
  sub esi, 1
  imul esi, 8
  add esi, 22
   push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, esi
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx], edi
   jmp end


 mijloc:
 ;punem 1 in casutele pentru bordul corespunzator
 ; exista posibilitatea sa adaugam in ambele borduri
  xor esi, esi
  add esi, eax
  imul esi, 8
  add esi, ebx
  add esi, 7
  push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, esi
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx], edi ; adagam in bordul 0
    xor esi, esi
  add esi, eax
  imul esi, 8
  add esi, ebx
  add esi, 9
  push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, esi
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx], edi ; adaugam in bordul 0
    xor esi, esi
  add esi, eax
  imul esi, 8
  add esi, ebx
  sub esi, 7
  push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, esi
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx+4], edi ; audaugam in bordul 1
    xor esi, esi
  add esi, eax
  imul esi, 8
  add esi, ebx
  sub esi, 9
  push ecx
   xor ecx, ecx
   xor edi, edi
   mov ecx, esi
   mov edi, 1
   shl edi, cl
   pop ecx
   or [ecx+4], edi; adaugam in bordul 1
 
end:
    popa
    leave
    ret
    ;; DO NOT MODIFY