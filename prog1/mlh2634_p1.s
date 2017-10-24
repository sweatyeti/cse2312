/******************************************************************************
* @file mlh2634_p1.s
* @brief Matt Hamrick's CSE 2312-004 Program #1 assignment
* @author Matt Hamrick
******************************************************************************/

.global main
.func main

main:

    /* prompt for and get the 1st operand from user */

    LDR R0,=operand1_prompt_str
    BL printf
    BL getOperand
    MOV R4, R0
    
    /* prompt for and get the operation type from user, w/ checks included */
    
    BL getOperation
    MOV R5, R0
    
    /* prompt for and get the 2nd operand from user */
    
    LDR R0,=operand2_prompt_str
    BL printf
    BL getOperand
    MOV R6, R0
	
    /* Store operands in appropriate registers */
    MOV R1, R4
    MOV R2, R6
    
    /* Determine which operation user entered, and execute it */
    CMP R5, #'+'
    BLEQ SUM
    BEQ outputResultAndStartOver
    
    CMP R5, #'-'
    BLEQ DIFFERENCE
    BEQ outputResultAndStartOver
    
    CMP R5, #'*'
    BLEQ PRODUCT
    BEQ outputResultAndStartOver
    
    CMP R5, #'M'
    BLEQ MAX
    BEQ outputResultAndStartOver

getOperand:
    PUSH {LR}
    SUB SP, SP, #4
    LDR R0, =operand_format_str
    MOV R1, SP
    BL scanf
    LDR R0, [SP]
    ADD SP, SP, #4
    POP {PC}

getOperation:
    PUSH {LR}                       @ preserve the initial LR on the stack, and adjust SP
    SUB SP, SP, #4                  
	LDR R0,=opType_prompt_str
	BL printf                       @ display the operation type prompt

    LDR R0, =opType_format_str
    MOV R1, SP              		@ move SP to R1 to store user input on stack
    BL scanf                        @ get the user input for operation type
    LDR R0, [SP]            		@ load user's input into R0, and adjust SP
    ADD SP, SP, #4
    POP {LR}                        @ restore the original return addr back its spot
    
    /* check user input for one of the supported types
    ** if a match is found then return to caller */
    
    CMP R0, #'+'
    MOVEQ PC, LR
	
    CMP R0, #'-'
    MOVEQ PC, LR
	
    CMP R0, #'*'
    MOVEQ PC, LR
	
    CMP R0, #'M'
    MOVEQ PC, LR
	
    /* we only get to this point if user input doesn't match supported ops
    ** alert the user, then re-start routine to allow the user to try again */
	
    PUSH {LR}                       @ preserve initial LR on the stack and adjust SP
    SUB SP, SP, #4
    LDR R0, =incorrect_opType_str
    BL printf                       @ display the message informing user of incorrect opType
    ADD SP, SP, #4
    POP {LR}                        @ store initial LR back into R14
	
    B getOperation

SUM:
    ADD R0, R1, R2
    MOV PC, LR    

DIFFERENCE:
    SUB R0, R1, R2
    MOV PC, LR

PRODUCT:
    MUL R0, R1, R2
    MOV PC, LR

MAX:
    CMP R4, R6
    MOVGE R0, R4
    MOVLT R0, R6

outputResultAndStartOver:
    MOV R3, R2              @ move operand2 into R3 to prepare for printf call (operand1 is already in R1, so it's good)
    MOV R2, R5              @ move opType into R2 to prepare for printf call
    PUSH {R0}              @ Push the operation's result onto the stack for printf to consume
    LDR R0,=output_str
    BL printf
    ADD SP, SP, #4          @ move stack pointer back to proper place
	
    B main				@ start the whole process over again

_exit:
    MOV R7, #1          @ terminate syscall, 1
    SWI 0               @ execute syscall



.data
operand1_prompt_str: 	.asciz "Please enter operand #1 + ENTER:\n"
operand2_prompt_str:    .asciz "Please enter operand #2 + ENTER:\n"
opType_prompt_str:      .asciz "Please enter an operation type of +,-,*, or M followed by ENTER:\n"
operand_format_str: 	.asciz "%d"
incorrect_opType_str:	.asciz "Operation type not accepted.\n"
opType_format_str:		.asciz "%s"
output_str:             .asciz "You entered %d %c %d.\nThe result is %d.\n\n"
test_str:               .asciz "test_str"
