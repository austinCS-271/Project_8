.586
.model flat, stdcall
option casemap:none

MessageBoxA PROTO hwnd:DWORD, lpText:DWORD, lpCaption:DWORD, uType:DWORD

.data

	hello BYTE "Hello from a box!", 0
	boxTitle BYTE "Message Box", 0

.code

main PROC C

	invoke	MessageBoxA, 0, OFFSET hello, OFFSET boxTitle, 1

	ret
main ENDP

end main