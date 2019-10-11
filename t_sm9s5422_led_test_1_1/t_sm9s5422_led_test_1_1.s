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
	.file	"t_sm9s5422_led_test_1_1.c"
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
	ldr	r4, .L7
	bl	ioctl(PLT)
	mov	lr, sp
	ldmia	lr!, {r0, r1, r2, r3}
	add	ip, sp, #36
.LPIC0:
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
	ldr	r3, .L7+4
	ldr	r4, [r4, r3]
	ldr	r3, [r4, #4]
	sub	r3, r3, #1
	str	r3, [r4, #4]
	cmp	r3, #0
	blt	.L6
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
.L3:
	mov	r0, r7
	mov	r1, r4
	bl	ungetc(PLT)
	mov	r0, #1
	add	sp, sp, #76
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, pc}
.L6:
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
	bne	.L3
	mov	r0, #0
	add	sp, sp, #76
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, pc}
.L8:
	.align	2
.L7:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC0+8)
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
	ldr	r3, .L14
.LPIC1:
	add	r3, pc, r3
	cmp	r0, #0
	ldmeqfd	sp!, {r3, pc}
	ldr	r2, .L14+4
	ldr	r0, [r3, r2]
	ldr	r3, [r0, #4]
	sub	r3, r3, #1
	str	r3, [r0, #4]
	cmp	r3, #0
	blt	.L13
	ldr	r3, [r0]
	add	r2, r3, #1
	str	r2, [r0]
	ldrb	r0, [r3]	@ zero_extendqisi2
	ldmfd	sp!, {r3, pc}
.L13:
	bl	__srget(PLT)
	uxtb	r0, r0
	ldmfd	sp!, {r3, pc}
.L15:
	.align	2
.L14:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC1+8)
	.word	__sF(GOT)
	.size	getKey, .-getKey
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	cmp	r0, #1
	sub	sp, sp, #20
	mov	r4, #0
	mov	r6, r1
	str	r4, [sp, #8]
	str	r4, [sp, #12]
	ble	.L30
	ldr	r0, .L33
	mov	r1, #1
.LPIC11:
	add	r0, pc, r0
	bl	open(PLT)
	cmn	r0, #1
	mov	r5, r0
	beq	.L19
	ldr	r0, [r6, #4]
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #48
	bne	.L20
	ldrb	r3, [r0, #1]	@ zero_extendqisi2
	and	r3, r3, #223
	cmp	r3, #88
	beq	.L31
.L20:
	bl	atoi(PLT)
.L21:
	add	r3, sp, #7
	add	r6, sp, #8
	add	r9, sp, #15
	movw	r4, #10000
	mov	r8, #1
	mov	r7, #0
	str	r3, [sp, #4]
	mov	r10, r3
	mov	r3, #100
	str	r3, [sp]
.L29:
	bl	getKey(PLT)
	cmp	r0, #43
	addeq	r4, r4, #1000
	beq	.L23
	cmp	r0, #45
	beq	.L32
.L23:
	add	fp, sp, #7
.L25:
	mov	r1, r6
	mov	r2, #8
	strb	r8, [fp, #1]
	mov	r0, r5
	bl	write(PLT)
	mov	r0, r4
	bl	usleep(PLT)
	mov	r1, r6
	mov	r2, #8
	strb	r7, [fp, #1]!
	mov	r0, r5
	bl	write(PLT)
	mov	r0, r4
	bl	usleep(PLT)
	cmp	fp, r9
	bne	.L25
	mov	fp, r9
.L27:
	mov	r1, r6
	mov	r2, #8
	strb	r8, [fp]
	mov	r0, r5
	bl	write(PLT)
	mov	r0, r4
	bl	usleep(PLT)
	mov	r1, r6
	mov	r2, #8
	strb	r7, [fp], #-1
	mov	r0, r5
	bl	write(PLT)
	mov	r0, r4
	bl	usleep(PLT)
	cmp	fp, r10
	bne	.L27
	ldr	r3, [sp]
	subs	r3, r3, #1
	str	r3, [sp]
	bne	.L29
	mov	r1, r6
	mov	r2, #8
	mov	r0, r5
	bl	write(PLT)
	mov	r0, r5
	bl	close(PLT)
	ldr	r0, [sp]
.L18:
	add	sp, sp, #20
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L32:
	cmp	r4, #1000
	subgt	r4, r4, #1000
	b	.L23
.L31:
	mov	r1, r4
	mov	r2, #16
	add	r0, r0, #2
	bl	strtol(PLT)
	b	.L21
.L19:
	ldr	r0, .L33+4
.LPIC12:
	add	r0, pc, r0
	bl	puts(PLT)
	mov	r0, r5
	b	.L18
.L30:
	ldr	r0, .L33+8
.LPIC10:
	add	r0, pc, r0
	bl	puts(PLT)
	mvn	r0, #0
	b	.L18
.L34:
	.align	2
.L33:
	.word	.LC1-(.LPIC11+8)
	.word	.LC2-(.LPIC12+8)
	.word	.LC0-(.LPIC10+8)
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"please input the parameter! ex)./test 0xff\000"
	.space	1
.LC1:
	.ascii	"/dev/t_sm9s5422_led\000"
.LC2:
	.ascii	"Device Open ERROR!\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
