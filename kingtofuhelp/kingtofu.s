/* hello */


.global main
.func main

main:
    BL  _prompt         @ branch to prompt procedure with return
    BL  _getnum1          @ branch to scanf procedure with return
    MOV R8, R0
    BL  _getreg
    MOV R9, R0
    BL  _getnum2
    MOV R10, R0        @ move return value R0 to argument register R1
    BL  _printa         @ branch to print procedure with return

    B   _exit           @ branch to exit procedure with no return

_exit:
    MOV R7, #4          @ write syscall, 4
    MOV R0, #1          @ output stream to monitor, 1
    MOV R2, #21         @ print string length
    LDR R1,=exit_str    @ string at label exit_str:
    SWI 0               @ execute syscall
    MOV R7, #1          @ terminate syscall, 1
    SWI 0               @ execute syscall

_prompt:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #31             @ print string length
    LDR R1, =prompt_str     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return

_getnum1:
    MOV R7, #3              @ write syscall, 3
    MOV R0, #0              @ input stream from monitor, 0
    MOV R2, #1              @ read a single character
    LDR R1, =read_num1      @ store the character in data memory
    SWI 0                   @ execute the system call
    LDR R0, [R1]            @ move the character to the return register
    AND R0, #0xFF           @ mask out all but the lowest 8 bits
    MOV PC, LR              @ return

_getreg:
    MOV R7, #3              @ write syscall, 3
    MOV R0, #0              @ input stream from monitor, 0
    MOV R2, #1              @ read a single character
    LDR R1, =read_reg      @ store the character in data memory
    SWI 0                   @ execute the system call
    LDR R0, [R1]            @ move the character to the return register
    AND R0, #0xFF           @ mask out all but the lowest 8 bits
    MOV PC, LR              @ return

_getnum2:
    MOV R7, #3              @ write syscall, 3
    MOV R0, #0              @ input stream from monitor, 0
    MOV R2, #1              @ read a single character
    LDR R1, =read_num2      @ store the character in data memory
    SWI 0                   @ execute the system call
    LDR R0, [R1]            @ move the character to the return register
    AND R0, #0xFF           @ mask out all but the lowest 8 bits
    MOV PC, LR              @ return


_printa:
    MOV R4, LR          @ store LR since printf call overwrites
    LDR R0,=print_str   @ R0 contains formatted string address
    MOV R8, R1          @ printf argument 1
    MOV R9, R2         @ printf argument 2
    ADD R10, R8, R9      @ printf argument 3
    BL printf           @ call printf
    MOV PC, R4          @ return


.data
read_num1:     .asciz      "%d"
read_reg:     .asciz      "%d"
read_num2:     .asciz      "%d"
prompt_str:     .asciz "Type a number and press enter: "
print_str:      .asciz "Printing 3 numbers: %d %d %d \n"
exit_str:       .ascii "Terminating program.\n"
