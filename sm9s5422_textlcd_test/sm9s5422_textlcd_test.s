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
	.file	"sm9s5422_textlcd_test.c"
	.text
	.align	2
	.global	DisplayControls
	.type	DisplayControls, %function
DisplayControls:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	mov	r4, r0
	ldr	r0, .L11
	sub	sp, sp, #8
.LPIC0:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L11+4
.LPIC1:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L11+8
.LPIC2:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L11+12
.LPIC3:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L11+16
.LPIC4:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L11+20
	add	r1, sp, #4
.LPIC5:
	add	r0, pc, r0
	bl	scanf(PLT)
	ldr	r3, [sp, #4]
	cmp	r3, #1
	beq	.L7
	cmp	r3, #2
	beq	.L8
	cmp	r3, #3
	beq	.L9
	cmp	r3, #4
	beq	.L10
.L3:
	mov	r0, #1
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, pc}
.L10:
	mov	r0, r4
	movw	r1, #22069
	mov	r2, #0
	bl	ioctl(PLT)
	mov	r0, #1
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, pc}
.L7:
	mov	r0, r4
	movw	r1, #22066
	mov	r2, #0
	bl	ioctl(PLT)
	b	.L3
.L8:
	mov	r0, r4
	movw	r1, #22067
	mov	r2, #0
	bl	ioctl(PLT)
	b	.L3
.L9:
	mov	r0, r4
	movw	r1, #22068
	mov	r2, #0
	bl	ioctl(PLT)
	b	.L3
.L12:
	.align	2
.L11:
	.word	.LC0-(.LPIC0+8)
	.word	.LC1-(.LPIC1+8)
	.word	.LC2-(.LPIC2+8)
	.word	.LC3-(.LPIC3+8)
	.word	.LC4-(.LPIC4+8)
	.word	.LC5-(.LPIC5+8)
	.size	DisplayControls, .-DisplayControls
	.align	2
	.global	DisplayClear
	.type	DisplayClear, %function
DisplayClear:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	movw	r1, #22074
	mov	r2, #0
	bl	ioctl(PLT)
	mov	r0, #1
	ldmfd	sp!, {r3, pc}
	.size	DisplayClear, .-DisplayClear
	.align	2
	.global	Cursor_Shift
	.type	Cursor_Shift, %function
Cursor_Shift:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	mov	r4, r0
	ldr	r0, .L21
	sub	sp, sp, #8
.LPIC6:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L21+4
.LPIC7:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L21+8
.LPIC8:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L21+12
.LPIC9:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L21+16
	add	r1, sp, #4
.LPIC10:
	add	r0, pc, r0
	bl	scanf(PLT)
	ldr	r3, [sp, #4]
	cmp	r3, #1
	beq	.L18
	cmp	r3, #2
	beq	.L19
	cmp	r3, #3
	beq	.L20
.L16:
	mov	r0, #1
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, pc}
.L20:
	mov	r0, r4
	movw	r1, #22073
	mov	r2, #0
	bl	ioctl(PLT)
	mov	r0, #1
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, pc}
.L18:
	mov	r0, r4
	movw	r1, #22070
	mov	r2, #0
	bl	ioctl(PLT)
	b	.L16
.L19:
	mov	r0, r4
	movw	r1, #22071
	mov	r2, #0
	bl	ioctl(PLT)
	b	.L16
.L22:
	.align	2
.L21:
	.word	.LC6-(.LPIC6+8)
	.word	.LC7-(.LPIC7+8)
	.word	.LC8-(.LPIC8+8)
	.word	.LC9-(.LPIC9+8)
	.word	.LC5-(.LPIC10+8)
	.size	Cursor_Shift, .-Cursor_Shift
	.align	2
	.global	count
	.type	count, %function
count:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L26
	mov	r3, r0
	mov	r0, #0
