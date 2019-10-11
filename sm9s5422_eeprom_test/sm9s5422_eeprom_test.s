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
	.file	"sm9s5422_eeprom_test.c"
	.text
	.align	2
	.global	eeprom_write
	.type	eeprom_write, %function
eeprom_write:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	sub	sp, sp, #28
	ldr	r4, .L2
	mov	r3, #0
	ldr	r0, .L2+4
	mov	r5, #4
.LPIC1:
	add	r4, pc, r4
	strb	r3, [sp, #21]
.LPIC0:
	add	r0, pc, r0
	strb	r3, [sp, #22]
	strb	r3, [sp, #23]
	mov	r2, #2
	strb	r5, [sp, #8]
	strb	r2, [sp, #20]
	mov	r2, #6
	strb	r2, [sp, #4]
	bl	printf(PLT)
	add	r1, sp, #12
	mov	r0, r4
	bl	scanf(PLT)
	ldr	r0, .L2+8
.LPIC2:
	add	r0, pc, r0
	bl	printf(PLT)
	add	r1, sp, #16
	mov	r0, r4
	ldr	r4, .L2+12
	bl	scanf(PLT)
	ldr	ip, .L2+16
	ldr	r0, [sp, #12]
.LPIC4:
	add	r4, pc, r4
	ldr	r3, [sp, #16]
	add	r1, sp, r5
	mov	r2, #1
	strb	r0, [sp, #22]
	mov	r0, r0, asr #8
	strb	r3, [sp, #23]
	mov	r3, r4
	strb	r0, [sp, #21]
	ldr	r4, [r4, ip]
	ldr	r0, [r4]
	bl	write(PLT)
	mov	r0, #1000
	bl	usleep(PLT)
	mov	r2, r5
	add	r1, sp, #20
	ldr	r0, [r4]
	bl	write(PLT)
	mov	r0, #2000
	bl	usleep(PLT)
	ldr	r0, [r4]
	add	r1, sp, #8
	mov	r2, #1
	bl	write(PLT)
	add	sp, sp, #28
	@ sp needed
	ldmfd	sp!, {r4, r5, pc}
.L3:
	.align	2
.L2:
	.word	.LC1-(.LPIC1+8)
	.word	.LC0-(.LPIC0+8)
	.word	.LC2-(.LPIC2+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC4+8)
	.word	dev(GOT)
	.size	eeprom_write, .-eeprom_write
	.align	2
	.global	eeprom_read
	.type	eeprom_read, %function
eeprom_read:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L8
	mov	r3, #0
	stmfd	sp!, {r4, lr}
	sub	sp, sp, #16
.LPIC5:
	add	r0, pc, r0
	mov	r4, #3
	strb	r3, [sp, #9]
	strb	r3, [sp, #10]
	strb	r4, [sp, #8]
	bl	printf(PLT)
	ldr	r0, .L8+4
	add	r1, sp, #12
.LPIC6:
	add	r0, pc, r0
	bl	scanf(PLT)
	ldr	r3, .L8+8
	ldr	r0, [sp, #12]
	add	r1, sp, #8
	ldr	ip, .L8+12
.LPIC7:
	add	r3, pc, r3
	mov	r2, r4
	strb	r0, [sp, #10]
	mov	r0, r0, asr #8
	strb	r0, [sp, #9]
	ldr	r3, [r3, ip]
	ldr	r0, [r3]
	bl	read(PLT)
	subs	r1, r0, #0
	blt	.L7
.L5:
	ldr	r0, .L8+16
.LPIC9:
	add	r0, pc, r0
	bl	printf(PLT)
	add	sp, sp, #16
	@ sp needed
	ldmfd	sp!, {r4, pc}
.L7:
	ldr	r0, .L8+20
	str	r1, [sp, #4]
.LPIC8:
	add	r0, pc, r0
	bl	puts(PLT)
	ldr	r1, [sp, #4]
	b	.L5
.L9:
	.align	2
.L8:
	.word	.LC0-(.LPIC5+8)
	.word	.LC1-(.LPIC6+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC7+8)
	.word	dev(GOT)
	.word	.LC4-(.LPIC9+8)
	.word	.LC3-(.LPIC8+8)
	.size	eeprom_read, .-eeprom_read
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L21
	mov	r1, #2
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #12
.LPIC10:
	add	r0, pc, r0
	mov	r3, #0
	str	r3, [sp, #4]
	bl	open(PLT)
	ldr	r4, .L21+4
	ldr	r2, .L21+8
.LPIC11:
	add	r4, pc, r4
	ldr	fp, [r4, r2]
	mov	r3, r4
	cmp	r0, #0
	str	r0, [fp]
	blt	.L11
	ldr	r9, .L21+12
	add	r10, sp, #4
	ldr	r8, .L21+16
	ldr	r7, .L21+20
.LPIC14:
	add	r9, pc, r9
	ldr	r6, .L21+24
.LPIC15:
	add	r8, pc, r8
	ldr	r5, .L21+28
.LPIC16:
	add	r7, pc, r7
	ldr	r4, .L21+32
.LPIC17:
	add	r6, pc, r6
.LPIC18:
	add	r5, pc, r5
.LPIC19:
	add	r4, pc, r4
.L12:
	mov	r0, r9
	bl	puts(PLT)
	mov	r0, r8
	bl	puts(PLT)
	mov	r0, r7
	bl	puts(PLT)
	mov	r0, r6
	bl	puts(PLT)
	mov	r0, r5
	bl	puts(PLT)
	mov	r0, r4
	mov	r1, r10
	bl	scanf(PLT)
	ldr	r3, [sp, #4]
	cmp	r3, #2
	beq	.L16
	ldr	r0, .L21+36
	cmp	r3, #3
.LPIC13:
	add	r0, pc, r0
	beq	.L18
	cmp	r3, #1
	beq	.L20
	bl	puts(PLT)
	b	.L12
.L16:
	bl	eeprom_read(PLT)
	b	.L12
.L20:
	bl	eeprom_write(PLT)
	b	.L12
.L18:
	ldr	r0, [fp]
	bl	close(PLT)
	mov	r0, #0
.L13:
	add	sp, sp, #12
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L11:
	ldr	r0, .L21+40
.LPIC12:
	add	r0, pc, r0
	bl	puts(PLT)
	mvn	r0, #0
	b	.L13
.L22:
	.align	2
.L21:
	.word	.LC5-(.LPIC10+8)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC11+8)
	.word	dev(GOT)
	.word	.LC8-(.LPIC14+8)
	.word	.LC9-(.LPIC15+8)
	.word	.LC10-(.LPIC16+8)
	.word	.LC11-(.LPIC17+8)
	.word	.LC12-(.LPIC18+8)
	.word	.LC1-(.LPIC19+8)
	.word	.LC7-(.LPIC13+8)
	.word	.LC6-(.LPIC12+8)
	.size	main, .-main
	.comm	dev,4,4
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"plz input address (0 ~ 2047) :\000"
	.space	1
.LC1:
	.ascii	"%d\000"
	.space	1
.LC2:
	.ascii	"plz input write data (0 ~ 255) :\000"
	.space	3
.LC3:
	.ascii	"can't send spi message\000"
	.space	1
.LC4:
	.ascii	"\012\011 recive data = %d\012\012\000"
	.space	2
.LC5:
	.ascii	"/dev/sm9_eeprom\000"
.LC6:
	.ascii	"/dev/sm9_eeprom open error ! \000"
	.space	2
.LC7:
	.ascii	"plz Enter a number 1-3\000"
	.space	1
.LC8:
	.ascii	"*********** eeprom test ***********\000"
.LC9:
	.ascii	" 1. DATA WRITE\000"
	.space	1
.LC10:
	.ascii	" 2. DATA READ\000"
	.space	2
.LC11:
	.ascii	" 3. END\000"
.LC12:
	.ascii	"************************************\012\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
