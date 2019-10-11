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
	.file	"sm9s5422_sht20_test.c"
	.global	__aeabi_i2f
	.global	__aeabi_f2d
	.global	__aeabi_dmul
	.global	__aeabi_dsub
	.global	__aeabi_d2f
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L5
	mov	r1, #1
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
.LPIC0:
	add	r0, pc, r0
	bl	open(PLT)
	ldr	r7, .L5+4
	ldr	r6, .L5+8
	mov	r4, #10
.LPIC1:
	add	r7, pc, r7
.LPIC2:
	add	r6, pc, r6
	mov	r5, r0
.L3:
	mov	r0, #1
	ldr	r8, .L5+12
	bl	sleep(PLT)
	mov	r1, #0
	mov	r2, r1
	mov	r0, r5
	bl	ioctl(PLT)
.LPIC3:
	add	r8, pc, r8
	mov	r10, r0
	mov	r0, #1
	bl	sleep(PLT)
	mov	r2, #0
	mov	r1, #1
	mov	r0, r5
	bl	ioctl(PLT)
	mov	r9, r0
	mov	r0, r7
	bl	puts(PLT)
	mov	r0, r10
	bl	__aeabi_i2f(PLT)
	bl	__aeabi_f2d(PLT)
	movw	r2, #41943
	movw	r3, #63242
	movt	r2, 15728
	movt	r3, 16229
	bl	__aeabi_dmul(PLT)
	movw	r2, #52429
	movw	r3, #27852
	movt	r2, 52428
	movt	r3, 16455
	bl	__aeabi_dsub(PLT)
	bl	__aeabi_d2f(PLT)
	bl	__aeabi_f2d(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r0, r6
	bl	printf(PLT)
	mov	r0, r9
	bl	__aeabi_i2f(PLT)
	bl	__aeabi_f2d(PLT)
	mov	r2, #0
	mov	r3, #16384
	movt	r3, 16223
	bl	__aeabi_dmul(PLT)
	mov	r2, #0
	mov	r3, #0
	movt	r3, 16408
	bl	__aeabi_dsub(PLT)
	bl	__aeabi_d2f(PLT)
	bl	__aeabi_f2d(PLT)
	mov	r2, r0
	mov	r3, r1
	mov	r0, r8
	bl	printf(PLT)
	mov	r0, #10
	bl	putchar(PLT)
	subs	r4, r4, #1
	bne	.L3
	mov	r0, r5
	bl	close(PLT)
	mov	r0, r4
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
.L6:
	.align	2
.L5:
	.word	.LC0-(.LPIC0+8)
	.word	.LC1-(.LPIC1+8)
	.word	.LC2-(.LPIC2+8)
	.word	.LC3-(.LPIC3+8)
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"/dev/sm9s5422_sht20\000"
.LC1:
	.ascii	"*** TEMP/HUMI *** \000"
	.space	1
.LC2:
	.ascii	"Main Temp : %.1f C\012\000"
.LC3:
	.ascii	"Main Humi : %.1f H\012\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
