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
    MOV R4, R0                      @ preserve orig OpN
    VMOV S14, R0                    @ copy OpN into a VFP register
    VCVT.F64.S32 D4, S14            @ convert signed int OpN into 64-bit value and store in D4
    
    LDR R0, =out_operandD_str     
    BL _printf                      @ prompt user for operand D (OpD)
    LDR R0, =in_operand_format_str
    BL _getOperand                  @ get OpD
    MOV R5, R0                      @ preserve orig OpD
    VMOV S15, R0                    @ copy OpD into a VFP register
    VCVT.F64.S32 D5, S15            @ convert signed int OpD into 64-bit value and store in D5
    
    LDR R0, =out_fpTest_str
    VMOV R2, R3, D4
    VPUSH {D5}
    BL printf
    ADD SP, SP, #16
    
    
    
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
    
_divide:
    PUSH {LR}
    
    
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
out_fpTest_str:             .asciz      "FP values: %f, and %f\n"
