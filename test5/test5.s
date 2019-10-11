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
	.file	"test5.c"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L11
	movw	r1, #4098
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #36
.LPIC0:
	add	r0, pc, r0
	mov	r3, #0
	str	r3, [sp, #24]
	strh	r3, [sp, #28]	@ movhi
	bl	open(PLT)
	subs	r4, r0, #0
	blt	.L10
	ldr	r9, .L11+4
	movw	fp, #46473
	add	r8, sp, #20
	movt	fp, 5368
.LPIC2:
	add	r9, pc, r9
	add	r5, sp, #24
	mov	r6, #20
	movw	r3, #35757
	movt	r3, 26843
	str	r3, [sp]
	movw	r3, #19923
	movt	r3, 4194
	str	r3, [sp, #4]
	movw	r3, #34079
	movt	r3, 20971
	str	r3, [sp, #8]
	movw	r3, #26215
	movt	r3, 26214
	str	r3, [sp, #12]
.L8:
	ldr	r1, .L11+8
	mov	r0, r9
.LPIC3:
	add	r1, pc, r1
	bl	fopen(PLT)
	ldr	r1, .L11+12
	mov	r2, r8
.LPIC4:
	add	r1, pc, r1
	mov	r7, r0
	bl	fscanf(PLT)
	ldr	r3, [sp, #20]
	cmp	r3, #2000
	blt	.L3
	mov	r3, #8
	strb	r3, [sp, #24]
	strb	r3, [sp, #25]
	strb	r3, [sp, #26]
	strb	r3, [sp, #27]
	strb	r3, [sp, #28]
	strb	r3, [sp, #29]
.L4:
	mov	r10, #10
.L6:
	mov	r0, r4
	mov	r1, r5
	mov	r2, #6
	bl	write(PLT)
	subs	r10, r10, #1
	bne	.L6
	mov	r0, r7
	bl	fclose(PLT)
	mov	r0, #3392
	movt	r0, 3
	bl	usleep(PLT)
	subs	r6, r6, #1
	bne	.L8
	mov	r0, r4
	bl	close(PLT)
	mov	r0, r6
	bl	exit(PLT)
.L3:
	smull	r2, ip, fp, r3
	mov	r1, r3, asr #31
	movw	r0, #34464
	movt	r0, 1
	movw	r2, #10000
	mov	lr, #1000
	rsb	r1, r1, ip, asr #13
	strb	r1, [sp, #24]
	mov	ip, #100
	mls	r0, r0, r1, r3
	ldr	r3, [sp]
	smull	r3, r1, r3, r0
	mov	r3, r0, asr #31
	rsb	r3, r3, r1, asr #12
	strb	r3, [sp, #25]
	mls	r1, r2, r3, r0
	ldr	r3, [sp, #4]
	smull	r3, r2, r3, r1
	mov	r3, r1, asr #31
	rsb	r2, r3, r2, asr #6
	strb	r2, [sp, #26]
	ldr	r3, [sp, #8]
	mls	r2, lr, r2, r1
	smull	r3, r1, r3, r2
	mov	r3, r2, asr #31
	rsb	r3, r3, r1, asr #5
	strb	r3, [sp, #27]
	mls	r3, ip, r3, r2
	ldr	r2, [sp, #12]
	smull	r2, r1, r2, r3
	mov	r2, r3, asr #31
	rsb	r2, r2, r1, asr #2
	strb	r2, [sp, #28]
	add	r2, r2, r2, asl #2
	sub	r3, r3, r2, asl #1
	strb	r3, [sp, #29]
	b	.L4
.L10:
	ldr	r0, .L11+16
.LPIC1:
	add	r0, pc, r0
	bl	puts(PLT)
	mov	r0, #1
	bl	exit(PLT)
.L12:
	.align	2
.L11:
	.word	.LC0-(.LPIC0+8)
	.word	.LC2-(.LPIC2+8)
	.word	.LC3-(.LPIC3+8)
	.word	.LC4-(.LPIC4+8)
	.word	.LC1-(.LPIC1+8)
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"/dev/sm9s5422_segment\000"
	.space	2
.LC1:
	.ascii	"FND open fail\000"
	.space	2
.LC2:
	.ascii	"/sys/devices/12d10000.adc/iio:device0/in_voltage4_r"
	.ascii	"aw\000"
	.space	2
.LC3:
	.ascii	"r\000"
	.space	2
.LC4:
	.ascii	"%d\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
