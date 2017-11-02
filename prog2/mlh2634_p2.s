/******************************************************************************
* @file mlh2634_p2.s
* @brief Matt Hamrick's CSE 2312-004 Program #2 assignment
* @author Matt Hamrick
******************************************************************************/

.global main
.func main

main:
    BL _seedrand            @ seed random number generator with current time
    MOV R5, #0              @ init counter for _createarray loop
_createarray:
    CMP R5, #10             @ check counter to see if the loop is finished
    BEQ _createarraydone    @ if finished, exit loop
    LDR R1, =a              @ load R1 with pointer to a
    LSL R2, R5, #2          @ multiply counter*4, product = the array offset
    ADD R2, R1, R2          @ R2 = address of a + array offset
    PUSH {R2}               @ backup R2 on the stack for later retrieval
    BL _getrand             @ get a random #
    POP {R2}                @ restore curent array pointer to R2
    STR R0, [R2]            @ store rand# to array location
    ADD R5, R5, #1          @ increment counter
    B _createarray          @ loop back

_createarraydone:
    MOV R5, #0              @ reset counter back to zero
    MOV R6, #1000           @ init reg for MIN value
    MOV R7, #0              @ init reg for MAX value
_iteratearray:
    CMP R5, #10             @ check counter to see if the loop is finished
    BEQ _iteratearraydone   @ if finished, exit loop
    LDR R1, =a              @ load R1 with pointer to a
    LSL R2, R5, #2          @ multiply counter*4, product = the array offset
    ADD R2, R1, R2          @ R2 = address of a + array offset
    LDR R3, [R2]            @ R3 = the value stored at the memory address in R2  
    MOV R1, R3              @ load the rand # into R1 for call to _checkmaxmin
    BL _checkmaxmin         @ make necessary max/min check
    LDR R0, =output_str     @ R0 = addr of output string to prepare for _printf
    MOV R1, R5              @ load the counter into R1 to prepare for _printf
    MOV R2, R3              @ load the rand # into R2 to prepare for _printf
    BL _printf              @ print the things
    ADD R5, R5, #1          @ increment the counter
    B _iteratearray         @ loop back

_iteratearraydone:
    B _printmaxmin          @ output the max/min strings

_checkmaxmin:
    CMP R1, R6              @ compare the # against the current min #
    MOVLT R6, R1            @ if rand# < current MIN, update the MIN
    CMP R1, R7              @ compare the # against the current max #
    MOVGT R7, R1            @ if rand# > current MAX, update the MAX
    MOV PC, LR
    
_printmaxmin:
    LDR R0, =min_str        @ R0 = addr of min value output string
    MOV R1, R6              @ R1 = the minimum value
    BL _printf              @ print the min string
    LDR R0, =max_str        @ R0 = addr of max value output string
    MOV R1, R7              @ R1 = the max value
    BL _printf              @ print the max string
    B _exit                 @die

_seedrand:
    PUSH {LR}               @ backup return address
    MOV R0, #0              @ pass 0 as argument to time call
    BL time                 @ get system time
    MOV R1, R0              @ pass sytem time as argument to srand
    BL srand                @ seed the random number generator
    POP {PC}                @ return 

_getrand:
    PUSH {LR}               @ backup return address
    BL rand                 @ get a random number
    CMP R0, #1000           @ check if the rand# is within range
    POPLT {PC}              @ return if so, continue if not
    MOV R1, R0
    B _fixrand              @ if the rand# is >= 1000, we need to fix it to be [0-999]

_fixrand:                   @ this is a slightly-modified version of C.McMurrough's _mod_unsigned function
    MOV R2, #1000           @ set limit for the rand# to [0-999]
    MOV R0, #0              @ initialize return value
    B _modloopcheck
    _modloop:
        ADD R0, R0, #1      @ increment R0
        SUB R1, R1, R2      @ subtract R2 from R1
    _modloopcheck:
        CMP R1, R2          @ check for loop termination
        BHS _modloop        @ continue loop if R1 >= R2
    MOV R0, R1              @ move remainder to R0
    POP {PC}                @ return

_printf:                    @ needs R0 address, plus any parameters, to be set by the caller beforehand
    PUSH {LR} 
    SUB SP, SP, #4
    BL printf                       
    ADD SP, SP, #4
    POP {PC}

_exit:                      @die
    MOV R7, #1
    SWI 0
    

.data
test_str:       .asciz      "%d\n"
a:              .skip       40
output_str:     .asciz      "a[%d] = %d\n"
max_str:        .asciz      "MAXIMUM VALUE = %d\n"
min_str:        .asciz      "MINIMUM VALUE = %d\n"
