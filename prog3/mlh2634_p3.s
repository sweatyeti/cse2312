/******************************************************************************
* @file mlh2634_p3.s
* @brief Matt Hamrick's CSE 2312-004 Program #3 assignment
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
    LDR R0, =out_operandM_str     
    BL _printf                      @ prompt user for operand M (OpM)
    LDR R0, =in_operand_format_str
    BL _getOperand                  @ get OpM
    MOV R5, R0                      @ preserve OpM
    MOV R1, R4                      @ R1 = OpN
    MOV R2, R5                      @ R2 = OpM
    BL count_partitions             @ perform partition logic
    PUSH {R0}
    LDR R0, =out_result_str         @ load output string addr for printf call
    POP {R1}                        @ R1 = end result (# of partitions)
    MOV R2, R4                      @ R2 = OpN
    MOV R3, R5                      @ R3 = OpM
    BL _printf                      @ output the result string
    B main                          @ do it all over

    B _exit                         @die (unreachable)

count_partitions:                   @ implement recursive logic for returning the # of partitions from the provided operands
    PUSH {LR}
    CMP R1, #0
    MOVEQ R0, #1                    @ if (OpN == 0) then return 1
    POPEQ {PC}
    MOVLT R0, #0                    @ if (OpN < 0) then return 0
    POPLT {PC}
    CMP R2, #0
    MOVEQ R0, #0                    @ if (OpM == 0) then return 0
    POPEQ {PC}
    PUSH {R1}                       @ preserve orig R1 for later use
    SUB R1, R1, R2                  @ prepare for 1st recursive call [count_partitions(n-m,m)]
    BL count_partitions             @ 1st recursive call
    POP {R1}                        @ restore orig R1
    PUSH {R0}                       @ preserve first recursive call result
    PUSH {R2}                       @ preserve orig OpM to prepare for 2nd recursive call [count_partitions(n,m-1)]
    SUB R2, R2, #1                  @ prep OpM for 2nd recursive call
    BL count_partitions             @ 2nd recursive call
    POP {R2}                        @ restore orig OpM
    POP {R1}                        @ R1 = restored result of 1st recursive call
    ADD R0, R0, R1                  @ add results of both recursive calls into return reg R0
    POP {PC}
    

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
out_test_str:               .asciz      "R1: %d, R2: %d, R3: %d\n"
out_end_str:                .asciz      "terminating prog.."
out_operandN_str:           .asciz      "Enter a positive integer then press ENTER (operand N):\n"
out_operandM_str:           .asciz      "Enter the largest integer part then press ENTER (operand M):\n"
in_operand_format_str:      .asciz      "%d"
out_result_str:             .asciz      "There are %d partitions of %d using integers up to %d.\n"
