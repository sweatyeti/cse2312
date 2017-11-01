/******************************************************************************
* @file mlh2634_p2.s
* @brief Matt Hamrick's CSE 2312-004 Program #2 assignment
* @author Matt Hamrick
******************************************************************************/

.global main
.func main

main:
    BL _seedrand            @ seed random number generator with current time
    BL _getrand             @ get a random #
    MOV R1, R0
    
    PUSH {LR} 
    SUB SP, SP, #4
    LDR R0, =test_str
    BL printf                       
    ADD SP, SP, #4
    POP {LR}

    B _exit

_seedrand:
    PUSH {LR}               @ backup return address
    MOV R0, #0              @ pass 0 as argument to time call
    BL time                 @ get system time
    MOV R1, R0              @ pass sytem time as argument to srand
    BL srand                @ seed the random number generator
    POP {PC}                @ return 

_getrand:
    PUSH {LR}               @ backup return address
    BL rand                 @ get a random number
    CMP R0, #1000
    POPLT {PC}
    MOV R1, R0
    B _fixrand              @ if the rand# is >= 1000, we need to fix it to be [0-999]

_fixrand:                   @ this is a slightly-modified version of C.McMurrough's _mod_unsigned function
    MOV R2, #1000           @ set limit for the rand# to [0-999]
    MOV R0, #0              @ initialize return value
    B _modloopcheck
    _modloop:
        ADD R0, R0, #1      @ increment R0
        SUB R1, R1, R2      @ subtract R2 from R1
    _modloopcheck:
        CMP R1, R2          @ check for loop termination
        BHS _modloop        @ continue loop if R1 >= R2
    MOV R0, R1              @ move remainder to R0
    POP {PC}                @ return

_exit:
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
    
    

.data
test_str: .asciz "%d\n"
