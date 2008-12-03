; PROBLEM 4: Find the largest palindrome made from the product of two 3-digit
; numbers.
;
; A palindromic number reads the same both ways. The largest palindrome made
; from the product of two 2-digit numbers is 9009 = 91 x 99.
; 
; Find the largest palindrome made from the product of two 3-digit numbers.

extern printf

section .data
    fmt     db "%d", 10, 0  ; printf spec
    a       dd 999          ; first number
    b       dd 999          ; second number
    result  dd 0            ; answer
    product dd 0            ; product
    tmp     dd 0            ; temp for calculating

    digits  dd 0            ; number of digits, minus one..
    i       dd 0            ; counter for which pair of digits
    j       dd 0            ; counter for finding the digits in question
    digit1  dd 0            ; first digit
    digit2  dd 0            ; opposing digit

section .text
    global  main

main:
    push    ebp
    mov     ebp, esp

.loop:
    ; Get the product in eax; three-digit times three-digit won't overflow, so
    ; ignore edx
    mov     eax, [a]
    imul    dword [b]
    mov     [product], eax

    ; Check to see if eax contains a palindrome.
    ; Make a copy.  Divide the copy by 10 until it's less than 10.
    mov     [tmp], eax
    mov     dword [digits], 0
  .countdigits:
    cmp     dword [tmp], 10
    jl      .endcountdigits

    mov     eax, [tmp]          ; dividend...
    mov     edx, 0
    mov     ecx, 10             ; divisor...
    div     ecx                 ; divide by 10
    mov     [tmp], eax          ; store on stack

    inc     dword [digits]
    jmp     .countdigits
  .endcountdigits:
    ; [digits] is now one less than the number of digits.


    ; Now compare pairs of digits.  Divide the number by 10 a and b times
    ; each, where a + b == [digits].
    mov     eax, [digits]
    mov     [i], eax
  .digitpairs:
    ; This will run once for each pair of opposite digits

    ; Track the number on the stack
    mov     eax, [product]
    mov     [digit1], eax
    mov     [digit2], eax
    push    dword [product]

    ; Divide by 10 a lot; we are partitioning digits into i and digits - i,
    ; one partition for each digit we want to extract, using j to iterate
    ; through and just swapping out copies of the product when j passes i
    mov     dword [j], 1
  .divide
    mov     eax, [esp]
    mov     edx, 0
    mov     ecx, 10
    div     ecx
    mov     [esp], eax

    inc     dword [j]
    ; Switch to the other value iff j has passed the threshhold i
    mov     eax, [i]
    cmp     [j], eax
    jne     .skippop
    pop     dword [digit1]
    push    dword [product]
  .skippop

    ; Exit the loop if j has passed number of digits
    mov     eax, [digits]
    cmp     [j], eax
    jg      .enddivide
    jmp     .divide
  .enddivide

    ; 
    pop     dword [digit2]

    ; Take both modulus 10
    mov     edx, 0
    mov     eax, [digit1]
    mov     ecx, 10
    div     ecx
    mov     [digit1], edx

    mov     edx, 0
    mov     eax, [digit2]
    mov     ecx, 10
    div     ecx
    mov     [digit2], edx

    ; Next if they're not equal
    mov     eax, [digit1]
    cmp     eax, [digit2]
    jne     .nextloop

    dec     dword [i]
    cmp     dword [i], 0
    jne     .digitpairs

    ; If i hits 0, that means this is a palindrome!  Make it the result if the
    ; product is bigger than what we have now
    mov     eax, [product]
    cmp     eax, [result]
    jl      .nextloop

    mov     [result], eax
    jmp     .nextloop
  .enddigitpairs

.nextloop
    ; If a has dropped to be equal to b, decrement b and start a over at 999
    mov     eax, [b]
    cmp     dword [a], eax
    jle     .decb

    ; Otherwise just decrement a
    dec     dword [a]
    jmp     .dojump

.decb:
    dec     dword [b]
    mov     dword [a], 999

.dojump:
    cmp     dword [a], 0
    je      .endloop
    cmp     dword [b], 0
    je      .endloop
    jmp     NEAR .loop

.endloop


    ; Print final answer
    push    dword [result]
    push    fmt
    call    printf

    ; Exit
    pop     ebp
    mov     ebx, 0
    mov     eax, 1
    int     0x80
