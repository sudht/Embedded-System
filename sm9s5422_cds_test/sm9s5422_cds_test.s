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
	.file	"sm9s5422_cds_test.c"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub	sp, sp, #8
	ldr	r10, .L5
	add	r9, sp, #4
	ldr	r8, .L5+4
	mov	r4, #20
	ldr	r7, .L5+8
.LPIC0:
	add	r10, pc, r10
	ldr	r6, .L5+12
.LPIC1:
	add	r8, pc, r8
.LPIC2:
	add	r7, pc, r7
.LPIC3:
	add	r6, pc, r6
.L3:
	mov	r1, r8
	mov	r0, r10
	bl	fopen(PLT)
	mov	r2, r9
	mov	r1, r7
	mov	r5, r0
	bl	fscanf(PLT)
	ldr	r1, [sp, #4]
	mov	r0, r6
	bl	printf(PLT)
	mov	r0, r5
	bl	fclose(PLT)
	mov	r0, #3392
	movt	r0, 3
	bl	usleep(PLT)
	subs	r4, r4, #1
	bne	.L3
	mov	r0, r4
	bl	exit(PLT)
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
	.ascii	"/sys/devices/12d10000.adc/iio:device0/in_voltage3_r"
	.ascii	"aw\000"
	.space	2
.LC1:
	.ascii	"r\000"
	.space	2
.LC2:
	.ascii	"%d\000"
	.space	1
.LC3:
	.ascii	"CDS - > %d\012\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
