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
	.file	"t_sm9s5422_interrupt_test.c"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 112
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L18
	mov	r1, #2
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
.LPIC0:
	add	r0, pc, r0
	sub	sp, sp, #116
	bl	open(PLT)
	subs	r6, r0, #0
	blt	.L12
	ldr	r8, .L18+4
	add	r4, sp, #12
	ldr	r7, .L18+8
	mov	r5, #5
	ldr	r9, .L18+12
.LPIC2:
	add	r8, pc, r8
	ldr	r10, .L18+16
.LPIC3:
	add	r7, pc, r7
	ldr	fp, .L18+20
.LPIC5:
	add	r9, pc, r9
	ldr	r3, .L18+24
.LPIC7:
	add	r10, pc, r10
.LPIC10:
	add	fp, pc, fp
.LPIC12:
	add	r3, pc, r3
	str	r3, [sp, #4]
.L10:
	mov	r0, r8
	bl	puts(PLT)
	mov	r1, r4
	mov	r2, #100
	mov	r0, r6
	bl	read(PLT)
	mov	r0, r4
	mov	r1, r7
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L13
	mov	r0, r4
	mov	r1, r9
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L14
	mov	r0, r4
	mov	r1, r10
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L15
	ldr	r1, .L18+28
	mov	r0, r4
.LPIC9:
	add	r1, pc, r1
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L16
	ldr	r1, .L18+32
	mov	r0, r4
.LPIC11:
	add	r1, pc, r1
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L17
.L5:
	subs	r5, r5, #1
	bne	.L10
	mov	r0, r6
	bl	close(PLT)
	mov	r0, r5
.L3:
	add	sp, sp, #116
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L13:
	ldr	r0, .L18+36
	mov	r1, r4
.LPIC4:
	add	r0, pc, r0
	bl	printf(PLT)
	b	.L5
.L14:
	ldr	r0, .L18+40
	mov	r1, r4
.LPIC6:
	add	r0, pc, r0
	bl	printf(PLT)
	b	.L5
.L15:
	ldr	r0, .L18+44
	mov	r1, r4
.LPIC8:
	add	r0, pc, r0
	bl	printf(PLT)
	b	.L5
.L16:
	mov	r0, fp
	mov	r1, r4
	bl	printf(PLT)
	b	.L5
.L17:
	ldr	r0, [sp, #4]
	mov	r1, r4
	bl	printf(PLT)
	b	.L5
.L12:
	ldr	r0, .L18+48
.LPIC1:
	add	r0, pc, r0
	bl	puts(PLT)
	mvn	r0, #0
	b	.L3
.L19:
	.align	2
.L18:
	.word	.LC0-(.LPIC0+8)
	.word	.LC2-(.LPIC2+8)
	.word	.LC3-(.LPIC3+8)
	.word	.LC5-(.LPIC5+8)
	.word	.LC7-(.LPIC7+8)
	.word	.LC10-(.LPIC10+8)
	.word	.LC12-(.LPIC12+8)
	.word	.LC9-(.LPIC9+8)
	.word	.LC11-(.LPIC11+8)
	.word	.LC4-(.LPIC4+8)
	.word	.LC6-(.LPIC6+8)
	.word	.LC8-(.LPIC8+8)
	.word	.LC1-(.LPIC1+8)
	.size	main, .-main
	.text
	.align	2
	.global	kbhit
	.type	kbhit, %function
kbhit:
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, lr}
	sub	sp, sp, #76
	movw	r1, #21505
	mov	r0, #0
	mov	r2, sp
	ldr	r4, .L25
	bl	ioctl(PLT)
	mov	lr, sp
	ldmia	lr!, {r0, r1, r2, r3}
	add	ip, sp, #36
.LPIC13:
	add	r4, pc, r4
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	ldr	r6, [sp, #48]
	bic	r6, r6, #10
	str	r6, [sp, #48]
	ldr	lr, [lr]
	stmia	ip!, {r0, r1, r2, r3}
	movw	r1, #21506
	add	r2, sp, #36
	mov	r0, #0
	str	lr, [ip]
	bl	ioctl(PLT)
	mov	r0, #0
	mov	r1, #3
	mov	r2, r0
	bl	fcntl(PLT)
	mov	r1, #4
	orr	r2, r0, #2048
	mov	r6, r0
	mov	r0, #0
	bl	fcntl(PLT)
	ldr	r3, .L25+4
	ldr	r4, [r4, r3]
	ldr	r3, [r4, #4]
	sub	r3, r3, #1
	str	r3, [r4, #4]
	cmp	r3, #0
	blt	.L24
	ldr	r3, [r4]
	mov	r2, sp
	movw	r1, #21506
	mov	r0, #0
	add	ip, r3, #1
	str	ip, [r4]
	ldrb	r7, [r3]	@ zero_extendqisi2
	bl	ioctl(PLT)
	mov	r2, r6
	mov	r0, #0
	mov	r1, #4
	bl	fcntl(PLT)
.L22:
	mov	r0, r7
	mov	r1, r4
	bl	ungetc(PLT)
	mov	r0, #1
	add	sp, sp, #76
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, pc}
.L24:
	mov	r0, r4
	bl	__srget(PLT)
	mov	r2, sp
	movw	r1, #21506
	mov	r7, r0
	mov	r0, #0
	bl	ioctl(PLT)
	mov	r2, r6
	mov	r0, #0
	mov	r1, #4
	bl	fcntl(PLT)
	cmn	r7, #1
	bne	.L22
	mov	r0, #0
	add	sp, sp, #76
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, pc}
.L26:
	.align	2
.L25:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC13+8)
	.word	__sF(GOT)
	.size	kbhit, .-kbhit
	.align	2
	.global	getKey
	.type	getKey, %function
getKey:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	bl	kbhit(PLT)
	ldr	r3, .L32
.LPIC14:
	add	r3, pc, r3
	cmp	r0, #0
	ldmeqfd	sp!, {r3, pc}
	ldr	r2, .L32+4
	ldr	r0, [r3, r2]
	ldr	r3, [r0, #4]
	sub	r3, r3, #1
	str	r3, [r0, #4]
	cmp	r3, #0
	blt	.L31
	ldr	r3, [r0]
	add	r2, r3, #1
	str	r2, [r0]
	ldrb	r0, [r3]	@ zero_extendqisi2
	ldmfd	sp!, {r3, pc}
.L31:
	bl	__srget(PLT)
	uxtb	r0, r0
	ldmfd	sp!, {r3, pc}
.L33:
	.align	2
.L32:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC14+8)
	.word	__sF(GOT)
	.size	getKey, .-getKey
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"/dev/sm9s5422_interrupt\000"
.LC1:
	.ascii	"Device Open ERROR!\000"
	.space	1
.LC2:
	.ascii	"Please push the button !\000"
	.space	3
.LC3:
	.ascii	"Up\000"
	.space	1
.LC4:
	.ascii	"\275\272\300\247\304\241 1\271\370\300\314 \304\321"
	.ascii	"\301\263\275\300\264\317\264\331\012\012\000"
	.space	2
.LC5:
	.ascii	"Down\000"
	.space	3
.LC6:
	.ascii	"\275\272\300\247\304\241 2\271\370\300\314 \304\321"
	.ascii	"\301\263\275\300\264\317\264\331\012\012\000"
	.space	2
.LC7:
	.ascii	"Left\000"
	.space	3
.LC8:
	.ascii	"\275\272\300\247\304\241 3\271\370\300\314 \304\321"
	.ascii	"\301\263\275\300\264\317\264\331\012\012\000"
	.space	2
.LC9:
	.ascii	"Right\000"
	.space	2
.LC10:
	.ascii	"\275\272\300\247\304\241 4\271\370\300\314 \304\321"
	.ascii	"\301\263\275\300\264\317\264\331\012\012\000"
	.space	2
.LC11:
	.ascii	"Center\000"
	.space	1
.LC12:
	.ascii	"\275\272\300\247\304\241 5\271\370\300\314 \304\321"
	.ascii	"\301\263\275\300\264\317\264\331\012\012\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
