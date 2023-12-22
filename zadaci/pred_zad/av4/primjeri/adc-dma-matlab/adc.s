	.syntax unified
	.cpu cortex-m4
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu fpv4-sp-d16
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.thumb
	.file	"adc.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.global	initADC1
	.thumb
	.thumb_func
	.type	initADC1, %function
initADC1:
.LFB110:
	.file 1 "adc.c"
	.loc 1 4 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 9 0
	ldr	r1, .L3
	.loc 1 11 0
	ldr	r2, .L3+4
	.loc 1 9 0
	ldr	r0, [r1, #48]
	.loc 1 14 0
	ldr	r3, .L3+8
	.loc 1 9 0
	orr	r0, r0, #1
	.loc 1 4 0
	push	{r4, r5, r6, r7, lr}
	.cfi_def_cfa_offset 20
	.cfi_offset 4, -20
	.cfi_offset 5, -16
	.cfi_offset 6, -12
	.cfi_offset 7, -8
	.cfi_offset 14, -4
	.loc 1 9 0
	str	r0, [r1, #48]
	.loc 1 10 0
	ldr	r0, [r1, #68]
	.loc 1 21 0
	ldr	r4, .L3+12
	.loc 1 10 0
	orr	r0, r0, #256
	str	r0, [r1, #68]
	.loc 1 11 0
	ldr	r1, [r2]
	orr	r1, r1, #12
	str	r1, [r2]
	.loc 1 12 0
	ldr	r1, [r2, #12]
	.loc 1 17 0
	movs	r0, #0
	.loc 1 14 0
	mov	lr, #2048
	.loc 1 12 0
	bic	r1, r1, #12
	.loc 1 19 0
	movs	r7, #1
	.loc 1 20 0
	mov	r6, #512
	.loc 1 21 0
	mov	r5, #196608
	.loc 1 12 0
	str	r1, [r2, #12]
	.loc 1 14 0
	str	lr, [r3, #4]
	.loc 1 17 0
	str	r0, [r3, #12]
	.loc 1 18 0
	str	r0, [r3, #44]
	.loc 1 19 0
	str	r7, [r3, #52]
	.loc 1 20 0
	str	r6, [r3, #8]
	.loc 1 21 0
	str	r5, [r4, #4]
	pop	{r4, r5, r6, r7, pc}
.L4:
	.align	2
.L3:
	.word	1073887232
	.word	1073872896
	.word	1073815552
	.word	1073816320
	.cfi_endproc
.LFE110:
	.size	initADC1, .-initADC1
	.align	2
	.global	getADC1
	.thumb
	.thumb_func
	.type	getADC1, %function
getADC1:
.LFB111:
	.loc 1 25 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 28 0
	ldr	r2, .L10
	ldr	r3, [r2, #8]
	orr	r3, r3, #1
	str	r3, [r2, #8]
	.loc 1 29 0
	ldr	r3, [r2, #8]
	orr	r3, r3, #1073741824
	str	r3, [r2, #8]
.L6:
	.loc 1 31 0 discriminator 1
	ldr	r3, [r2]
	ldr	r1, .L10
	lsls	r3, r3, #30
	bpl	.L6
	.loc 1 33 0
	ldr	r0, [r1, #76]
.LVL0:
	.loc 1 35 0
	ldr	r3, [r1, #8]
	bic	r3, r3, #1
	.loc 1 37 0
	uxth	r0, r0
	.loc 1 35 0
	str	r3, [r1, #8]
	.loc 1 37 0
	bx	lr
.L11:
	.align	2
.L10:
	.word	1073815552
	.cfi_endproc
.LFE111:
	.size	getADC1, .-getADC1
	.align	2
	.global	initDmaADC1
	.thumb
	.thumb_func
	.type	initDmaADC1, %function
initDmaADC1:
.LFB112:
	.loc 1 40 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
.LVL1:
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	.cfi_def_cfa_offset 36
	.cfi_offset 4, -36
	.cfi_offset 5, -32
	.cfi_offset 6, -28
	.cfi_offset 7, -24
	.cfi_offset 8, -20
	.cfi_offset 9, -16
	.cfi_offset 10, -12
	.cfi_offset 11, -8
	.cfi_offset 14, -4
	.loc 1 45 0
	ldr	r5, .L16
	.loc 1 47 0
	ldr	r6, .L16+4
	.loc 1 45 0
	ldr	r7, [r5, #48]
	.loc 1 52 0
	ldr	r3, .L16+8
	.loc 1 62 0
	ldr	ip, .L16+28
	.loc 1 69 0
	ldr	r4, .L16+12
	.loc 1 93 0
	ldr	lr, .L16+16
	.loc 1 45 0
	orr	r7, r7, #4
	str	r7, [r5, #48]
	.loc 1 47 0
	ldr	r7, [r6]
	orr	r7, r7, #3072
	str	r7, [r6]
	.loc 1 48 0
	ldr	r7, [r6, #12]
	bic	r7, r7, #3072
	str	r7, [r6, #12]
	.loc 1 49 0
	ldr	r7, [r5, #68]
	.loc 1 56 0
	movs	r6, #0
	.loc 1 52 0
	mov	r10, #2048
	.loc 1 49 0
	orr	r7, r7, #256
	.loc 1 60 0
	mov	r9, #512
	.loc 1 62 0
	mov	r8, #65536
	.loc 1 59 0
	mov	fp, #15
	.loc 1 49 0
	str	r7, [r5, #68]
	.loc 1 52 0
	str	r10, [r3, #4]
	.loc 1 56 0
	str	r6, [r3, #12]
	.loc 1 57 0
	str	r6, [r3, #44]
	.loc 1 58 0
	str	r6, [r3, #48]
	.loc 1 59 0
	str	fp, [r3, #52]
	.loc 1 60 0
	str	r9, [r3, #8]
	.loc 1 62 0
	str	r8, [ip, #4]
	.loc 1 68 0
	ldr	r7, [r5, #64]
	.loc 1 75 0
	mov	ip, #32
	.loc 1 68 0
	orr	r7, r7, #2
	.loc 1 69 0
	mov	r10, #99
	.loc 1 71 0
	mov	r9, #84
	.loc 1 72 0
	mov	r8, #132
	.loc 1 68 0
	str	r7, [r5, #64]
	.loc 1 69 0
	strh	r10, [r4, #40]	@ movhi
	.loc 1 71 0
	str	r9, [r4, #44]
	.loc 1 72 0
	strh	r8, [r4]	@ movhi
	.loc 1 74 0
	strh	r6, [r4, #4]	@ movhi
	.loc 1 75 0
	strh	ip, [r4, #4]	@ movhi
	.loc 1 77 0
	ldrh	r7, [r4, #20]
	uxth	r7, r7
	orr	r7, r7, #1
	strh	r7, [r4, #20]	@ movhi
	.loc 1 78 0
	ldrh	r7, [r4]
	uxth	r7, r7
	orr	r7, r7, #1
	.loc 1 83 0
	mov	ip, #256
	.loc 1 78 0
	strh	r7, [r4]	@ movhi
	.loc 1 83 0
	str	ip, [r3, #8]
	.loc 1 84 0
	ldr	r4, [r3, #8]
	orr	r4, r4, #512
	str	r4, [r3, #8]
	.loc 1 85 0
	ldr	r4, [r3, #8]
	orr	r4, r4, #268435456
	str	r4, [r3, #8]
	.loc 1 86 0
	ldr	r4, [r3, #8]
	orr	r4, r4, #134217728
	str	r4, [r3, #8]
	.loc 1 87 0
	ldr	r4, [r3, #8]
	orr	r4, r4, #1
	str	r4, [r3, #8]
	.loc 1 91 0
	ldr	r3, [r5, #48]
	orr	r3, r3, #4194304
	str	r3, [r5, #48]
	.loc 1 94 0
	mov	r5, lr
	.loc 1 93 0
	str	r6, [lr]
.L13:
	.loc 1 94 0 discriminator 1
	ldr	r3, [r5]
	ldr	r4, .L16+16
	ands	r3, r3, #1
	bne	.L13
	.loc 1 96 0
	ldr	r5, .L16+20
	.loc 1 99 0
	ldr	r6, .L16+24
	.loc 1 96 0
	str	r3, [r5]
	.loc 1 97 0
	str	r3, [r5, #4]
	.loc 1 99 0
	str	r6, [r4, #8]
	.loc 1 100 0
	str	r0, [r4, #12]
	.loc 1 101 0
	str	r1, [r4, #16]
	.loc 1 102 0
	str	r2, [r4, #4]
	.loc 1 104 0
	ldr	r3, [r4]
	bic	r3, r3, #234881024
	str	r3, [r4]
	.loc 1 105 0
	ldr	r3, [r4]
	orr	r3, r3, #196608
	str	r3, [r4]
	.loc 1 108 0
	ldr	r3, [r4]
	orr	r3, r3, #1024
	str	r3, [r4]
	.loc 1 110 0
	ldr	r3, [r4]
	orr	r3, r3, #262144
	str	r3, [r4]
	.loc 1 111 0
	ldr	r3, [r4]
	orr	r3, r3, #2048
	str	r3, [r4]
	.loc 1 113 0
	ldr	r3, [r4]
	orr	r3, r3, #8192
	str	r3, [r4]
	.loc 1 115 0
	ldr	r3, [r4]
	bic	r3, r3, #192
	str	r3, [r4]
	.loc 1 117 0
	ldr	r3, [r4]
	orr	r3, r3, #1
	str	r3, [r4]
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L17:
	.align	2
.L16:
	.word	1073887232
	.word	1073874944
	.word	1073815552
	.word	1073742848
	.word	1073898512
	.word	1073898496
	.word	1073815628
	.word	1073816320
	.cfi_endproc
.LFE112:
	.size	initDmaADC1, .-initDmaADC1
.Letext0:
	.file 2 "/home/asmir/msut/STM32F407/gcc-arm-none-eabi/arm-none-eabi/include/machine/_default_types.h"
	.file 3 "/home/asmir/msut/STM32F407/gcc-arm-none-eabi/arm-none-eabi/include/stdint.h"
	.file 4 "../../../../STM32F407/Libraries/CMSIS/ST/STM32F4xx/Include/stm32f4xx.h"
	.file 5 "../../../../STM32F407/Libraries/CMSIS/Include/core_cm4.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x78f
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF102
	.byte	0x1
	.4byte	.LASF103
	.4byte	.LASF104
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF0
	.uleb128 0x3
	.4byte	.LASF3
	.byte	0x2
	.byte	0x1d
	.4byte	0x37
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF2
	.uleb128 0x3
	.4byte	.LASF4
	.byte	0x2
	.byte	0x2b
	.4byte	0x50
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF5
	.uleb128 0x3
	.4byte	.LASF6
	.byte	0x2
	.byte	0x3f
	.4byte	0x62
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF7
	.uleb128 0x3
	.4byte	.LASF8
	.byte	0x2
	.byte	0x41
	.4byte	0x74
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF9
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF10
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF11
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF12
	.uleb128 0x3
	.4byte	.LASF13
	.byte	0x3
	.byte	0x15
	.4byte	0x2c
	.uleb128 0x3
	.4byte	.LASF14
	.byte	0x3
	.byte	0x21
	.4byte	0x45
	.uleb128 0x3
	.4byte	.LASF15
	.byte	0x3
	.byte	0x2c
	.4byte	0x57
	.uleb128 0x3
	.4byte	.LASF16
	.byte	0x3
	.byte	0x2d
	.4byte	0x69
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF17
	.uleb128 0x5
	.4byte	0xb8
	.uleb128 0x6
	.4byte	0xb8
	.4byte	0xdf
	.uleb128 0x7
	.4byte	0xc3
	.byte	0x1
	.byte	0
	.uleb128 0x5
	.4byte	0xa2
	.uleb128 0x5
	.4byte	0xad
	.uleb128 0x8
	.byte	0x50
	.byte	0x4
	.2byte	0x130
	.4byte	0x1f5
	.uleb128 0x9
	.ascii	"SR\000"
	.byte	0x4
	.2byte	0x132
	.4byte	0xca
	.byte	0
	.uleb128 0x9
	.ascii	"CR1\000"
	.byte	0x4
	.2byte	0x133
	.4byte	0xca
	.byte	0x4
	.uleb128 0x9
	.ascii	"CR2\000"
	.byte	0x4
	.2byte	0x134
	.4byte	0xca
	.byte	0x8
	.uleb128 0xa
	.4byte	.LASF18
	.byte	0x4
	.2byte	0x135
	.4byte	0xca
	.byte	0xc
	.uleb128 0xa
	.4byte	.LASF19
	.byte	0x4
	.2byte	0x136
	.4byte	0xca
	.byte	0x10
	.uleb128 0xa
	.4byte	.LASF20
	.byte	0x4
	.2byte	0x137
	.4byte	0xca
	.byte	0x14
	.uleb128 0xa
	.4byte	.LASF21
	.byte	0x4
	.2byte	0x138
	.4byte	0xca
	.byte	0x18
	.uleb128 0xa
	.4byte	.LASF22
	.byte	0x4
	.2byte	0x139
	.4byte	0xca
	.byte	0x1c
	.uleb128 0xa
	.4byte	.LASF23
	.byte	0x4
	.2byte	0x13a
	.4byte	0xca
	.byte	0x20
	.uleb128 0x9
	.ascii	"HTR\000"
	.byte	0x4
	.2byte	0x13b
	.4byte	0xca
	.byte	0x24
	.uleb128 0x9
	.ascii	"LTR\000"
	.byte	0x4
	.2byte	0x13c
	.4byte	0xca
	.byte	0x28
	.uleb128 0xa
	.4byte	.LASF24
	.byte	0x4
	.2byte	0x13d
	.4byte	0xca
	.byte	0x2c
	.uleb128 0xa
	.4byte	.LASF25
	.byte	0x4
	.2byte	0x13e
	.4byte	0xca
	.byte	0x30
	.uleb128 0xa
	.4byte	.LASF26
	.byte	0x4
	.2byte	0x13f
	.4byte	0xca
	.byte	0x34
	.uleb128 0xa
	.4byte	.LASF27
	.byte	0x4
	.2byte	0x140
	.4byte	0xca
	.byte	0x38
	.uleb128 0xa
	.4byte	.LASF28
	.byte	0x4
	.2byte	0x141
	.4byte	0xca
	.byte	0x3c
	.uleb128 0xa
	.4byte	.LASF29
	.byte	0x4
	.2byte	0x142
	.4byte	0xca
	.byte	0x40
	.uleb128 0xa
	.4byte	.LASF30
	.byte	0x4
	.2byte	0x143
	.4byte	0xca
	.byte	0x44
	.uleb128 0xa
	.4byte	.LASF31
	.byte	0x4
	.2byte	0x144
	.4byte	0xca
	.byte	0x48
	.uleb128 0x9
	.ascii	"DR\000"
	.byte	0x4
	.2byte	0x145
	.4byte	0xca
	.byte	0x4c
	.byte	0
	.uleb128 0xb
	.4byte	.LASF32
	.byte	0x4
	.2byte	0x146
	.4byte	0xe9
	.uleb128 0x8
	.byte	0xc
	.byte	0x4
	.2byte	0x148
	.4byte	0x232
	.uleb128 0x9
	.ascii	"CSR\000"
	.byte	0x4
	.2byte	0x14a
	.4byte	0xca
	.byte	0
	.uleb128 0x9
	.ascii	"CCR\000"
	.byte	0x4
	.2byte	0x14b
	.4byte	0xca
	.byte	0x4
	.uleb128 0x9
	.ascii	"CDR\000"
	.byte	0x4
	.2byte	0x14c
	.4byte	0xca
	.byte	0x8
	.byte	0
	.uleb128 0xb
	.4byte	.LASF33
	.byte	0x4
	.2byte	0x14e
	.4byte	0x201
	.uleb128 0x8
	.byte	0x18
	.byte	0x4
	.2byte	0x1d7
	.4byte	0x295
	.uleb128 0x9
	.ascii	"CR\000"
	.byte	0x4
	.2byte	0x1d9
	.4byte	0xca
	.byte	0
	.uleb128 0xa
	.4byte	.LASF34
	.byte	0x4
	.2byte	0x1da
	.4byte	0xca
	.byte	0x4
	.uleb128 0x9
	.ascii	"PAR\000"
	.byte	0x4
	.2byte	0x1db
	.4byte	0xca
	.byte	0x8
	.uleb128 0xa
	.4byte	.LASF35
	.byte	0x4
	.2byte	0x1dc
	.4byte	0xca
	.byte	0xc
	.uleb128 0xa
	.4byte	.LASF36
	.byte	0x4
	.2byte	0x1dd
	.4byte	0xca
	.byte	0x10
	.uleb128 0x9
	.ascii	"FCR\000"
	.byte	0x4
	.2byte	0x1de
	.4byte	0xca
	.byte	0x14
	.byte	0
	.uleb128 0xb
	.4byte	.LASF37
	.byte	0x4
	.2byte	0x1df
	.4byte	0x23e
	.uleb128 0x8
	.byte	0x10
	.byte	0x4
	.2byte	0x1e1
	.4byte	0x2df
	.uleb128 0xa
	.4byte	.LASF38
	.byte	0x4
	.2byte	0x1e3
	.4byte	0xca
	.byte	0
	.uleb128 0xa
	.4byte	.LASF39
	.byte	0x4
	.2byte	0x1e4
	.4byte	0xca
	.byte	0x4
	.uleb128 0xa
	.4byte	.LASF40
	.byte	0x4
	.2byte	0x1e5
	.4byte	0xca
	.byte	0x8
	.uleb128 0xa
	.4byte	.LASF41
	.byte	0x4
	.2byte	0x1e6
	.4byte	0xca
	.byte	0xc
	.byte	0
	.uleb128 0xb
	.4byte	.LASF42
	.byte	0x4
	.2byte	0x1e7
	.4byte	0x2a1
	.uleb128 0x8
	.byte	0x28
	.byte	0x4
	.2byte	0x28e
	.4byte	0x377
	.uleb128 0xa
	.4byte	.LASF43
	.byte	0x4
	.2byte	0x290
	.4byte	0xca
	.byte	0
	.uleb128 0xa
	.4byte	.LASF44
	.byte	0x4
	.2byte	0x291
	.4byte	0xca
	.byte	0x4
	.uleb128 0xa
	.4byte	.LASF45
	.byte	0x4
	.2byte	0x292
	.4byte	0xca
	.byte	0x8
	.uleb128 0xa
	.4byte	.LASF46
	.byte	0x4
	.2byte	0x293
	.4byte	0xca
	.byte	0xc
	.uleb128 0x9
	.ascii	"IDR\000"
	.byte	0x4
	.2byte	0x294
	.4byte	0xca
	.byte	0x10
	.uleb128 0x9
	.ascii	"ODR\000"
	.byte	0x4
	.2byte	0x295
	.4byte	0xca
	.byte	0x14
	.uleb128 0xa
	.4byte	.LASF47
	.byte	0x4
	.2byte	0x296
	.4byte	0xdf
	.byte	0x18
	.uleb128 0xa
	.4byte	.LASF48
	.byte	0x4
	.2byte	0x297
	.4byte	0xdf
	.byte	0x1a
	.uleb128 0xa
	.4byte	.LASF49
	.byte	0x4
	.2byte	0x298
	.4byte	0xca
	.byte	0x1c
	.uleb128 0x9
	.ascii	"AFR\000"
	.byte	0x4
	.2byte	0x299
	.4byte	0x377
	.byte	0x20
	.byte	0
	.uleb128 0x5
	.4byte	0xcf
	.uleb128 0xb
	.4byte	.LASF50
	.byte	0x4
	.2byte	0x29a
	.4byte	0x2eb
	.uleb128 0x8
	.byte	0x88
	.byte	0x4
	.2byte	0x2dd
	.4byte	0x517
	.uleb128 0x9
	.ascii	"CR\000"
	.byte	0x4
	.2byte	0x2df
	.4byte	0xca
	.byte	0
	.uleb128 0xa
	.4byte	.LASF51
	.byte	0x4
	.2byte	0x2e0
	.4byte	0xca
	.byte	0x4
	.uleb128 0xa
	.4byte	.LASF52
	.byte	0x4
	.2byte	0x2e1
	.4byte	0xca
	.byte	0x8
	.uleb128 0x9
	.ascii	"CIR\000"
	.byte	0x4
	.2byte	0x2e2
	.4byte	0xca
	.byte	0xc
	.uleb128 0xa
	.4byte	.LASF53
	.byte	0x4
	.2byte	0x2e3
	.4byte	0xca
	.byte	0x10
	.uleb128 0xa
	.4byte	.LASF54
	.byte	0x4
	.2byte	0x2e4
	.4byte	0xca
	.byte	0x14
	.uleb128 0xa
	.4byte	.LASF55
	.byte	0x4
	.2byte	0x2e5
	.4byte	0xca
	.byte	0x18
	.uleb128 0xa
	.4byte	.LASF56
	.byte	0x4
	.2byte	0x2e6
	.4byte	0xb8
	.byte	0x1c
	.uleb128 0xa
	.4byte	.LASF57
	.byte	0x4
	.2byte	0x2e7
	.4byte	0xca
	.byte	0x20
	.uleb128 0xa
	.4byte	.LASF58
	.byte	0x4
	.2byte	0x2e8
	.4byte	0xca
	.byte	0x24
	.uleb128 0xa
	.4byte	.LASF59
	.byte	0x4
	.2byte	0x2e9
	.4byte	0xcf
	.byte	0x28
	.uleb128 0xa
	.4byte	.LASF60
	.byte	0x4
	.2byte	0x2ea
	.4byte	0xca
	.byte	0x30
	.uleb128 0xa
	.4byte	.LASF61
	.byte	0x4
	.2byte	0x2eb
	.4byte	0xca
	.byte	0x34
	.uleb128 0xa
	.4byte	.LASF62
	.byte	0x4
	.2byte	0x2ec
	.4byte	0xca
	.byte	0x38
	.uleb128 0xa
	.4byte	.LASF63
	.byte	0x4
	.2byte	0x2ed
	.4byte	0xb8
	.byte	0x3c
	.uleb128 0xa
	.4byte	.LASF64
	.byte	0x4
	.2byte	0x2ee
	.4byte	0xca
	.byte	0x40
	.uleb128 0xa
	.4byte	.LASF65
	.byte	0x4
	.2byte	0x2ef
	.4byte	0xca
	.byte	0x44
	.uleb128 0xa
	.4byte	.LASF66
	.byte	0x4
	.2byte	0x2f0
	.4byte	0xcf
	.byte	0x48
	.uleb128 0xa
	.4byte	.LASF67
	.byte	0x4
	.2byte	0x2f1
	.4byte	0xca
	.byte	0x50
	.uleb128 0xa
	.4byte	.LASF68
	.byte	0x4
	.2byte	0x2f2
	.4byte	0xca
	.byte	0x54
	.uleb128 0xa
	.4byte	.LASF69
	.byte	0x4
	.2byte	0x2f3
	.4byte	0xca
	.byte	0x58
	.uleb128 0xa
	.4byte	.LASF70
	.byte	0x4
	.2byte	0x2f4
	.4byte	0xb8
	.byte	0x5c
	.uleb128 0xa
	.4byte	.LASF71
	.byte	0x4
	.2byte	0x2f5
	.4byte	0xca
	.byte	0x60
	.uleb128 0xa
	.4byte	.LASF72
	.byte	0x4
	.2byte	0x2f6
	.4byte	0xca
	.byte	0x64
	.uleb128 0xa
	.4byte	.LASF73
	.byte	0x4
	.2byte	0x2f7
	.4byte	0xcf
	.byte	0x68
	.uleb128 0xa
	.4byte	.LASF74
	.byte	0x4
	.2byte	0x2f8
	.4byte	0xca
	.byte	0x70
	.uleb128 0x9
	.ascii	"CSR\000"
	.byte	0x4
	.2byte	0x2f9
	.4byte	0xca
	.byte	0x74
	.uleb128 0xa
	.4byte	.LASF75
	.byte	0x4
	.2byte	0x2fa
	.4byte	0xcf
	.byte	0x78
	.uleb128 0xa
	.4byte	.LASF76
	.byte	0x4
	.2byte	0x2fb
	.4byte	0xca
	.byte	0x80
	.uleb128 0xa
	.4byte	.LASF77
	.byte	0x4
	.2byte	0x2fc
	.4byte	0xca
	.byte	0x84
	.byte	0
	.uleb128 0xb
	.4byte	.LASF78
	.byte	0x4
	.2byte	0x2fd
	.4byte	0x388
	.uleb128 0x8
	.byte	0x54
	.byte	0x4
	.2byte	0x369
	.4byte	0x6ff
	.uleb128 0x9
	.ascii	"CR1\000"
	.byte	0x4
	.2byte	0x36b
	.4byte	0xdf
	.byte	0
	.uleb128 0xa
	.4byte	.LASF56
	.byte	0x4
	.2byte	0x36c
	.4byte	0xa2
	.byte	0x2
	.uleb128 0x9
	.ascii	"CR2\000"
	.byte	0x4
	.2byte	0x36d
	.4byte	0xdf
	.byte	0x4
	.uleb128 0xa
	.4byte	.LASF59
	.byte	0x4
	.2byte	0x36e
	.4byte	0xa2
	.byte	0x6
	.uleb128 0xa
	.4byte	.LASF79
	.byte	0x4
	.2byte	0x36f
	.4byte	0xdf
	.byte	0x8
	.uleb128 0xa
	.4byte	.LASF63
	.byte	0x4
	.2byte	0x370
	.4byte	0xa2
	.byte	0xa
	.uleb128 0xa
	.4byte	.LASF80
	.byte	0x4
	.2byte	0x371
	.4byte	0xdf
	.byte	0xc
	.uleb128 0xa
	.4byte	.LASF66
	.byte	0x4
	.2byte	0x372
	.4byte	0xa2
	.byte	0xe
	.uleb128 0x9
	.ascii	"SR\000"
	.byte	0x4
	.2byte	0x373
	.4byte	0xdf
	.byte	0x10
	.uleb128 0xa
	.4byte	.LASF70
	.byte	0x4
	.2byte	0x374
	.4byte	0xa2
	.byte	0x12
	.uleb128 0x9
	.ascii	"EGR\000"
	.byte	0x4
	.2byte	0x375
	.4byte	0xdf
	.byte	0x14
	.uleb128 0xa
	.4byte	.LASF73
	.byte	0x4
	.2byte	0x376
	.4byte	0xa2
	.byte	0x16
	.uleb128 0xa
	.4byte	.LASF81
	.byte	0x4
	.2byte	0x377
	.4byte	0xdf
	.byte	0x18
	.uleb128 0xa
	.4byte	.LASF75
	.byte	0x4
	.2byte	0x378
	.4byte	0xa2
	.byte	0x1a
	.uleb128 0xa
	.4byte	.LASF82
	.byte	0x4
	.2byte	0x379
	.4byte	0xdf
	.byte	0x1c
	.uleb128 0xa
	.4byte	.LASF83
	.byte	0x4
	.2byte	0x37a
	.4byte	0xa2
	.byte	0x1e
	.uleb128 0xa
	.4byte	.LASF84
	.byte	0x4
	.2byte	0x37b
	.4byte	0xdf
	.byte	0x20
	.uleb128 0xa
	.4byte	.LASF85
	.byte	0x4
	.2byte	0x37c
	.4byte	0xa2
	.byte	0x22
	.uleb128 0x9
	.ascii	"CNT\000"
	.byte	0x4
	.2byte	0x37d
	.4byte	0xca
	.byte	0x24
	.uleb128 0x9
	.ascii	"PSC\000"
	.byte	0x4
	.2byte	0x37e
	.4byte	0xdf
	.byte	0x28
	.uleb128 0xa
	.4byte	.LASF86
	.byte	0x4
	.2byte	0x37f
	.4byte	0xa2
	.byte	0x2a
	.uleb128 0x9
	.ascii	"ARR\000"
	.byte	0x4
	.2byte	0x380
	.4byte	0xca
	.byte	0x2c
	.uleb128 0x9
	.ascii	"RCR\000"
	.byte	0x4
	.2byte	0x381
	.4byte	0xdf
	.byte	0x30
	.uleb128 0xa
	.4byte	.LASF87
	.byte	0x4
	.2byte	0x382
	.4byte	0xa2
	.byte	0x32
	.uleb128 0xa
	.4byte	.LASF88
	.byte	0x4
	.2byte	0x383
	.4byte	0xca
	.byte	0x34
	.uleb128 0xa
	.4byte	.LASF89
	.byte	0x4
	.2byte	0x384
	.4byte	0xca
	.byte	0x38
	.uleb128 0xa
	.4byte	.LASF90
	.byte	0x4
	.2byte	0x385
	.4byte	0xca
	.byte	0x3c
	.uleb128 0xa
	.4byte	.LASF91
	.byte	0x4
	.2byte	0x386
	.4byte	0xca
	.byte	0x40
	.uleb128 0xa
	.4byte	.LASF92
	.byte	0x4
	.2byte	0x387
	.4byte	0xdf
	.byte	0x44
	.uleb128 0xa
	.4byte	.LASF93
	.byte	0x4
	.2byte	0x388
	.4byte	0xa2
	.byte	0x46
	.uleb128 0x9
	.ascii	"DCR\000"
	.byte	0x4
	.2byte	0x389
	.4byte	0xdf
	.byte	0x48
	.uleb128 0xa
	.4byte	.LASF94
	.byte	0x4
	.2byte	0x38a
	.4byte	0xa2
	.byte	0x4a
	.uleb128 0xa
	.4byte	.LASF95
	.byte	0x4
	.2byte	0x38b
	.4byte	0xdf
	.byte	0x4c
	.uleb128 0xa
	.4byte	.LASF96
	.byte	0x4
	.2byte	0x38c
	.4byte	0xa2
	.byte	0x4e
	.uleb128 0x9
	.ascii	"OR\000"
	.byte	0x4
	.2byte	0x38d
	.4byte	0xdf
	.byte	0x50
	.uleb128 0xa
	.4byte	.LASF97
	.byte	0x4
	.2byte	0x38e
	.4byte	0xa2
	.byte	0x52
	.byte	0
	.uleb128 0xb
	.4byte	.LASF98
	.byte	0x4
	.2byte	0x38f
	.4byte	0x523
	.uleb128 0xc
	.4byte	.LASF105
	.byte	0x1
	.byte	0x3
	.4byte	.LFB110
	.4byte	.LFE110-.LFB110
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0xd
	.4byte	.LASF106
	.byte	0x1
	.byte	0x18
	.4byte	0xa2
	.4byte	.LFB111
	.4byte	.LFE111-.LFB111
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x743
	.uleb128 0xe
	.4byte	.LASF107
	.byte	0x1
	.byte	0x1a
	.4byte	0xa2
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0xf
	.4byte	.LASF108
	.byte	0x1
	.byte	0x27
	.4byte	.LFB112
	.4byte	.LFE112-.LFB112
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x780
	.uleb128 0x10
	.4byte	.LASF99
	.byte	0x1
	.byte	0x27
	.4byte	0x780
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x10
	.4byte	.LASF100
	.byte	0x1
	.byte	0x27
	.4byte	0x780
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x10
	.4byte	.LASF101
	.byte	0x1
	.byte	0x27
	.4byte	0xa2
	.uleb128 0x1
	.byte	0x52
	.byte	0
	.uleb128 0x11
	.byte	0x4
	.4byte	0xa2
	.uleb128 0x12
	.4byte	.LASF109
	.byte	0x5
	.2byte	0x51b
	.4byte	0xe4
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF24:
	.ascii	"SQR1\000"
.LASF25:
	.ascii	"SQR2\000"
.LASF26:
	.ascii	"SQR3\000"
.LASF64:
	.ascii	"APB1ENR\000"
.LASF72:
	.ascii	"APB2LPENR\000"
.LASF58:
	.ascii	"APB2RSTR\000"
.LASF104:
	.ascii	"/home/asmir/msut/STM32F407/examples/pred-04/adc-dma"
	.ascii	"-matlab\000"
.LASF12:
	.ascii	"unsigned int\000"
.LASF74:
	.ascii	"BDCR\000"
.LASF6:
	.ascii	"__int32_t\000"
.LASF34:
	.ascii	"NDTR\000"
.LASF68:
	.ascii	"AHB2LPENR\000"
.LASF98:
	.ascii	"TIM_TypeDef\000"
.LASF16:
	.ascii	"uint32_t\000"
.LASF92:
	.ascii	"BDTR\000"
.LASF41:
	.ascii	"HIFCR\000"
.LASF103:
	.ascii	"adc.c\000"
.LASF60:
	.ascii	"AHB1ENR\000"
.LASF88:
	.ascii	"CCR1\000"
.LASF76:
	.ascii	"SSCGR\000"
.LASF90:
	.ascii	"CCR3\000"
.LASF91:
	.ascii	"CCR4\000"
.LASF81:
	.ascii	"CCMR1\000"
.LASF82:
	.ascii	"CCMR2\000"
.LASF11:
	.ascii	"long long unsigned int\000"
.LASF4:
	.ascii	"__uint16_t\000"
.LASF43:
	.ascii	"MODER\000"
.LASF55:
	.ascii	"AHB3RSTR\000"
.LASF107:
	.ascii	"r_val\000"
.LASF78:
	.ascii	"RCC_TypeDef\000"
.LASF80:
	.ascii	"DIER\000"
.LASF35:
	.ascii	"M0AR\000"
.LASF62:
	.ascii	"AHB3ENR\000"
.LASF46:
	.ascii	"PUPDR\000"
.LASF57:
	.ascii	"APB1RSTR\000"
.LASF84:
	.ascii	"CCER\000"
.LASF13:
	.ascii	"uint8_t\000"
.LASF79:
	.ascii	"SMCR\000"
.LASF32:
	.ascii	"ADC_TypeDef\000"
.LASF10:
	.ascii	"long long int\000"
.LASF71:
	.ascii	"APB1LPENR\000"
.LASF42:
	.ascii	"DMA_TypeDef\000"
.LASF102:
	.ascii	"GNU C 4.9.3 20141119 (release) [ARM/embedded-4_9-br"
	.ascii	"anch revision 218278] -mlittle-endian -mthumb -mcpu"
	.ascii	"=cortex-m4 -mthumb-interwork -mfloat-abi=hard -mfpu"
	.ascii	"=fpv4-sp-d16 -g -O2 -fsingle-precision-constant\000"
.LASF106:
	.ascii	"getADC1\000"
.LASF37:
	.ascii	"DMA_Stream_TypeDef\000"
.LASF101:
	.ascii	"size\000"
.LASF27:
	.ascii	"JSQR\000"
.LASF39:
	.ascii	"HISR\000"
.LASF65:
	.ascii	"APB2ENR\000"
.LASF18:
	.ascii	"SMPR1\000"
.LASF19:
	.ascii	"SMPR2\000"
.LASF45:
	.ascii	"OSPEEDR\000"
.LASF14:
	.ascii	"uint16_t\000"
.LASF54:
	.ascii	"AHB2RSTR\000"
.LASF28:
	.ascii	"JDR1\000"
.LASF29:
	.ascii	"JDR2\000"
.LASF30:
	.ascii	"JDR3\000"
.LASF31:
	.ascii	"JDR4\000"
.LASF56:
	.ascii	"RESERVED0\000"
.LASF59:
	.ascii	"RESERVED1\000"
.LASF63:
	.ascii	"RESERVED2\000"
.LASF66:
	.ascii	"RESERVED3\000"
.LASF70:
	.ascii	"RESERVED4\000"
.LASF73:
	.ascii	"RESERVED5\000"
.LASF75:
	.ascii	"RESERVED6\000"
.LASF2:
	.ascii	"short int\000"
.LASF33:
	.ascii	"ADC_Common_TypeDef\000"
.LASF86:
	.ascii	"RESERVED9\000"
.LASF7:
	.ascii	"long int\000"
.LASF95:
	.ascii	"DMAR\000"
.LASF109:
	.ascii	"ITM_RxBuffer\000"
.LASF77:
	.ascii	"PLLI2SCFGR\000"
.LASF44:
	.ascii	"OTYPER\000"
.LASF52:
	.ascii	"CFGR\000"
.LASF3:
	.ascii	"__uint8_t\000"
.LASF51:
	.ascii	"PLLCFGR\000"
.LASF50:
	.ascii	"GPIO_TypeDef\000"
.LASF36:
	.ascii	"M1AR\000"
.LASF99:
	.ascii	"dBuff1\000"
.LASF100:
	.ascii	"dBuff2\000"
.LASF69:
	.ascii	"AHB3LPENR\000"
.LASF17:
	.ascii	"sizetype\000"
.LASF9:
	.ascii	"long unsigned int\000"
.LASF61:
	.ascii	"AHB2ENR\000"
.LASF15:
	.ascii	"int32_t\000"
.LASF48:
	.ascii	"BSRRH\000"
.LASF47:
	.ascii	"BSRRL\000"
.LASF40:
	.ascii	"LIFCR\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF8:
	.ascii	"__uint32_t\000"
.LASF89:
	.ascii	"CCR2\000"
.LASF87:
	.ascii	"RESERVED10\000"
.LASF93:
	.ascii	"RESERVED11\000"
.LASF94:
	.ascii	"RESERVED12\000"
.LASF96:
	.ascii	"RESERVED13\000"
.LASF97:
	.ascii	"RESERVED14\000"
.LASF67:
	.ascii	"AHB1LPENR\000"
.LASF38:
	.ascii	"LISR\000"
.LASF0:
	.ascii	"signed char\000"
.LASF5:
	.ascii	"short unsigned int\000"
.LASF108:
	.ascii	"initDmaADC1\000"
.LASF20:
	.ascii	"JOFR1\000"
.LASF21:
	.ascii	"JOFR2\000"
.LASF22:
	.ascii	"JOFR3\000"
.LASF23:
	.ascii	"JOFR4\000"
.LASF105:
	.ascii	"initADC1\000"
.LASF83:
	.ascii	"RESERVED7\000"
.LASF85:
	.ascii	"RESERVED8\000"
.LASF53:
	.ascii	"AHB1RSTR\000"
.LASF49:
	.ascii	"LCKR\000"
	.ident	"GCC: (GNU Tools for ARM Embedded Processors) 4.9.3 20141119 (release) [ARM/embedded-4_9-branch revision 218278]"
