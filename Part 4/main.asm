INCLUDE	irvine32.inc

luaL_openlibs		PROTO C :DWORD
luaL_newstate		PROTO C 
lua_pushcclosure	PROTO C :DWORD, :DWORD, :DWORD
lua_setglobal		PROTO C :DWORD, :DWORD
luaL_loadfilex		PROTO C :DWORD, :DWORD, :DWORD
lua_pcallk			PROTO C :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
lua_close			PROTO C :DWORD
lua_tolstring		PROTO C :DWORD, :DWORD, :DWORD

writeMessage		PROTO

.data

	L		DWORD	?
	file	BYTE	30 DUP(?)
	func	BYTE	"writeMessage", 0
	prompt	BYTE	"Enter the name of your lua script: ", 0
	done	BYTE	"Would you like to quit? yes(1), no(0): ", 0

.code

lua_write PROC C

	push	ebp
	mov		ebp, esp
	pushad

	invoke	lua_tolstring, [ebp + 8], 1, 0
	push	eax
	call	writeMessage

	popad
	mov		esp, ebp
	pop		ebp
	ret

lua_write ENDP

main PROC

	invoke	 luaL_newstate
	mov		L, eax

	invoke	luaL_openlibs, L

	invoke	lua_pushcclosure, L, lua_write, 0
	invoke	lua_setglobal, L, OFFSET func

	L1:

	mov		edx, OFFSET prompt
	call	WriteString
	mov		edx, OFFSET file
	mov		ecx, SIZEOF file
	call	ReadString
	invoke	luaL_loadfilex, L, OFFSET file, 0

	invoke	lua_pcallk, L, 0, 0, 0, 0, 0

	call	CrLf
	mov		edx, OFFSET done
	call	WriteString
	call	ReadDec
	call	CrLf
	cmp		eax, 0
	je		L1

	invoke	lua_close, L

	ret
main ENDP

end main