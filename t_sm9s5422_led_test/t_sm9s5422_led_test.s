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
	.file	"t_sm9s5422_led_test.c"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	cmp	r0, #1
	sub	sp, sp, #8
	mov	r5, #0
	mov	r6, r1
	str	r5, [sp]
	str	r5, [sp, #4]
	ble	.L15
	ldr	r0, .L17
	mov	r1, #1
.LPIC9:
	add	r0, pc, r0
	bl	open(PLT)
	cmn	r0, #1
	mov	r4, r0
	beq	.L4
	ldr	r0, [r6, #4]
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #48
	beq	.L16
.L5:
	bl	atoi(PLT)
	uxtb	r0, r0
.L6:
	mov	r1, sp
	mov	r2, #0
	mov	lr, #1
.L9:
	mov	r3, r0, asr r2
	tst	r3, #1
	strneb	lr, [r1, r2]
	add	r2, r2, #1
	cmp	r2, #8
	bne	.L9
	mov	r1, sp
	mov	r0, r4
	bl	write(PLT)
	mov	r0, r4
	bl	close(PLT)
	mov	r0, #0
.L3:
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, pc}
.L16:
	ldrb	r3, [r0, #1]	@ zero_extendqisi2
	and	r3, r3, #223
	cmp	r3, #88
	bne	.L5
	add	r0, r0, #2
	mov	r1, r5
	mov	r2, #16
	bl	strtol(PLT)
	uxtb	r0, r0
	b	.L6
.L15:
	ldr	r0, .L17+4
.LPIC8:
	add	r0, pc, r0
	bl	puts(PLT)
	mvn	r0, #0
	b	.L3
.L4:
	ldr	r0, .L17+8
.LPIC10:
	add	r0, pc, r0
	bl	puts(PLT)
	mov	r0, r4
	b	.L3
.L18:
	.align	2
.L17:
	.word	.LC1-(.LPIC9+8)
	.word	.LC0-(.LPIC8+8)
	.word	.LC2-(.LPIC10+8)
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
