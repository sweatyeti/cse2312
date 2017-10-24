/******************************************************************************
* @file mlh2634_p1.s
* @brief Matt Hamrick's CSE 2312-004 Program #1 assignment
* @author Matt Hamrick
******************************************************************************/

.global main
.func main

main:

    /* prompt for and get the 1st operand from user */
    LDR R0, =operand1_prompt_str
    BL printf
    BL getOperand
    MOV R4, R0
    
    /* prompt for and get the operation type from user, w/ checks included */
    BL getOperation
    MOV R5, R0
    
    /* prompt for and get the 2nd operand from user */
    LDR R0, =operand2_prompt_str
    BL printf
    BL getOperand
    MOV R6, R0
	
    /* Store operands and opType in appropriate registers */
    MOV R1, R4
    MOV R2, R6
    MOV R3, R5
    
    /* Determine which operation user entered, and execute it, then output the result and start over */
    CMP R3, #'+'
    BLEQ SUM
    BEQ outputResultAndStartOver
    
    CMP R3, #'-'
    BLEQ DIFFERENCE
    BEQ outputResultAndStartOver
    
    CMP R3, #'*'
    BLEQ PRODUCT
    BEQ outputResultAndStartOver
    
    CMP R3, #'M'
    BLEQ MAX
    BEQ outputResultAndStartOver


/******
name: getOperand
parameters: none
returns: operand in R0
description: retrieves one operand from the user
******/
getOperand:
    PUSH {LR}
    SUB SP, SP, #4
    LDR R0, =operand_format_str
    MOV R1, SP
    BL scanf
    LDR R0, [SP]
    ADD SP, SP, #4
    POP {PC}


/******
name: getOperation
parameters: none
returns: operation type in R0
description: retrieves the desired operation type from the user and performs a rudimentary validity check.
    If the provided opType input doesn't match one of the 4 we're looking for, then re-prompt the user for a new one.
******/
getOperation:
    PUSH {LR}
    SUB SP, SP, #4
    LDR R0,=opType_prompt_str
    BL printf                       @ prompt user for the desired operation type

    LDR R0, =opType_format_str
    MOV R1, SP                      @ move SP to R1 to store user input on stack
    BL scanf                        @ get the user input for operation type
    LDR R0, [SP]                    @ load user's input into R0, and adjust SP
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
	
    PUSH {LR} 
    SUB SP, SP, #4
    LDR R0, =incorrect_opType_str
    BL printf                       @ inform user the operation type they entered is no good
    ADD SP, SP, #4
    POP {LR}
	
    B getOperation                  @ start this function over again to re-collect the opType


/******
name: SUM
parameters: operands in R1 and R2
returns: result in R0
description: calculates the sum of the operands
******/
SUM:
    ADD R0, R1, R2
    MOV PC, LR    


/****** 
name: DIFFERENCE
returns: result in R0
parameters: operands in R1 and R2
returns: result in R0
description: calculates the difference of the operands
******/
DIFFERENCE:
    SUB R0, R1, R2
    MOV PC, LR


/****** 
name: PRODUCT
parameters: operands in R1 and R2
returns: result in R0
description: calculates the product of the operands
******/
PRODUCT:
    MUL R0, R1, R2
    MOV PC, LR


/****** 
name: MAX
parameters: operands in R1 and R2
returns: result in R0
description: calculates the max value of the operands
******/
MAX:
    CMP R1, R2
    MOVGE R0, R1
    MOVLT R0, R2


/****** 
name: outputResultAndStartOver
parameters: 
 1. left operand in R1
 2. right operand in R2
 3. operation type in R3
 4. calculation result in R0
returns: n/a
description: take the inputs and result of the calculation and output it, then start the program over by branching back to main
******/
outputResultAndStartOver:
    PUSH {R4}               @ preserve R4 on the stack since this function modifies it
    SUB SP, SP, #4
    MOV R4, R2              @ save right operand (R2) into R4 to preserve it while we shift register values around
    MOV R2, R3              @ move opType (R3) into R2 to prepare for printf call
    MOV R3, R4              @ move operand2 (R2) into R3 to prepare for printf call (left operand is already in R1, so it's good)
    PUSH {R0}               @ Push the operation's result onto the stack for printf to consume
    LDR R0, =output_str
    BL printf
    ADD SP, SP, #4          @ move stack pointer back to proper place
    POP {R4}                @ return original R4 value back to R4
    ADD SP, SP, #4
    B main                  @ start the whole process over again


/****** 
name: _exit
parameters: none
returns: n/a
description: currently-unused exit function
******/
_exit:
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall



.data
operand1_prompt_str: 	.asciz "Please enter operand #1 + ENTER:\n"
operand2_prompt_str:    .asciz "Please enter operand #2 + ENTER:\n"
opType_prompt_str:      .asciz "Please enter an operation type of +,-,*, or M followed by ENTER:\n"
operand_format_str: 	.asciz "%d"
incorrect_opType_str:	.asciz "Operation type not accepted.\n"
opType_format_str:		.asciz "%s"
output_str:             .asciz "You entered %d %c %d.\nThe result is %d.\n\n"
test_str:               .asciz "test_str"
