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
	.file	"t_sm9s5422_segment_test.c"
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
	ldr	r4, .L14
.LPIC8:
	add	r4, pc, r4
	ldr	r3, [r4]
	cmn	r3, #1
	movne	r0, #1
	beq	.L13
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, pc}
.L13:
	ldr	r6, .L14+4
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
.L15:
	.align	2
.L14:
	.word	.LANCHOR1-(.LPIC8+8)
	.word	.LANCHOR0-(.LPIC9+8)
	.size	kbhit, .-kbhit
	.align	2
	.global	readch
	.type	readch, %function
readch:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L19
	str	lr, [sp, #-4]!
.LPIC14:
	add	r3, pc, r3
	sub	sp, sp, #12
	ldr	r0, [r3]
	cmn	r0, #1
	beq	.L17
	uxtb	r0, r0
	mvn	r2, #0
	str	r2, [r3]
	add	sp, sp, #12
	@ sp needed
	ldr	pc, [sp], #4
.L17:
	add	r1, sp, #7
	mov	r2, #1
	mov	r0, #0
	bl	read(PLT)
	ldrb	r0, [sp, #7]	@ zero_extendqisi2
	add	sp, sp, #12
	@ sp needed
	ldr	pc, [sp], #4
.L20:
	.align	2
.L19:
	.word	.LANCHOR1-(.LPIC14+8)
	.size	readch, .-readch
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L66
	movw	r1, #4098
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #36
.LPIC16:
	add	r0, pc, r0
	mov	r3, #0
	mov	r4, #1
	str	r3, [sp, #24]
	str	r4, [sp, #20]
	strh	r3, [sp, #28]	@ movhi
	bl	open(PLT)
	subs	r5, r0, #0
	blt	.L61
	ldr	r4, .L66+4
	bl	init_keyboard(PLT)
	ldr	r1, .L66+8
	movw	r10, #46473
.LPIC18:
	add	r4, pc, r4
	movw	r9, #35757
.LPIC30:
	add	r1, pc, r1
	str	r1, [sp, #12]
	mov	r0, r4
	movt	r10, 5368
	bl	puts(PLT)
	ldr	r0, .L66+12
	movt	r9, 26843
.LPIC19:
	add	r0, pc, r0
	bl	puts(PLT)
	mov	r0, r4
	bl	puts(PLT)
	ldr	r0, .L66+16
.LPIC21:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L66+20
.LPIC22:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L66+24
.LPIC23:
	add	r0, pc, r0
	bl	puts(PLT)
	movw	r2, #19923
	movw	r3, #34079
	movt	r2, 4194
	movt	r3, 20971
	movw	r1, #26215
	str	r2, [sp]
	movt	r1, 26214
	str	r3, [sp, #4]
	str	r1, [sp, #8]
.L24:
	bl	kbhit(PLT)
	cmp	r0, #0
	beq	.L24
	bl	readch(PLT)
	cmp	r0, #99
	mov	r7, r0
	beq	.L26
	cmp	r0, #113
	bne	.L24
	bl	close_keyboard(PLT)
	mov	r0, r5
	bl	close(PLT)
	mov	r0, #0
	add	sp, sp, #36
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L26:
	ldr	r4, .L66+28
	movw	r8, #34464
	ldr	r0, [sp, #12]
	movt	r8, 1
	bl	printf(PLT)
.LPIC32:
	add	r4, pc, r4
	bl	close_keyboard(PLT)
	ldr	r0, .L66+32
	add	r1, sp, #20
.LPIC31:
	add	r0, pc, r0
	bl	scanf(PLT)
	bl	init_keyboard(PLT)
	mov	r0, r4
	ldr	r6, [sp, #20]
	bl	puts(PLT)
	ldr	r0, .L66+36
.LPIC33:
	add	r0, pc, r0
	bl	puts(PLT)
	mov	r0, r4
	bl	puts(PLT)
	ldr	r0, .L66+40
.LPIC35:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L66+44
.LPIC36:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L66+48
.LPIC37:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L66+52
.LPIC38:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L66+56
.LPIC39:
	add	r0, pc, r0
	bl	puts(PLT)
	mov	r1, #0
	mov	r0, r5
	mov	r2, r1
	mov	r3, r1
	bl	ioctl(PLT)
.L43:
	smull	r2, lr, r10, r6
	mov	r1, r6, asr #31
	movw	r2, #10000
	mov	r3, #1000
	mov	ip, #100
	cmp	r7, #99
	rsb	r0, r1, lr, asr #13
	strb	r0, [sp, #24]
	mls	r0, r8, r0, r6
	smull	r1, lr, r9, r0
	mov	r1, r0, asr #31
	rsb	r1, r1, lr, asr #12
	strb	r1, [sp, #25]
	mls	r1, r2, r1, r0
	ldr	r2, [sp]
	smull	r2, r0, r2, r1
	mov	r2, r1, asr #31
	rsb	r2, r2, r0, asr #6
	strb	r2, [sp, #26]
	mls	r2, r3, r2, r1
	ldr	r3, [sp, #4]
	smull	r3, r1, r3, r2
	mov	r3, r2, asr #31
	rsb	r3, r3, r1, asr #5
	strb	r3, [sp, #27]
	mls	r3, ip, r3, r2
	ldr	r2, [sp, #8]
	smull	r2, r1, r2, r3
	mov	r2, r3, asr #31
	rsb	r2, r2, r1, asr #2
	strb	r2, [sp, #28]
	add	r2, r2, r2, asl #2
	sub	r3, r3, r2, asl #1
	strb	r3, [sp, #29]
	beq	.L62
	cmp	r7, #114
	beq	.L63
	cmp	r7, #112
	beq	.L64
.L32:
	bl	kbhit(PLT)
	cmp	r0, #0
	bne	.L65
.L35:
	cmp	r7, #113
	bne	.L43
.L29:
	ldr	r4, .L66+60
.LPIC24:
	add	r4, pc, r4
	mov	r0, r4
	bl	puts(PLT)
	ldr	r0, .L66+64
.LPIC25:
	add	r0, pc, r0
	bl	puts(PLT)
	mov	r0, r4
	bl	puts(PLT)
	ldr	r0, .L66+68
.LPIC27:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L66+72
.LPIC28:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r0, .L66+76
.LPIC29:
	add	r0, pc, r0
	bl	puts(PLT)
	b	.L24
.L65:
	bl	readch(PLT)
	sub	r0, r0, #99
	cmp	r0, #15
	addls	pc, pc, r0, asl #2
	b	.L35
.L37:
	b	.L36
	b	.L35
	b	.L35
	b	.L35
	b	.L35
	b	.L35
	b	.L35
	b	.L35
	b	.L35
	b	.L35
	b	.L35
	b	.L35
	b	.L35
	b	.L44
	b	.L29
	b	.L39
.L44:
	mov	r7, #112
	b	.L43
.L36:
	mov	r7, #99
	b	.L43
.L39:
	mov	r7, #114
	b	.L43
.L62:
	cmp	r6, #0
	ble	.L29
	add	fp, sp, #24
	mov	r4, #14
.L31:
	mov	r0, r5
	mov	r1, fp
	mov	r2, #6
	bl	write(PLT)
	subs	r4, r4, #1
	bne	.L31
	sub	r6, r6, #1
	b	.L32
.L63:
	ldr	r6, [sp, #20]
	mov	r7, #99
	b	.L32
.L64:
	add	fp, sp, #24
	mov	r4, #14
.L34:
	mov	r0, r5
	mov	r1, fp
	mov	r2, #6
	bl	write(PLT)
	subs	r4, r4, #1
	bne	.L34
	b	.L32
.L61:
	ldr	r0, .L66+80
.LPIC17:
	add	r0, pc, r0
	bl	puts(PLT)
	mov	r0, r4
	bl	exit(PLT)
.L67:
	.align	2
.L66:
	.word	.LC0-(.LPIC16+8)
	.word	.LC2-(.LPIC18+8)
	.word	.LC7-(.LPIC30+8)
	.word	.LC3-(.LPIC19+8)
	.word	.LC4-(.LPIC21+8)
	.word	.LC5-(.LPIC22+8)
	.word	.LC6-(.LPIC23+8)
	.word	.LC2-(.LPIC32+8)
	.word	.LC8-(.LPIC31+8)
	.word	.LC9-(.LPIC33+8)
	.word	.LC10-(.LPIC35+8)
	.word	.LC11-(.LPIC36+8)
	.word	.LC12-(.LPIC37+8)
	.word	.LC5-(.LPIC38+8)
	.word	.LC6-(.LPIC39+8)
	.word	.LC2-(.LPIC24+8)
	.word	.LC3-(.LPIC25+8)
	.word	.LC4-(.LPIC27+8)
	.word	.LC5-(.LPIC28+8)
	.word	.LC6-(.LPIC29+8)
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
	.ascii	" --------------------\000"
	.space	2
.LC3:
	.ascii	" 7Segment Program\000"
	.space	2
.LC4:
	.ascii	" [c] counter\000"
	.space	3
.LC5:
	.ascii	" [q] exit\000"
	.space	2
.LC6:
	.ascii	" --------------------\012\000"
	.space	1
.LC7:
	.ascii	"Input counter value (0 : exit program, 999999~01 ) "
	.ascii	": \000"
	.space	2
.LC8:
	.ascii	"%d\000"
	.space	1
.LC9:
	.ascii	" Counter\000"
	.space	3
.LC10:
	.ascii	" [p] pause\000"
	.space	1
.LC11:
	.ascii	" [c] continue\000"
	.space	2
.LC12:
	.ascii	" [r] reset\000"
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
