/******************************************************************************
* @file mlh2634_p2.s
* @brief Matt Hamrick's CSE 2312-004 Program #2 assignment
* @author Matt Hamrick
******************************************************************************/

.global main
.func main

main:
    BL _seedrand            @ seed random number generator with current time
    MOV R5, #0              @ init counter for _createarray loop
_createarray:
    CMP R5, #10             @ check counter to see if the loop is finished
    BEQ _createarraydone    @ if finished, exit loop
    LDR R1, =a              @ load R1 with pointer to a
    LSL R2, R5, #2          @ multiply counter*4, product = the array offset
    ADD R2, R1, R2          @ R2 = address of a + array offset
    PUSH {R2}               @ backup R2 on the stack for later retrieval
    BL _getrand             @ get a random #
    POP {R2}                @ restore curent array pointer to R2
    STR R0, [R2]            @ store rand# to array location
    ADD R5, R5, #1          @ increment counter
    B _createarray

_createarraydone:
    MOV R5, #0              @ reset counter back to zero
_iteratearray:
    

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

_printf:                    @ needs R0 address, plus any parameters, to be set by the caller
    PUSH {LR} 
    SUB SP, SP, #4
    BL printf                       
    ADD SP, SP, #4
    POP {PC}

_exit:
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
    
    

.data
test_str:       .asciz "%d\n"
a:              .skip 40
output_str:     .asciz      "a[%d] = %d\n"
