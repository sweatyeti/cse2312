/******************************************************************************
* @file mlh2634_p4.s
* @brief Matt Hamrick's CSE 2312-004 Program #4 assignment
* @author Matt Hamrick
******************************************************************************/

.global main
.func main

main:


_printf:                            @ outputs string to the screen using clib printf
    PUSH {LR}                       @ needs addr of output string in R0, plus any parameters, to be set by the caller beforehand
    SUB SP, SP, #4
    BL printf                       
    ADD SP, SP, #4
    POP {PC}

_exit:                              @die
    PUSH {R0}
    LDR R0, =out_end_str
    BL _printf
    POP {R0}
    MOV R7, #1
    SWI 0
    

.data
out_end_str:                .asciz      "terminating prog.."
