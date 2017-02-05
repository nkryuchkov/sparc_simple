MIN_RANGE = 2				! specify some 
MAX_RANGE = 36				! constant values

! If base is outside the defined range, return -1.  
! If num is 0, return 0. Otherwise, return the number of digits in num.
numOfDigits:
	save %sp, -96, %sp
	add %i0, 0, %l0			! set %l0 to num
	add %i1, 0, %l1			! and %l1 to base
	add %g0, MIN_RANGE, %o0	! pass MIN_RANGE to isInRange in %o0 (minRange)
	add %g0, MAX_RANGE, %o1 ! and MAX_RANGE in %o1 (maxRange)
	add %i1, 0, %o2			! and base in %o2 (value)
	call isInRange 			! same as "jmpl isInRange, %o7", storing
							! its address into %o7 register
	add %g0, 0, %o3			! pass 0 in %o3 (exlusive)
	subcc %o0, 0, %g0		! if return value equals less equals to zero
	be,a numOfDigitsExit	! do branch
	sub %g0, 1, %i0			! and set return value to -1
	add %g0, %g0, %l2		! set %l2 (accumulator) to 0
	sub %g0, 1, %l3			! set %l3 to -1
	smul %l0, %l3, %l0		! multiply num by %l3 with sign to extend the sign
							! in %y register because sdiv performs division of
							! register pair where %y register represents high
							! part of dividend
numOfDigitsLoop:
	subcc %l0, 0, %g0		! if %l0 = 0
	be,a numOfDigitsExit	! then branch
	add %l2, %0, %i0		! setting return value to %l2
	sdiv %l0, %l1, %l0		! divide register pair %y:l0 (num with its sign 
							! extension) by %l1 (base) and set %l0 to quotient
	ba numOfDigitsLoop		! do a loop
	add %l2, 1, %l2			! incrementing %l2 by 1
numOfDigitsExit:
	ret
	restore
	