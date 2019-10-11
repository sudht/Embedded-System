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
	.file	"test7.c"
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
	stmfd	sp!, {r4, r5, r6, lr}
	sub	sp, sp, #1000
	mov	r4, r1
	mov	r2, #1000
	mov	r6, r0
	mov	r1, #0
	mov	r0, sp
	mov	r5, sp
	bl	memset(PLT)
	cmp	r4, #0
	subne	r2, sp, #1
	movwne	r0, #26215
	movtne	r0, 26214
	beq	.L13
.L14:
	smull	r3, r1, r0, r4
	mov	r3, r4, asr #31
	rsb	r3, r3, r1, asr #2
	add	r1, r3, r3, asl #2
	sub	r1, r4, r1, asl #1
	subs	r4, r3, #0
	add	r3, r1, #48
	strb	r3, [r2, #1]!
	bne	.L14
.L13:
	movw	r1, #22075
	mov	r2, #0
	mov	r0, r6
	bl	ioctl(PLT)
	movw	r1, #22076
	mov	r2, #0
	mov	r0, r6
	bl	ioctl(PLT)
	mov	r0, sp
	bl	count(PLT)
	cmp	r0, #0
	addgt	r4, r5, r0
	ble	.L18
.L15:
	ldrb	r2, [r4, #-1]!	@ zero_extendqisi2
	mov	r0, r6
	movw	r1, #22077
	bl	ioctl(PLT)
	cmp	r4, r5
	bne	.L15
.L18:
	mov	r0, #0
	add	sp, sp, #1000
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, pc}
	.size	DisplayWrite, .-DisplayWrite
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 112
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L26
	mov	r1, #2
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
.LPIC8:
	add	r3, pc, r3
	sub	sp, sp, #116
	ldr	r2, .L26+4
	ldr	r0, [r3]	@ unaligned
	add	r9, sp, #12
	ldr	r3, .L26+8
.LPIC12:
	add	r2, pc, r2
	str	r2, [sp]
	add	r8, sp, #8
	str	r0, [sp, #8]	@ unaligned
.LPIC13:
	add	r3, pc, r3
	ldr	r0, .L26+12
	movw	r4, #10000
	str	r3, [sp, #4]
	mov	r7, #0
.LPIC9:
	add	r0, pc, r0
	ldr	fp, .L26+16
	bl	open(PLT)
	mov	r1, #1
.LPIC11:
	add	fp, pc, fp
	mov	r10, r0
	ldr	r0, .L26+20
.LPIC10:
	add	r0, pc, r0
	bl	open(PLT)
	mov	r6, r0
	b	.L25
.L22:
	mov	r2, #4
	mov	r1, r8
	mov	r0, r6
	strb	r7, [sp, #8]
	bl	write(PLT)
	mov	r0, r4
	bl	usleep(PLT)
	mov	r1, r8
	mov	r2, #4
	mov	r0, r6
	mov	r5, #1
	strb	r7, [sp, #9]
	strb	r5, [sp, #8]
	bl	write(PLT)
	mov	r0, r4
	bl	usleep(PLT)
	mov	r1, r8
	mov	r2, #4
	mov	r0, r6
	strb	r5, [sp, #9]
	strb	r7, [sp, #10]
	bl	write(PLT)
	mov	r0, r4
	bl	usleep(PLT)
	mov	r1, r8
	mov	r2, #4
	mov	r0, r6
	strb	r5, [sp, #10]
	strb	r7, [sp, #11]
	bl	write(PLT)
	mov	r0, r4
	bl	usleep(PLT)
	strb	r5, [sp, #11]
.L25:
	mov	r1, r9
	mov	r2, #100
	mov	r0, r10
	bl	read(PLT)
	mov	r1, fp
	mov	r0, r9
	bl	strcmp(PLT)
	ldr	r1, [sp]
	cmp	r0, #0
	mov	r0, r9
	moveq	r4, r4, asl #1
	beq	.L22
	bl	strcmp(PLT)
	add	r3, r4, r4, lsr #31
	ldr	r1, [sp, #4]
	cmp	r0, #0
	mov	r0, r9
	moveq	r4, r3, asr #1
	beq	.L22
	bl	strcmp(PLT)
	subs	r5, r0, #0
	bne	.L22
	ldr	r0, .L26+24
	mov	r1, #1
.LPIC14:
	add	r0, pc, r0
	bl	open(PLT)
	mov	r1, r4
	mov	r7, r0
	bl	DisplayWrite(PLT)
	mov	r0, r7
	bl	close(PLT)
	mov	r0, r6
	bl	close(PLT)
	mov	r0, r10
	bl	close(PLT)
	mov	r0, r5
	add	sp, sp, #116
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L27:
	.align	2
.L26:
	.word	.LANCHOR0-(.LPIC8+8)
	.word	.LC4-(.LPIC12+8)
	.word	.LC5-(.LPIC13+8)
	.word	.LC1-(.LPIC9+8)
	.word	.LC3-(.LPIC11+8)
	.word	.LC2-(.LPIC10+8)
	.word	.LC6-(.LPIC14+8)
	.size	main, .-main
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
.LC0:
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC1:
	.ascii	"/dev/t_sm9s5422_interrupt\000"
	.space	2
.LC2:
	.ascii	"/dev/t_sm9s5422_step\000"
	.space	3
.LC3:
	.ascii	"Up\000"
	.space	1
.LC4:
	.ascii	"Down\000"
	.space	3
.LC5:
	.ascii	"Center\000"
	.space	1
.LC6:
	.ascii	"/dev/sm9s5422_textlcd\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
