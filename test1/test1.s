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
	.file	"test1.c"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L13
	mov	r1, #1
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #28
.LPIC8:
	add	r0, pc, r0
	mov	r7, #0
	str	r7, [sp, #8]
	str	r7, [sp, #12]
	str	r7, [sp, #16]
	str	r7, [sp, #20]
	bl	open(PLT)
	cmn	r0, #1
	mov	r4, r0
	beq	.L2
	cmp	r7, #7
	add	r3, sp, #7
	add	r5, sp, #8
	mov	r9, r7
	add	r6, sp, #16
	str	r3, [sp, #4]
	add	r8, sp, #15
	mov	r10, #1
	bgt	.L12
.L6:
	add	r3, sp, #24
	mov	fp, #5
	add	r2, r3, r7
	strb	r10, [r2, #-16]
.L5:
	mov	r1, r5
	mov	r2, #8
	mov	r0, r4
	bl	write(PLT)
	movw	r0, #41248
	movt	r0, 7
	bl	usleep(PLT)
	mov	r1, r6
	mov	r2, #8
	mov	r0, r4
	bl	write(PLT)
	movw	r0, #41248
	movt	r0, 7
	bl	usleep(PLT)
	subs	fp, fp, #1
	bne	.L5
	add	r7, r7, #1
	cmp	r7, #7
	ble	.L6
.L12:
	mov	r0, r4
	mov	r1, r5
	mov	r2, #8
	bl	write(PLT)
	add	r3, sp, #7
.L8:
	strb	r9, [r3, #1]!
	cmp	r3, r8
	bne	.L8
	movw	r0, #38528
	movt	r0, 152
	bl	usleep(PLT)
	mov	r7, #0
	b	.L6
.L2:
	bl	close(PLT)
	add	sp, sp, #28
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L14:
	.align	2
.L13:
	.word	.LC0-(.LPIC8+8)
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"/dev/t_sm9s5422_led\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
