	.arch armv7-a
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"kdriver_test.c"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	mov	r1, #1
	ldr	r4, .L7
.LPIC0:
	add	r4, pc, r4
	mov	r0, r4
	bl	open(PLT)
	subs	r5, r0, #0
	bge	.L6
	ldr	r0, .L7+4
	mov	r1, r4
.LPIC1:
	add	r0, pc, r0
	bl	printf(PLT)
	mvn	r0, #0
	ldmfd	sp!, {r3, r4, r5, pc}
.L6:
	mov	r1, #0
	mov	r2, r1
	bl	write(PLT)
	mov	r1, #0
	mov	r2, r1
	mov	r0, r5
	bl	ioctl(PLT)
	mov	r0, r5
	bl	close(PLT)
	mov	r0, #0
	bl	exit(PLT)
.L8:
	.align	2
.L7:
	.word	.LC0-(.LPIC0+8)
	.word	.LC1-(.LPIC1+8)
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"/dev/kdriver\000"
	.space	3
.LC1:
	.ascii	"%s open error...\012\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
