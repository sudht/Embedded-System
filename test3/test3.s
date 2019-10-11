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
	.file	"test3.c"
	.text
	.align	2
	.global	count
	.type	count, %function
count:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L4
	mov	r3, r0
	mov	r0, #0
.L3:
	ldrb	r2, [r3, #1]!	@ zero_extendqisi2
	add	r0, r0, #1
	cmp	r2, #0
	bne	.L3
	bx	lr
.L4:
	mov	r0, r3
	bx	lr
	.size	count, .-count
	.align	2
	.global	DisplayWrite
	.type	DisplayWrite, %function
DisplayWrite:
	@ args = 0, pretend = 0, frame = 1000
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	sub	sp, sp, #1000
	ldr	r1, .L15
	mov	r5, r0
	mov	r7, #0
	mov	r2, #172
.LPIC8:
	add	r1, pc, r1
	mov	r0, sp
	bl	memcpy(PLT)
	mov	r1, r7
	mov	r2, #828
	add	r0, sp, #172
	bl	memset(PLT)
	movw	r1, #22075
	mov	r2, r7
	mov	r0, r5
	bl	ioctl(PLT)
	mov	r0, r5
	movw	r1, #22076
	mov	r2, r7
	mov	r8, sp
	bl	ioctl(PLT)
.L10:
	mov	r0, sp
	bl	count(PLT)
	sub	r0, r0, #15
	cmp	r7, r0
	bge	.L14
	mov	r0, r5
	movw	r1, #22075
	mov	r2, #0
	add	r6, r8, r7
	bl	ioctl(PLT)
	mov	r4, #0
.L12:
	ldrb	r2, [r6, r4]	@ zero_extendqisi2
	mov	r0, r5
	movw	r1, #22077
	add	r4, r4, #1
	bl	ioctl(PLT)
	cmp	r4, #16
	bne	.L12
	mov	r0, #1
	add	r7, r7, r0
	bl	sleep(PLT)
	b	.L10
.L14:
	add	sp, sp, #1000
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, pc}
.L16:
	.align	2
.L15:
	.word	.LANCHOR0-(.LPIC8+8)
	.size	DisplayWrite, .-DisplayWrite
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L18
	mov	r1, #1
	stmfd	sp!, {r4, lr}
.LPIC9:
	add	r0, pc, r0
	bl	open(PLT)
	mov	r4, r0
	bl	DisplayWrite(PLT)
	mov	r0, r4
	bl	close(PLT)
	mov	r0, #0
	ldmfd	sp!, {r4, pc}
.L19:
	.align	2
.L18:
	.word	.LC1-(.LPIC9+8)
	.size	main, .-main
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
.LC0:
	.ascii	"Dashing throught the snow In a one-horse open sleig"
	.ascii	"h 0'er the fields we go Laughing all the way Bells "
	.ascii	"on bobtail ring Making spirits bright What the it i"
	.ascii	"s to ride and sing\000"
	.space	828
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC1:
	.ascii	"/dev/sm9s5422_textlcd\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
