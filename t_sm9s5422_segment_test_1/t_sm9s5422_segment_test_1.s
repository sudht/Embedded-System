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
	.file	"t_sm9s5422_segment_test_1.c"
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
	.global	__aeabi_idiv
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L33
	movw	r1, #4098
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub	sp, sp, #24
.LPIC16:
	add	r0, pc, r0
	mov	r3, #0
	mov	r6, #1
	str	r3, [sp, #16]
	str	r6, [sp, #8]
	str	r6, [sp, #12]
	strh	r3, [sp, #20]	@ movhi
	bl	open(PLT)
	subs	r5, r0, #0
	blt	.L32
	bl	init_keyboard(PLT)
	ldr	r0, .L33+4
.LPIC18:
	add	r0, pc, r0
	bl	printf(PLT)
	bl	close_keyboard(PLT)
	ldr	r0, .L33+8
	add	r3, sp, #12
	add	r1, sp, #8
	add	r2, sp, #7
.LPIC19:
	add	r0, pc, r0
	bl	scanf(PLT)
	bl	init_keyboard(PLT)
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	sub	r3, r3, #42
	cmp	r3, #5
	addls	pc, pc, r3, asl #2
	b	.L22
.L24:
	b	.L23
	b	.L25
	b	.L22
	b	.L26
	b	.L22
	b	.L27
.L27:
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #12]
	bl	__aeabi_idiv(PLT)
	mov	r4, r0
.L22:
	movw	r3, #46473
	movt	r3, 5368
	mov	r2, r4, asr #31
	movw	ip, #34464
	smull	r0, r10, r3, r4
	movt	ip, 1
	movw	r7, #35757
	movt	r7, 26843
	movw	r1, #10000
	movw	r6, #19923
	movt	r6, 4194
	mov	r3, #1000
	movw	lr, #34079
	movt	lr, 20971
	rsb	r10, r2, r10, asr #13
	mov	r9, #100
	movw	r2, #26215
	movt	r2, 26214
	mls	ip, ip, r10, r4
	movw	r8, #16959
	movt	r8, 15
	strb	r10, [sp, #16]
	cmp	r4, r8
	smull	r0, r7, r7, ip
	mov	r0, ip, asr #31
	rsb	r0, r0, r7, asr #12
	strb	r0, [sp, #17]
	mls	r0, r1, r0, ip
	smull	r1, r6, r6, r0
	mov	r1, r0, asr #31
	rsb	r1, r1, r6, asr #6
	strb	r1, [sp, #18]
	mls	r1, r3, r1, r0
	smull	r3, lr, lr, r1
	mov	r3, r1, asr #31
	rsb	r3, r3, lr, asr #5
	strb	r3, [sp, #19]
	mls	r3, r9, r3, r1
	smull	r0, r2, r2, r3
	mov	r1, r3, asr #31
	rsb	r2, r1, r2, asr #2
	strb	r2, [sp, #20]
	add	r2, r2, r2, asl #2
	sub	r3, r3, r2, asl #1
	strb	r3, [sp, #21]
	ble	.L30
	mov	r3, #8
	strb	r3, [sp, #16]
	strb	r3, [sp, #17]
	strb	r3, [sp, #18]
	strb	r3, [sp, #19]
	strb	r3, [sp, #20]
	strb	r3, [sp, #21]
.L30:
	add	r6, sp, #16
	mov	r4, #50
.L29:
	mov	r0, r5
	mov	r1, r6
	mov	r2, #6
	bl	write(PLT)
	subs	r4, r4, #1
	bne	.L29
	bl	close_keyboard(PLT)
	mov	r0, r5
	bl	close(PLT)
	mov	r0, r4
	add	sp, sp, #24
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
.L26:
	ldr	r4, [sp, #8]
	ldr	r3, [sp, #12]
	rsb	r4, r3, r4
	b	.L22
.L25:
	ldr	r4, [sp, #8]
	ldr	r3, [sp, #12]
	add	r4, r4, r3
	b	.L22
.L23:
	ldr	r3, [sp, #8]
	ldr	r4, [sp, #12]
	mul	r4, r4, r3
	b	.L22
.L32:
	ldr	r0, .L33+12
.LPIC17:
	add	r0, pc, r0
	bl	puts(PLT)
	mov	r0, r6
	bl	exit(PLT)
.L34:
	.align	2
.L33:
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
	.ascii	"Input calcurator value : \000"
	.space	2
.LC3:
	.ascii	"%d%c%d\000"
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