.L25:
	ldrb	r2, [r3, #1]!	@ zero_extendqisi2
	add	r0, r0, #1
	cmp	r2, #0
	bne	.L25
	bx	lr
.L26:
	mov	r0, r3
	bx	lr
	.size	count, .-count
	.align	2
	.global	DisplayWrite
	.type	DisplayWrite, %function
DisplayWrite:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	mov	r6, r0
	ldr	r0, .L37
	sub	sp, sp, #40
	mov	r4, #0
.LPIC19:
	add	r0, pc, r0
	str	r4, [sp, #8]
	str	r4, [sp, #12]
	str	r4, [sp, #16]
	str	r4, [sp, #20]
	str	r4, [sp, #24]
	str	r4, [sp, #28]
	str	r4, [sp, #32]
	strh	r4, [sp, #36]	@ movhi
	bl	puts(PLT)
	ldr	r0, .L37+4
.LPIC20:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L37+8
.LPIC21:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L37+12
	add	r1, sp, #4
.LPIC22:
	add	r0, pc, r0
	bl	scanf(PLT)
	ldr	r3, [sp, #4]
	cmp	r3, #1
	beq	.L35
	cmp	r3, #2
	beq	.L36
.L32:
	add	r5, sp, #8
	ldr	r0, .L37+16
	mov	r4, #0
	mov	r1, r5
.LPIC25:
	add	r0, pc, r0
	bl	scanf(PLT)
	b	.L33
.L34:
	ldrb	r2, [r5, r4]	@ zero_extendqisi2
	add	r4, r4, #1
	bl	ioctl(PLT)
.L33:
	mov	r0, r5
	bl	count(PLT)
	movw	r1, #22077
	cmp	r4, r0
	mov	r0, r6
	blt	.L34
	add	sp, sp, #40
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, pc}
.L35:
	mov	r2, r4
	mov	r0, r6
	movw	r1, #22075
	bl	ioctl(PLT)
	ldr	r0, .L37+20
.LPIC23:
	add	r0, pc, r0
	bl	puts(PLT)
	b	.L32
.L36:
	mov	r2, r4
	mov	r0, r6
	movw	r1, #22076
	bl	ioctl(PLT)
	ldr	r0, .L37+24
.LPIC24:
	add	r0, pc, r0
	bl	puts(PLT)
	b	.L32
.L38:
	.align	2
.L37:
	.word	.LC10-(.LPIC19+8)
	.word	.LC11-(.LPIC20+8)
	.word	.LC12-(.LPIC21+8)
	.word	.LC5-(.LPIC22+8)
	.word	.LC15-(.LPIC25+8)
	.word	.LC13-(.LPIC23+8)
	.word	.LC14-(.LPIC24+8)
	.size	DisplayWrite, .-DisplayWrite
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #12
	ldr	r0, .L48
	add	r4, sp, #8
	mov	r1, #1
	mov	r3, #0
.LPIC26:
	add	r0, pc, r0
	str	r3, [r4, #-4]!
	bl	open(PLT)
	ldr	r10, .L48+4
	ldr	r9, .L48+8
	ldr	r8, .L48+12
.LPIC27:
	add	r10, pc, r10
	ldr	r7, .L48+16
.LPIC28:
	add	r9, pc, r9
	ldr	r6, .L48+20
.LPIC29:
	add	r8, pc, r8
	ldr	r5, .L48+24
.LPIC30:
	add	r7, pc, r7
.LPIC31:
	add	r6, pc, r6
.LPIC32:
	add	r5, pc, r5
	mov	fp, r0
.L47:
	mov	r0, r10
	bl	puts(PLT)
	mov	r0, r9
	bl	puts(PLT)
	mov	r0, r8
	bl	puts(PLT)
	mov	r0, r7
	bl	puts(PLT)
	mov	r0, r6
	bl	puts(PLT)
	mov	r0, r5
	bl	puts(PLT)
	ldr	r0, .L48+28
	mov	r1, r4
.LPIC33:
	add	r0, pc, r0
	bl	scanf(PLT)
	ldr	r3, [sp, #4]
	sub	r3, r3, #1
	cmp	r3, #4
	addls	pc, pc, r3, asl #2
	b	.L47
.L42:
	b	.L41
	b	.L43
	b	.L44
	b	.L45
	b	.L46
.L45:
	mov	r0, fp
	bl	DisplayWrite(PLT)
	b	.L47
.L44:
	mov	r0, fp
	bl	Cursor_Shift(PLT)
	b	.L47
.L43:
	mov	r0, fp
	bl	DisplayClear(PLT)
	b	.L47
.L41:
	mov	r0, fp
	bl	DisplayControls(PLT)
	b	.L47
.L46:
	mov	r0, fp
	bl	close(PLT)
	mov	r0, #0
	add	sp, sp, #12
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L49:
	.align	2
.L48:
	.word	.LC16-(.LPIC26+8)
	.word	.LC17-(.LPIC27+8)
	.word	.LC18-(.LPIC28+8)
	.word	.LC19-(.LPIC29+8)
	.word	.LC20-(.LPIC30+8)
	.word	.LC21-(.LPIC31+8)
	.word	.LC22-(.LPIC32+8)
	.word	.LC5-(.LPIC33+8)
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"*** Display Controls ***\000"
	.space	3
.LC1:
	.ascii	"1. Display On\000"
	.space	2
.LC2:
	.ascii	"2. Display Off\000"
	.space	1
.LC3:
	.ascii	"3. Cursor On\000"
	.space	3
.LC4:
	.ascii	"4. Curosr Off\000"
	.space	2
.LC5:
	.ascii	"%d\000"
	.space	1
.LC6:
	.ascii	"*** Cursor Shift ***\000"
	.space	3
.LC7:
	.ascii	"1. Cursor Right\000"
.LC8:
	.ascii	"2. Cursor Left\000"
	.space	1
.LC9:
	.ascii	"3. Return Home\000"
	.space	1
.LC10:
	.ascii	"*** Display Write ***\000"
	.space	2
.LC11:
	.ascii	"1. 1 Line\000"
	.space	2
.LC12:
	.ascii	"2. 2 Line\000"
	.space	2
.LC13:
	.ascii	"1 Line Input : \000"
.LC14:
	.ascii	"2 Line Input : \000"
.LC15:
	.ascii	"%s\000"
	.space	1
.LC16:
	.ascii	"/dev/sm9s5422_textlcd\000"
	.space	2
.LC17:
	.ascii	"*** Text LCD ***\000"
	.space	3
.LC18:
	.ascii	"1. Display Controls\000"
.LC19:
	.ascii	"2. Display Clear\000"
	.space	3
.LC20:
	.ascii	"3. Cursor Shift\000"
.LC21:
	.ascii	"4. Display Write\000"
	.space	3
.LC22:
	.ascii	"5. Exit\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
