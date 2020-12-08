.586
.model flat, stdcall
option casemap:none

printf PROTO C, pString: PTR BYTE, args:VARARG

.data
text1 BYTE "Hello with call!", 13, 10, 0
text2 BYTE "Helo again with invoke!", 13, 10, 0

.code
main PROC C    

    push    offset text1
    call    printf
    add     esp, 4

    invoke  printf, OFFSET text2

    ret
main ENDP
end