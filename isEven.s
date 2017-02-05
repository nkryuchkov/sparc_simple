! int isEven( long value );
! If value is even, return 1. If value is odd, return 0.
isEven:
	save %sp, -96, %sp	! move register window forward
	and %i0, 1, %i0 	! bitwise AND between %i0 register (passed argument)
						! and 1 storing result in %i0 register which will be
						! passed back to the calling function
						! bitwise AND with a number 1 extracts the rightmost
						! bit of %i0 register which shows whether the number
						! is even (1) or odd (0)
	ret					! return from isEven subroutine
						! translated by an assembler to jmpl %i7+8, %g0
						! in %i7 we have an address of the instruction that has
						! called the current subroutine
						! the target of the branch is the instruction after the
						! call instruction (4 byte long) and its delay slot
						! (4 byte long), that is %i7+4+4
						! the address of the retl instruction is discarded 
						! (saved in %g0)
	restore 			! move the register window backward in the delay slot
						! of the previous instruction
	