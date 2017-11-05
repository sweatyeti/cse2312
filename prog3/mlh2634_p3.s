/******************************************************************************
* @file mlh2634_p2.s
* @brief Matt Hamrick's CSE 2312-004 Program #2 assignment
* @author Matt Hamrick
******************************************************************************/

.global main
.func main

main:
    LDR R0, =operandN_str
    BL _printf                      @ prompt user for operand N
    LDR R0, =operand_format_str
    BL _getOperand                  @ get operand N
    MOV R4, R0                      @ preserve operand N
    LDR R0, =operandM_str     
    BL _printf                      @ prompt user for operand M
    LDR R0, =operand_format_str
    BL _getOperand                  @ get operand M
    MOV R5, R0                      @ preserve operand M
    MOV R1, R4                      @ R1 = operand N
    MOV R2, R5                      @ R2 = operand M
    BL count_partitions             @ perform partition logic

    B _exit                         @die (unreachable)

count_partitions:
    
    

_getOperand:                        @ needs addr of input format string to be set by caller beforehand
    PUSH {LR}
    SUB SP, SP, #4
    MOV R1, SP
    BL scanf
    LDR R0, [SP]
    ADD SP, SP, #4
    POP {PC}


_printf:                            @ needs addr of output string in R0, plus any parameters, to be set by the caller beforehand
    PUSH {LR} 
    SUB SP, SP, #4
    BL printf                       
    ADD SP, SP, #4
    POP {PC}

_exit:                              @die
    MOV R7, #1
    SWI 0
    

.data
operandN_str:           .asciz      "Enter a positive integer then press ENTER (operand N):\n"
operandM_str:           .asciz      "Enter the largest integer part then press ENTER (operand M):\n"
operand_format_str:     .asciz      "%d"
