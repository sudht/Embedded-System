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
	.file	"test2.c"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 176
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	sub	sp, sp, #176
	ldr	r1, .L5
	mov	r2, #176
	mov	r0, sp
	add	r6, sp, r2
.LPIC0:
	add	r1, pc, r1
	mov	r4, sp
	bl	memcpy(PLT)
	ldr	r0, .L5+4
	mov	r1, #1
.LPIC1:
	add	r0, pc, r0
	bl	open(PLT)
	mov	r5, r0
.L3:
	mov	r1, r4
	mov	r2, #4
	mov	r0, r5
	add	r4, r4, r2
	bl	write(PLT)
	cmp	r4, r6
	bne	.L3
	mov	r0, r5
	bl	close(PLT)
	add	sp, sp, #176
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, pc}
.L6:
	.align	2
.L5:
	.word	.LANCHOR0-(.LPIC0+8)
	.word	.LC1-(.LPIC1+8)
	.size	main, .-main
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
.LC0:
	.word	0
	.word	9
	.word	7
	.word	5
	.word	0
	.word	0
	.word	9
	.word	7
	.word	5
	.word	2
	.word	2
	.word	10
	.word	9
	.word	7
	.word	4
	.word	12
	.word	12
	.word	10
	.word	7
	.word	9
	.word	5
	.word	0
	.word	9
	.word	7
	.word	5
	.word	0
	.word	0
	.word	9
	.word	7
	.word	5
	.word	2
	.word	2
	.word	10
	.word	9
	.word	7
	.word	12
	.word	12
	.word	12
	.word	12
	.word	14
	.word	12
	.word	10
	.word	7
	.word	5
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC1:
	.ascii	"/dev/sm9s5422_piezo\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
