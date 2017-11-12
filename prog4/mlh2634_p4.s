/******************************************************************************
* @file mlh2634_p4.s
* @brief Matt Hamrick's CSE 2312-004 Program #4 assignment
* @author Matt Hamrick
******************************************************************************/

.global main
.func main

main:
    LDR R0, =out_operandN_str
    BL _printf                      @ prompt user for operand N (OpN)
    LDR R0, =in_operand_format_str
    BL _getOperand                  @ get OpN
    MOV R4, R0                      @ preserve OpN
    LDR R0, =out_operandD_str     
    BL _printf                      @ prompt user for operand D (OpD)
    LDR R0, =in_operand_format_str
    BL _getOperand                  @ get OpD
    MOV R5, R0                      @ preserve OpD
    
    LDR R0, =out_test_str
    PUSH {R4-R5}
    POP {R1-R2}
    BL printf
    
    
    
    B _exit

_getOperand:                        @ retrieves single operand from user using clib scanf
    PUSH {LR}                       @ needs addr of input format string in R0 to be set by caller beforehand
    SUB SP, SP, #4
    MOV R1, SP
    BL scanf
    LDR R0, [SP]
    ADD SP, SP, #4
    POP {PC}


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
out_operandN_str:           .asciz      "Enter an integer numerator then press ENTER (operand N):\n"
out_operandD_str:           .asciz      "Enter an integer denominator then press ENTER (operand D):\n"
in_operand_format_str:      .asciz      "%d"
out_test_str:               .asciz      "R1: %d, R2: %d\n" @, R3: %d\n"
