! int isInRange( long minRange, long maxRange, long value, long exclusive );
! If minRange is larger than maxRange, return -1. 
! Otherwise, return 1 to represent true, 0 to represent false.
isInRange:
	save %sp, -96, %sp	! move register window forward
	subcc %i1, %i0, %l0	! subtract minRange from maxRange setting flags
						! to check if minRange is larger than maxRange
						! we save the result in %l0 to check range for the case
						! if minRange=maxRange and exclusive!=0 (i.e. the value
						! isn't in the required range)
	bl,a isInRangeExit	! if minRange-maxRange < 0 (i.e. minRange is larger)
						! than we perform an annulled branch to 
						! the isInRangeExit label
	sub %g0, 1, %i0		! annulled branch means this instuction in the delay 
						! slot will be executed only if the branch is taken
						! we set subroutine's return value to -1 
	subcc %l0, %i3, %g0	! minRange-maxRange-(exclusive flag) < 0?
	bl,a isInRangeExit	! then go to isInRangeExit
	sub %g0, 0, %i0		! and set subroutine's return value to 0 and branch
	subcc %i3, 0, %i3	! if exclusive!=0
	bne,a isInRangeLabel! then
	add %g0, 1, %i3		! we set to exclusive to 1 
isInRangeLabel:			! branch is taken here direct after its delay slot
	add %i0, %i3, %i0	! increment minRange by 1
	sub %i1, %i3, %i1	! and decrement maxRange by 1
	subcc %i2, %i0, %g0	! if value < minRange
	bl,a isInRangeExit	! then 
	add %g0, %g0, %i0	! set subroutine's return value to 0 and branch
	subcc %i1, %i2, %g0	! if value maxRange < value
	bl,a isInRangeExit	! then
	add %g0, %g0, %i0	! set subroutine's return value to 0 and branch
	add %g0, 1, %i0		! else set subroutine's return value to 1
isInRangeExit:
	ret					! return from subroutine
	restore				! moving register window backward
	