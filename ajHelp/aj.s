.global main
.func main

main:
BL _promptNum1
BL _scanf
@MOV R1, R0 @ commented out previous code
MOV R9, R0 @ added this line
BL _promptNum2
BL _scanf
MOV R2, R0
BL _printf
B _exit

_exit:
MOV R7, #4
MOV R0, #1
MOV R2, #21
LDR R1,=exit_str
SWI 0
MOV R7, #1
SWI 0

_promptNum1:
MOV R7, #4
MOV R0, #1
MOV R2, #20
LDR R1, =prompt_num1
SWI 0
MOV PC, LR

_promptNum2:
MOV R7, #4
MOV R0, #1
MOV R2, #21
LDR R1, =prompt_num2
SWI 0
MOV PC, LR

_scanf:
PUSH {LR}
SUB SP, SP, #4
LDR R0, =format_str
MOV R1, SP
BL scanf
LDR R0, [SP]
ADD SP, SP, #4
POP {PC}

_scanf2:
PUSH {LR}
SUB SP, SP, #4
LDR R0, =format_str
MOV R1, SP
BL scanf
LDR R0, [SP]
ADD SP, SP, #4
POP {PC}

_printf:
MOV R4, LR
LDR R0,=print_ans
MOV R1, R9
MOV R2, R2
BL printf
MOV PC, R4

.data
format_str: .asciz "%d"
prompt_num1: .asciz "Enter first number: " 
prompt_num2: .asciz "Enter second number: "
prompt_op: .asciz "Enter operation, '+,-,*,M' :"
print_ans: .asciz "Printing 2 numbers: %d %d \n"
exit_str:.ascii "Terminating program.\n"
