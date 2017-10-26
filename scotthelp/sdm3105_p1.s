@Scott McCorkle sdm3105

.global main
.func main

main:
   	BL loop
loop:
    BL  _prompt1             	@ branch to prompt procedure with return
    BL  _scanf              	@ branch to scan procedure with return
    MOV R1, R0              @ store n in R1
    BL  _prompt2             	@ branch to prompt procedure with return
    BL _getchar
    MOV R3, R0             @ pass n to printf procedure
    BL  _prompt1             	@ branch to prompt procedure with return
    BL _scanf
    MOV R2, R0              @ pass result to printf procedure
   BL _compare
    BLE loop
  
 
 
_prompt1:
    PUSH {R1}               		@ backup register value
    PUSH {R2}               		@ backup register value
    PUSH {R7}               		@ backup register value
    MOV R7, #4              	@ write syscall, 4
    MOV R0, #1              	@ output stream to monitor, 1
    MOV R2, #26            	 @ print string length
    LDR R1, =prompt_str1    	 @ string at label prompt_str:
    SWI 0                   		@ execute syscall
    POP {R7}              		  @ restore register value
    POP {R2}                		@ restore register value
    POP {R1}                		@ restore register value
    MOV PC, LR              	@ return

_prompt2:
    PUSH {R1}               		@ backup register value
    PUSH {R2}               		@ backup register value
    PUSH {R7}               		@ backup register value
    MOV R7, #4              	@ write syscall, 4
    MOV R0, #1              	@ output stream to monitor, 1
    MOV R2, #26            	 @ print string length
    LDR R1, =prompt_str2    	 @ string at label prompt_str:
    SWI 0                   		@ execute syscall
    POP {R7}              		  @ restore register value
    POP {R2}                		@ restore register value
    POP {R1}                		@ restore register value
    MOV PC, LR              	@ return

_getchar:
    MOV R9, R1 @ Matt
	MOV R7, #3
	MOV R0, #0
	MOV R2, #1
	LDR R1, =read_char
	SWI 0
	LDR R0, [R1]
	AND R0, #0xFF
    MOV R1, R9
	MOV PC, LR

   
_scanf:
    PUSH {LR}               		@ store the return address
    PUSH {R1}               		@ backup regsiter value
    LDR R0, =format_str     	@ R0 contains address of format string
    SUB SP, SP, #4          	@ make room on stack
    MOV R1, SP              	@ move SP to R1 to store entry on stack
    BL scanf                		@ call scanf
    LDR R0, [SP]            		@ load value at SP into R0
    ADD SP, SP, #4          	@remove value from stack
    POP {R1}                		@ restore register value
    POP {PC}                		@ restore the stack pointer and return
 
_compare:
		CMP R3, #'+'
		BEQ _sum
		CMP R3, #'-'
		BEQ _dif
		CMP R3, #'*'
		BEQ _pro
		CMP R3, #'M'
		BEQ _max
		

_sum:
		MOV R5, LR
 		ADD R4, R1, R2
		LDR R0, =print_str
		MOV R4, R4
		BL printf
		MOV PC, R5

_dif:
		MOV R5, LR
 		SUB R4, R1, R2
		LDR R0, =print_str
		MOV R4, R4
		BL printf
		MOV PC, R5
_pro:
		MOV R5, LR
 		MUL R4, R1, R2
		LDR R0, =print_str
		MOV R4, R4
		BL printf
		MOV PC, R5
_max:
		MOV R5, LR
 		ADD R4, R1, R2
		LDR R0, =print_str
		MOV R4, R4
		BL printf
		MOV PC, R5
.data
number:         .word       0
read_char:       .ascii     " "
print_str:      .asciz      "%d \n"
format_str:     .asciz      "%d"
prompt_str1:     .asciz      "Enter a positive number: "
prompt_str2:     .asciz      "Enter a +,-,*, or M :  "
test_str: .asciz "test\n"
