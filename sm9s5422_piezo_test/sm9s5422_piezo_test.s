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
	.file	"sm9s5422_piezo_test.c"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L7
	mov	r1, #1
	stmfd	sp!, {r4, r5, r6, r7, lr}
.LPIC0:
	add	r0, pc, r0
	sub	sp, sp, #12
	ldr	r6, .L7+4
	bl	open(PLT)
	ldr	r5, .L7+8
.LPIC1:
	add	r6, pc, r6
	add	r4, sp, #4
.LPIC2:
	add	r5, pc, r5
	mov	r7, r0
.L2:
	mov	r0, r6
	bl	printf(PLT)
	mov	r0, r5
	mov	r1, r4
	bl	scanf(PLT)
	ldr	r3, [sp, #4]
	cmp	r3, #22
	bls	.L6
	cmp	r3, #100
	bne	.L2
	mov	r0, r7
	bl	close(PLT)
	mov	r0, #0
	add	sp, sp, #12
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, pc}
.L6:
	mov	r0, r7
	mov	r1, r4
	mov	r2, #4
	bl	write(PLT)
	b	.L2
.L8:
	.align	2
.L7:
	.word	.LC4-(.LPIC0+8)
	.word	.LC5-(.LPIC1+8)
	.word	.LC6-(.LPIC2+8)
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC4:
	.ascii	"/dev/sm9s5422_piezo\000"
.LC5:
	.ascii	"input number(1~4, exit=100): \000"
	.space	2
.LC6:
	.ascii	"%d\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
