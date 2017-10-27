/******************************************************************************
* @file mlh2634_p2.s
* @brief Matt Hamrick's CSE 2312-004 Program #2 assignment
* @author Matt Hamrick
******************************************************************************/

.global main
.func main

main:
    BL _seedrand            @ seed random number generator with current time
    MOV R0, #0              @ initialize index variable


_seedrand:
    PUSH {LR}               @ backup return address
    MOV R0, #0              @ pass 0 as argument to time call
    BL time                 @ get system time
    MOV R1, R0              @ pass sytem time as argument to srand
    BL srand                @ seed the random number generator
    POP {PC}                @ return 


_exit:
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
    
    
@.data
