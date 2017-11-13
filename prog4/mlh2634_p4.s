/******************************************************************************
* @file mlh2634_p4.s
* @brief Matt Hamrick's CSE 2312-004 Program #4 assignment
* @author Matt Hamrick
******************************************************************************/

.global main
.func main

main:
    LDR R0, =out_operandN_str
    BL printf                       @ prompt user for operand N (OpN)
    LDR R0, =in_operand_format_str
    BL _getOperand                  @ get OpN
    MOV R4, R0                      @ preserve orig OpN
    VMOV S0, R0                     @ copy OpN into a VFP register
    VCVT.F64.S32 D0, S0             @ convert signed int OpN in S0 into 64-bit value and store in D0
    
    LDR R0, =out_operandD_str     
    BL printf                       @ prompt user for operand D (OpD)
    LDR R0, =in_operand_format_str
    BL _getOperand                  @ get OpD
    MOV R5, R0                      @ preserve orig OpD
    VMOV S2, R0                     @ copy OpD into a single-precision VFP register
    VCVT.F64.S32 D1, S2             @ convert signed int OpD in S2 into 64-bit value and store in D1
    
    BL _divide                      @ do the maths - quotient placed in D2
    
    LDR R0, =out_result_str
    MOV R1, R4                      @ place numerator into R1 for printf call
    MOV R2, R5                      @ place denominator into R1 for printf call
    VPUSH {D2}                      @ can use a single printf in this scenario by pushing quotient onto the stack (R3 gets skipped)
    BL printf                       @ output the required result string
    ADD SP, SP, #8                  @ restore SP to pre-VPUSH location (#8 since VPUSH uses 8 bytes for double precision D2 reg)
    
    B main                          @ do it all over
    
    B _exit                         @ unreachable death


_getOperand:                        @ retrieves single operand from user using clib scanf
    PUSH {LR}                       @ needs addr of input format string in R0 to be set by caller beforehand
    SUB SP, SP, #4
    MOV R1, SP
    BL scanf
    LDR R0, [SP]
    ADD SP, SP, #4
    POP {PC}

    
_divide:                            @ OpN in D0, OpD in D1
    PUSH {LR}
    VDIV.F64 D2, D0, D1             @ D2 = OpN / OpD
    POP {PC}
    

_exit:                              @die
    PUSH {R0}                       @ preserve R0 just in case caller is passing anything in it
    LDR R0, =out_end_str
    BL printf
    POP {R0}
    MOV R7, #1
    SWI 0
    

.data
out_end_str:                .asciz      "terminating prog..\n"
out_operandN_str:           .asciz      "Enter an integer numerator then press ENTER (operand N):\n"
out_operandD_str:           .asciz      "Enter an integer denominator then press ENTER (operand D):\n"
in_operand_format_str:      .asciz      "%d"
out_test_str:               .asciz      "R1: %d, R2: %d\n" @, R3: %d\n"
out_fpTest_str:             .asciz      "FP values: %f, and %f\n"
out_singFpTest_str:         .asciz      "%f\n"
out_result_str:             .asciz      "%d / %d = %f\n\n"
