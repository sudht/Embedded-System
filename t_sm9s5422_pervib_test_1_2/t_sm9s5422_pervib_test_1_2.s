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
	.file	"t_sm9s5422_pervib_test_1_2.c"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, lr}
	mov	r4, r0
	ldr	r0, .L9
	sub	sp, sp, #108
	mov	r5, r1
	mov	r1, #1
.LPIC0:
	add	r0, pc, r0
	bl	open(PLT)
	mov	r1, #2
	mov	r8, r0
	ldr	r0, .L9+4
.LPIC1:
	add	r0, pc, r0
	bl	open(PLT)
	mov	r7, r0
	ldr	r0, [r5, #4]
	bl	atoi(PLT)
	cmp	r4, #1
	strb	r0, [sp, #3]
	ble	.L2
	ldr	r6, .L9+8
	add	r4, sp, #4
	ldr	r5, .L9+12
	add	r9, sp, #3
.LPIC3:
	add	r6, pc, r6
.LPIC4:
	add	r5, pc, r5
.L3:
	mov	r1, r4
	mov	r2, #100
	mov	r0, r7
	bl	read(PLT)
	mov	r1, r6
	mov	r0, r4
	bl	strcmp(PLT)
	mov	r1, r5
	cmp	r0, #0
	mov	r0, r4
	beq	.L8
	bl	strcmp(PLT)
	subs	r1, r0, #0
	bne	.L3
	mov	r0, r8
	mov	r2, #1
	bl	write(PLT)
	b	.L3
.L8:
	mov	r0, r8
	mov	r1, r9
	mov	r2, #1
	bl	write(PLT)
	b	.L3
.L2:
	ldr	r0, .L9+16
.LPIC2:
	add	r0, pc, r0
	bl	puts(PLT)
	mvn	r0, #0
	add	sp, sp, #108
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, pc}
.L10:
	.align	2
.L9:
	.word	.LC0-(.LPIC0+8)
	.word	.LC1-(.LPIC1+8)
	.word	.LC3-(.LPIC3+8)
	.word	.LC4-(.LPIC4+8)
	.word	.LC2-(.LPIC2+8)
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
	ldr	r5, .L14
	bl	ioctl(PLT)
	mov	lr, sp
	ldmia	lr!, {r0, r1, r2, r3}
	add	ip, sp, #36
.LPIC5:
	add	r5, pc, r5
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
	ldr	r3, .L14+4
	ldr	r5, [r5, r3]
	mov	r0, r5
	bl	getc(PLT)
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
	moveq	r0, #0
	beq	.L12
	mov	r0, r7
	mov	r1, r5
	bl	ungetc(PLT)
	mov	r0, #1
.L12:
	add	sp, sp, #76
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, pc}
.L15:
	.align	2
.L14:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC5+8)
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
	ldr	r3, .L19
.LPIC6:
	add	r3, pc, r3
	cmp	r0, #0
	ldmeqfd	sp!, {r3, pc}
	ldr	r2, .L19+4
	ldr	r0, [r3, r2]
	bl	getc(PLT)
	uxtb	r0, r0
	ldmfd	sp!, {r3, pc}
.L20:
	.align	2
.L19:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC6+8)
	.word	__sF(GOT)
	.size	getKey, .-getKey
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"/dev/two_sm9s5422_perivib\000"
	.space	2
.LC1:
	.ascii	"/dev/t_sm9s5422_interrupt\000"
	.space	2
.LC2:
	.ascii	"please input the parameter! ex)./test 1 or 0\000"
	.space	3
.LC3:
	.ascii	"Up\000"
	.space	1
.LC4:
	.ascii	"Down\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
