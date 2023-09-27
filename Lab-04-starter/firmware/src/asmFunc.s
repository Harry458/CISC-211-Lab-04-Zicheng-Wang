/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global balance,transaction,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type balance,%gnu_unique_object
.type transaction,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
balance:           .word     0  /* input/output value */
transaction:       .word     0  /* output value */
eat_out:           .word     0  /* output value */
stay_in:           .word     0  /* output value */
eat_ice_cream:     .word     0  /* output value */
we_have_a_problem: .word     0  /* output value */

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: the integer value returned to the C function
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    LDR r1,=balance
    LDR r2,[r1]
    ADD r0,r0,r2
.endif
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
LDR r1,=0                ; /*Load 0 into register r1*/
    LDR r3,=1                ; /*Load 1 into register r3*/
    LDR r4,=balance          ; /*Load the address of the 'balance' variable into r4*/
    LDR r5,=transaction      ; /*Load the address of the 'transaction' variable into r5*/
    LDR r6,=eat_out          ; /*Load the address of 'eat_out' variable into r6*/
    LDR r7,=stay_in          ; /*Load the address of 'stay_in' variable into r7*/
    LDR r8,=eat_ice_cream    ; /*Load the address of 'eat_ice_cream' variable into r8*/
    LDR r9,=we_have_a_problem ; /*Load the address of 'we_have_a_problem' into r9*/
    tmpBalance: .word 0      ; /*Define a label 'tmpBalance' and allocate 4 bytes of memory*/
    LDR r10,=tmpBalance      ; /*Load the address of 'tmpBalance' into r10*/

    STR r1,[r6]              ; /*Store the value in r1 (0) in the memory location pointed to by eat_out*/
    STR r1,[r7]              ; /*Store the value in r1 (0) in the memory location pointed to by stay_in*/
    STR r1,[r8]              ; /*Store the value in r1 (0) in the memory location pointed to by eat_ice_cream*/
    STR r1,[r9]              ; /*Store the value in r1 (0) in the memory location pointed to by we_have_a_problem*/
    STR r0,[r5]              ; /*Store the value in r0 in the memory location pointed to by transaction*/

    CMP r5,1000              ; /*Compare the value in transaction with 1000*/
    BGT correct_way          ; /*Branch to 'correct_way' if 'transaction' is greater than 1000*/
    CMP r5,-1000             ; /*Compare the value in transaction with -1000*/
    BLT correct_way          ; /*Branch to 'correct_way' if 'transaction' is less than -1000*/

    ADDS r10,r4,r5           ; /*Add the values in balance and transaction and store in tmpBalance*/
    Bvs correct_way          ; /*Branch to 'correct_way' if there was overflow in the addition*/

correct_way:
    STR r1,[r5]              ; /*Store 0 in the memory location pointed to by transaction*/
    STR r3,[r9]              ; /*Store 1 in the memory location pointed to by we_have_a_problem*/
    STR r4,[r0]              ; /*Store the value in balance in the memory location pointed to by r0*/
    B done                   ; /*Branch to 'done'*/

way_one:
    STR r3,[r6]              ; /*Store 1 in the memory location pointed to by eat_out*/
    STR r4,[r0]              ; /*Store the value in balance in the memory location pointed to by r0
    B done                   ; /*Branch to 'done'*/

way_two:
    STR r3,[r7]              ; /*Store 1 in the memory location pointed to by stay_in*/
    STR r4,[r0]              ; /*Store the value in balance in the memory location pointed to by r0*/
    B done                   ; /*Branch to 'done'*/
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




