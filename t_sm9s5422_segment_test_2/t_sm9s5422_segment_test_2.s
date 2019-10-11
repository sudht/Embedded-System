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
	.file	"t_sm9s5422_segment_test_2.c"
	.text
	.align	2
	.global	init_keyboard
	.type	init_keyboard, %function
init_keyboard:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, lr}
	movw	r1, #21505
	ldr	r5, .L2
	mov	r0, #0
	mov	r6, #0
.LPIC0:
	add	r5, pc, r5
	mov	r2, r5
	mov	r4, r5
	bl	ioctl(PLT)
	ldmia	r4!, {r0, r1, r2, r3}
	add	ip, r5, #36
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	ldr	r7, [r5, #48]
	bic	r7, r7, #11
	str	r7, [r5, #48]
	ldr	r4, [r4]
	stmia	ip!, {r0, r1, r2, r3}
	add	r2, r5, #36
	mov	r0, r6
	str	r4, [ip]
	strb	r6, [r5, #58]
	movw	r1, #21506
	ldmfd	sp!, {r3, r4, r5, r6, r7, lr}
	b	ioctl(PLT)
.L3:
	.align	2
.L2:
	.word	.LANCHOR0-(.LPIC0+8)
	.size	init_keyboard, .-init_keyboard
	.align	2
	.global	close_keyboard
	.type	close_keyboard, %function
close_keyboard:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, .L5
	mov	r0, #0
	movw	r1, #21506
.LPIC7:
	add	r2, pc, r2
	b	ioctl(PLT)
.L6:
	.align	2
.L5:
	.word	.LANCHOR0-(.LPIC7+8)
	.size	close_keyboard, .-close_keyboard
	.align	2
	.global	kbhit
	.type	kbhit, %function
kbhit:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	sub	sp, sp, #8
	ldr	r4, .L13
.LPIC8:
	add	r4, pc, r4
	ldr	r3, [r4]
	cmn	r3, #1
	movne	r0, #1
	beq	.L12
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, pc}
.L12:
	ldr	r6, .L13+4
	mov	r5, #0
	mov	r0, r5
	movw	r1, #21506
.LPIC9:
	add	r6, pc, r6
	add	r7, r6, #36
	strb	r5, [r6, #58]
	mov	r2, r7
	bl	ioctl(PLT)
	add	r1, sp, #7
	mov	r0, r5
	mov	r2, #1
	bl	read(PLT)
	mov	r2, r7
	movw	r1, #21506
	mov	r3, #1
	strb	r3, [r6, #58]
	mov	r8, r0
	mov	r0, r5
	bl	ioctl(PLT)
	cmp	r8, #1
	ldreqb	r3, [sp, #7]	@ zero_extendqisi2
	moveq	r0, r8
	movne	r0, r5
	streq	r3, [r4]
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, pc}
.L14:
	.align	2
.L13:
	.word	.LANCHOR1-(.LPIC8+8)
	.word	.LANCHOR0-(.LPIC9+8)
	.size	kbhit, .-kbhit
	.align	2
	.global	readch
	.type	readch, %function
readch:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L18
	str	lr, [sp, #-4]!
.LPIC14:
	add	r3, pc, r3
	sub	sp, sp, #12
	ldr	r0, [r3]
	cmn	r0, #1
	beq	.L16
	uxtb	r0, r0
	mvn	r2, #0
	str	r2, [r3]
	add	sp, sp, #12
	@ sp needed
	ldr	pc, [sp], #4
.L16:
	add	r1, sp, #7
	mov	r2, #1
	mov	r0, #0
	bl	read(PLT)
	ldrb	r0, [sp, #7]	@ zero_extendqisi2
	add	sp, sp, #12
	@ sp needed
	ldr	pc, [sp], #4
.L19:
	.align	2
.L18:
	.word	.LANCHOR1-(.LPIC14+8)
	.size	readch, .-readch
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L31
	movw	r1, #4098
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #36
.LPIC16:
	add	r0, pc, r0
	mov	r3, #0
	mov	r5, #1
	str	r3, [sp, #24]
	str	r5, [sp, #20]
	strh	r3, [sp, #28]	@ movhi
	bl	open(PLT)
	subs	r4, r0, #0
	blt	.L30
	bl	init_keyboard(PLT)
	ldr	r0, .L31+4
	mov	r6, #0
.LPIC18:
	add	r0, pc, r0
	bl	printf(PLT)
	bl	close_keyboard(PLT)
	ldr	r0, .L31+8
	add	r1, sp, #20
.LPIC19:
	add	r0, pc, r0
	bl	scanf(PLT)
	bl	init_keyboard(PLT)
	ldr	r3, [sp, #20]
	cmp	r3, r6
	addle	r5, sp, #24
	ble	.L22
	movw	r9, #46473
	movw	r8, #34464
	movw	r7, #35757
	movt	r9, 5368
	movt	r8, 1
	movt	r7, 26843
	add	r5, sp, #24
	movw	r3, #19923
	movw	r10, #34079
	movt	r3, 4194
	movw	ip, #26215
	movt	r10, 20971
	movt	ip, 26214
	str	r3, [sp, #4]
	str	r10, [sp, #8]
	str	ip, [sp, #12]
.L23:
	add	r6, r6, #1
	movw	r10, #10000
	mov	lr, #1000
	mov	ip, #100
	smull	r3, r2, r9, r6
	mov	r3, r6, asr #31
	mov	r1, r5
	mov	r0, r4
	rsb	r2, r3, r2, asr #13
	strb	r2, [sp, #24]
	mls	r2, r8, r2, r6
	smull	r3, fp, r7, r2
	mov	r3, r2, asr #31
	rsb	r3, r3, fp, asr #12
	strb	r3, [sp, #25]
	mls	r3, r10, r3, r2
	ldr	r10, [sp, #4]
	mov	r2, #6
	smull	r10, fp, r10, r3
	mov	r10, r3, asr #31
	rsb	r10, r10, fp, asr r2
	strb	r10, [sp, #26]
	mls	r3, lr, r10, r3
	ldr	lr, [sp, #8]
	smull	lr, r10, lr, r3
	mov	lr, r3, asr #31
	rsb	lr, lr, r10, asr #5
	ldr	r10, [sp, #12]
	strb	lr, [sp, #27]
	mls	r3, ip, lr, r3
	smull	r10, lr, r10, r3
	mov	ip, r3, asr #31
	rsb	ip, ip, lr, asr #2
	strb	ip, [sp, #28]
	add	ip, ip, ip, asl #2
	sub	r3, r3, ip, asl #1
	strb	r3, [sp, #29]
	bl	write(PLT)
	mov	r0, r4
	mov	r1, r5
	mov	r2, #6
	bl	write(PLT)
	ldr	r3, [sp, #20]
	cmp	r3, r6
	bgt	.L23
.L22:
	mov	r6, #50
.L25:
	mov	r0, r4
	mov	r1, r5
	mov	r2, #6
	bl	write(PLT)
	subs	r6, r6, #1
	bne	.L25
	bl	close_keyboard(PLT)
	mov	r0, r4
	bl	close(PLT)
	mov	r0, r6
	add	sp, sp, #36
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L30:
	ldr	r0, .L31+12
.LPIC17:
	add	r0, pc, r0
	bl	puts(PLT)
	mov	r0, r5
	bl	exit(PLT)
.L32:
	.align	2
.L31:
	.word	.LC0-(.LPIC16+8)
	.word	.LC2-(.LPIC18+8)
	.word	.LC3-(.LPIC19+8)
	.word	.LC1-(.LPIC17+8)
	.size	main, .-main
	.data
	.align	2
.LANCHOR1 = . + 0
	.type	peek_character, %object
	.size	peek_character, 4
peek_character:
	.word	-1
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"/dev/sm9s5422_segment\000"
	.space	2
.LC1:
	.ascii	"FND open fail\000"
	.space	2
.LC2:
	.ascii	"Input value : \000"
	.space	1
.LC3:
	.ascii	"%d\000"
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	initial_settings, %object
	.size	initial_settings, 36
initial_settings:
	.space	36
	.type	new_settings, %object
	.size	new_settings, 36
new_settings:
	.space	36
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
