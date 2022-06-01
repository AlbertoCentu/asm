.section .data
n1: 
    .long 100
n2: 
    .long 33
n3: 
    .long 68
tot: 
    .ascii "000\n"

.section .text
.global _start

_start: 
    movl n1, %eax
    movl n2, %ebx
    movl n3, %ecx

    addl %ebx, %eax
    addl %ecx, %eax  # ris in %eax

    leal tot, %esi # ass a esi l'indirizzo di tot

    # div per 10 il ris, converto in char il resto e metto in esi
    movl $10, %ebx
    divb %bl # quoz in AL, resto in AH
    addb $48, %ah  # aggiungo 48 per ascii
    movb %ah, 2(%esi)  # sposto ah nel terzo byte di somma
    xorb %ah, %ah  # azzero ah

    divb %bl # quoz in AL, resto in AH
    addb $48, %ah  # aggiungo 48 per ascii
    movb %ah, 1(%esi)  # sposto ah nel terzo byte di somma
    xorb %ah, %ah  # azzero ah 

    divb %bl # quoz in AL, resto in AH
    addb $48, %ah  # aggiungo 48 per ascii
    movb %ah, (%esi)  # sposto ah nel terzo byte di somma
    xorb %ah, %ah  # azzero ah 

    # system call WRITE
    movl $4, %eax
    movl $1, %ebx
    leal tot, %ecx 
    movl $4, %edx
    int $0x80

    # system call EXIT
    movl $1, %eax
    movl $0, %ebx
    int $0x80
    