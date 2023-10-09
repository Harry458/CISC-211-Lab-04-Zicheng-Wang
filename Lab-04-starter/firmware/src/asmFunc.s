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
    LDR r1,=balance /* Load the address of 'balance' variable into r1 */
    LDR r4,=transaction	/* Load the address of 'transaction' variable into r4 */
    LDR r5,=eat_out /* Load the address of 'eat_out' variable into r5 */
    LDR r6,=stay_in /* Load the address of 'stay_in' variable into r6 */
    LDR r7,=eat_ice_cream /* Load the address of 'eat_ice_cream' variable into r7 */
    LDR r8,=we_have_a_problem /* Load the address of 'we_have_a_problem' variable into r8 */
    LDR r9,=0 /*Load 0 into r9*/
    MOV r10, #1 /*Load 1 into r10*/
    /*SET OUTPUT VALUABLE TO r9(0)*/
    STR r9,[r5]
    STR r9,[r6]
    STR r9,[r7]
    STR r9,[r8]
    
    STR r0,[r4]/*Store the r4(transaction) amount from r0 to memory*/
    LDR r2,[r1]/*Load r1(balance) value into r2*/
    /*Check if r0(transaction) amount is within the range (-1000, 1000)*/
    CMP r0,#1000
    BGT outOfRange
    CMP r0,#-1000
    BLT outOfRange
    
    ADDS r3,r2,r0/*Add r0(transaction) amount to r2(balance) into r3(tempBalance) */
    BVS outOfRange/*check for overflow*/ 
    
    STR r3,[r1]/*Store tempBalance value into r1(balance)*/
    
    /*Check (r3)tempBalance value is bigger,smaller or equal to 0*/
    CMP r3, #0
    BGT set_eat_out
    BLT set_stay_in
    
    /*if r3 equal to zero*/
    STR r10, [r7] /*set r7(eat_ice_cream)to be r10(1)*/
    B finish

    /*if r3 bigger than zero*/
set_eat_out:
    STR r10, [r5] /*set r5(eat_out)to be r10(1)*/            
    B finish
    
    /*if r3 smaller than zero*/
set_stay_in:
    STR r10, [r6] /*set r6(stay_in)to be r10(1)*/        
    B finish
   
    /*if r0 is out of range or overflow*/
outOfRange:
    MOV r3, r2 /*Restore r2(r1(balance)value) value into r3(tempBalance)*/
    STR r9,[r4] /*set r4(transaction)to be r9(0)*/
    STR r10,[r8] /*set r8(we_have_a_problem)to be r10(1)*/
    B finish
    
finish:
    MOV r0, r3 /*Return the tempBalance in r0*/    
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




