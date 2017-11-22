/******************************************************************************
* @file mlh2634_pfinal.s
* @brief Matt Hamrick's CSE 2312-004 Final Program assignment
* @author Matt Hamrick
******************************************************************************/

.global main
.func main

main:
    LDR R0, =out_prompt_str         @ load addr of prompt string for impending printf call
    BL printf
    MOV R5, #0                      @ init counter for _createarray loop
_populateArr:
    CMP R5, #10                     @ check counter to see if the loop is finished
    BEQ _populateArrDone            @ if finished, exit loop
    LDR R1, =arr                    @ load R1 with pointer to arr
    LSL R2, R5, #2                  @ multiply counter*4, product = the array offset
    ADD R2, R1, R2                  @ R2 = address of a + array offset
    PUSH {R2}                       @ backup R2 on the stack for later retrieval
    LDR R0, =in_value_format_str    @ load addr of input operand string for impending scanf call
    BL _getValue                    @ get value from user to populate array
    POP {R2}                        @ restore curent array pointer to R2
    STR R0, [R2]                    @ store input value to array location
    ADD R5, R5, #1                  @ increment counter
    B _populateArr                  @ loop back

    B _exit
    
_getValue:                          @ retrieves single operand from user using clib scanf
    PUSH {LR}                       @ needs addr of input format string in R0 to be set by caller beforehand
    SUB SP, SP, #4
    MOV R1, SP
    BL scanf
    LDR R0, [SP]
    ADD SP, SP, #4
    POP {PC}

_populateArrDone:
    MOV R5, #0                      @ reset counter back to zero for iteration
_iterateArr:
    CMP R5, #10                     @ check counter to see if the loop is finished
    BEQ _exit             @ if finished, exit loop
    LDR R1, =arr                    @ load R1 with pointer to arr
    LSL R2, R5, #2                  @ multiply counter*4, product = the array offset
    ADD R2, R1, R2                  @ R2 = address of a + array offset
    LDR R3, [R2]                    @ R3 = the value stored at the memory address in R2  
    LDR R0, =out_arrVals_str        @ R0 = addr of output string to prepare for printf
    MOV R1, R5                      @ load the counter into R1 to prepare for printf
    MOV R2, R3                      @ load the value into R2 to prepare for printf
    BL printf                       @ print the things
    ADD R5, R5, #1                  @ increment counter
    B _iterateArr                   @ loop back
    
_exit:                              @die
    PUSH {R0}                       @ preserve R0 just in case caller is passing anything in it
    LDR R0, =out_end_str
    BL printf
    POP {R0}
    MOV R7, #1
    SWI 0
    
.data
arr:                        .skip       40
out_prompt_str:             .asciz      "Enter 10 positive integers, each followed by ENTER:\n"
out_arrVals_str:            .asciz      "array_a[%d] = %d\n"
out_search_str:             .asciz      "ENTER A SEARCH VALUE: "
out_noSrchRslt_str:         .asciz      "That value does not exist in the array!\n"
out_end_str:                .asciz      "terminating prog..\n"
in_value_format_str:        .asciz      "%d"
