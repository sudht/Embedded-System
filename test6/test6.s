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
	.file	"test6.c"
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 120
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #124
	ldr	r2, .L30
	movw	r1, #4098
	ldr	r0, .L30+4
	mov	r3, #0
.LPIC5:
	add	r2, pc, r2
	str	r2, [sp]
	ldr	r2, .L30+8
.LPIC0:
	add	r0, pc, r0
	str	r3, [sp, #12]
	add	r6, sp, #20
.LPIC6:
	add	r2, pc, r2
	strh	r3, [sp, #16]	@ movhi
	str	r2, [sp, #4]
	bl	open(PLT)
	mov	r1, #2
	ldr	r8, .L30+12
	ldr	r9, .L30+16
	add	r5, sp, #12
	ldr	r10, .L30+20
.LPIC2:
	add	r8, pc, r8
.LPIC3:
	add	r9, pc, r9
.LPIC4:
	add	r10, pc, r10
	mov	r4, r0
	ldr	r0, .L30+24
.LPIC1:
	add	r0, pc, r0
	bl	open(PLT)
	mov	r7, r0
.L2:
	mov	r1, r6
	mov	r2, #100
	mov	r0, r7
	bl	read(PLT)
	mov	r0, r6
	mov	r1, r8
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L3
	ldrb	r2, [sp, #17]	@ zero_extendqisi2
	mov	fp, #10
	add	r2, r2, #1
	strb	r2, [sp, #17]
.L5:
	mov	r0, r4
	mov	r1, r5
	mov	r2, #6
	bl	write(PLT)
	subs	fp, fp, #1
	bne	.L5
	b	.L2
.L3:
	mov	r0, r6
	mov	r1, r9
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L6
	ldrb	r2, [sp, #16]	@ zero_extendqisi2
	mov	fp, #10
	add	r2, r2, #1
	strb	r2, [sp, #16]
.L7:
	mov	r0, r4
	mov	r1, r5
	mov	r2, #6
	bl	write(PLT)
	subs	fp, fp, #1
	bne	.L7
	b	.L2
.L6:
	mov	r0, r6
	mov	r1, r10
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L8
	ldrb	r2, [sp, #15]	@ zero_extendqisi2
	mov	fp, #10
	add	r2, r2, #1
	strb	r2, [sp, #15]
.L9:
	mov	r0, r4
	mov	r1, r5
	mov	r2, #6
	bl	write(PLT)
	subs	fp, fp, #1
	bne	.L9
	b	.L2
.L8:
	mov	r0, r6
	ldr	r1, [sp]
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L10
	ldrb	r2, [sp, #14]	@ zero_extendqisi2
	mov	fp, #10
	add	r2, r2, #1
	strb	r2, [sp, #14]
.L11:
	mov	r0, r4
	mov	r1, r5
	mov	r2, #6
	bl	write(PLT)
	subs	fp, fp, #1
	bne	.L11
	b	.L2
.L10:
	mov	r0, r6
	ldr	r1, [sp, #4]
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L2
	mov	fp, #10
	strb	r0, [sp, #12]
	strb	r0, [sp, #13]
	strb	r0, [sp, #14]
	strb	r0, [sp, #15]
	strb	r0, [sp, #16]
	strb	r0, [sp, #17]
.L12:
	mov	r0, r4
	mov	r1, r5
	mov	r2, #6
	bl	write(PLT)
	subs	fp, fp, #1
	bne	.L12
	b	.L2
.L31:
	.align	2
.L30:
	.word	.LC5-(.LPIC5+8)
	.word	.LC0-(.LPIC0+8)
	.word	.LC6-(.LPIC6+8)
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
	.ascii	"/dev/t_sm9s5422_interrupt\000"
	.space	2
.LC2:
	.ascii	"Up\000"
	.space	1
.LC3:
	.ascii	"Down\000"
	.space	3
.LC4:
	.ascii	"Left\000"
	.space	3
.LC5:
	.ascii	"Right\000"
	.space	2
.LC6:
	.ascii	"Center\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
