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
    CMP R0, #999
    BGT _fixrand            @ if the rand# is > 999, we need to fix it to be [0-999]
    POP {PC}                @ return 

_fixrand:
    AND R0, R0, #1023
_fixloop:	
    CMP R0, #999
    POPLE {PC}
    MOV R0, R0, LSR#1
    B _fixloop

_exit:
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
    
    
@.data
