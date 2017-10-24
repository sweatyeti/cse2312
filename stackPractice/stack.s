.global _start

/* EXAMPLE NOT READY */

_start:
    @BL _printsp
    @SUB SP, SP, #4
    BL _printsp
    MOV R4, #6
    PUSH {R4}
    BL _printspvalue
    BL _exit

_exit:
    MOV R7, #1
    SWI 0
    
_printsp:
    MOV R7, #4  @ setting up screen output
    MOV R0, #1
    MOV R2, #4
    MOV R1, SP  @ output the stack pointer
    SWI 0
    MOV PC, LR

_printspvalue:
    MOV R7, #4  @ setting up screen output
    MOV R0, #1
    MOV R2, #3
    LDR R1, [SP]  @ dereference the SP location, since loading from memory it MUST be LDR
    SWI 0
    MOV PC, LR
