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
	.file	"main.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.global	initLED
	.thumb
	.thumb_func
	.type	initLED, %function
initLED:
.LFB111:
	.file 1 "main.c"
	.loc 1 54 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 58 0
	ldr	r1, .L2
	.loc 1 59 0
	ldr	r3, .L2+4
	.loc 1 58 0
	ldr	r2, [r1, #48]
	orr	r2, r2, #8
	str	r2, [r1, #48]
	.loc 1 59 0
	ldr	r2, [r3]
	orr	r2, r2, #1426063360
	str	r2, [r3]
	.loc 1 60 0
	ldr	r2, [r3, #4]
	str	r2, [r3, #4]
	.loc 1 61 0
	ldr	r2, [r3, #8]
	orr	r2, r2, #-16777216
	str	r2, [r3, #8]
	.loc 1 63 0
	ldr	r2, [r3, #20]
	ubfx	r2, r2, #0, #12
	str	r2, [r3, #20]
	bx	lr
.L3:
	.align	2
.L2:
	.word	1073887232
	.word	1073875968
	.cfi_endproc
.LFE111:
	.size	initLED, .-initLED
	.align	2
	.global	blinkLED
	.thumb
	.thumb_func
	.type	blinkLED, %function
blinkLED:
.LFB112:
	.loc 1 67 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 68 0
	ldr	r3, .L6
	.loc 1 69 0
	ldr	r2, .L6+4
	.loc 1 68 0
	ldr	r1, [r3, #20]
	.loc 1 69 0
	ldr	r0, .L6+8
	.loc 1 68 0
	ubfx	r1, r1, #0, #12
	str	r1, [r3, #20]
	.loc 1 69 0
	ldrb	r1, [r2]	@ zero_extendqisi2
	uxtb	r1, r1
	ldrh	r1, [r0, r1, lsl #1]
	ldr	r0, [r3, #20]
	uxth	r1, r1
	orrs	r1, r1, r0
	str	r1, [r3, #20]
	.loc 1 70 0
	ldrb	r3, [r2]	@ zero_extendqisi2
	adds	r3, r3, #1
	uxtb	r3, r3
	strb	r3, [r2]
	.loc 1 71 0
	ldrb	r3, [r2]	@ zero_extendqisi2
	cmp	r3, #8
	.loc 1 72 0
	itt	eq
	moveq	r3, #0
	strbeq	r3, [r2]
	bx	lr
.L7:
	.align	2
.L6:
	.word	1073875968
	.word	g_led_k
	.word	.LANCHOR0
	.cfi_endproc
.LFE112:
	.size	blinkLED, .-blinkLED
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.thumb
	.thumb_func
	.type	main, %function
main:
.LFB110:
	.loc 1 15 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 4000
	@ frame_needed = 0, uses_anonymous_args = 0
.LVL0:
	push	{r4, r5, r6, r7, r8, lr}
	.cfi_def_cfa_offset 24
	.cfi_offset 4, -24
	.cfi_offset 5, -20
	.cfi_offset 6, -16
	.cfi_offset 7, -12
	.cfi_offset 8, -8
	.cfi_offset 14, -4
	sub	sp, sp, #4000
	.cfi_def_cfa_offset 4024
	.loc 1 22 0
	bl	initLED
.LVL1:
.LBB2:
	.loc 1 29 0
	ldr	r8, .L21
.LBE2:
	.loc 1 23 0
	movs	r0, #45
	bl	initUSART2
.LVL2:
	.loc 1 24 0
	mov	r0, sp
	add	r1, sp, #2000
	mov	r2, #1000
	bl	initDmaADC1
.LVL3:
.LBB3:
	.loc 1 28 0
	bl	getcharUSART2
.LVL4:
	.loc 1 29 0
	ldr	r3, [r8]
	lsls	r3, r3, #12
	add	r7, sp, #198
	addw	r6, sp, #2198
	bpl	.L9
.LVL5:
.L19:
	sub	r4, sp, #2
.L10:
	.loc 1 34 0 discriminator 3
	ldrh	r5, [r4, #2]!
.LVL6:
	.loc 1 35 0 discriminator 3
	lsrs	r0, r5, #8
	bl	putcharUSART2
.LVL7:
	.loc 1 36 0 discriminator 3
	uxtb	r0, r5
	bl	putcharUSART2
.LVL8:
	.loc 1 32 0 discriminator 3
	cmp	r4, r7
	bne	.L10
	.loc 1 49 0
	bl	blinkLED
.LVL9:
.L20:
	.loc 1 28 0
	bl	getcharUSART2
.LVL10:
	.loc 1 29 0
	ldr	r3, [r8]
	lsls	r3, r3, #12
	bmi	.L19
.LVL11:
.L9:
	addw	r4, sp, #1998
.L12:
	.loc 1 44 0 discriminator 3
	ldrh	r5, [r4, #2]!
.LVL12:
	.loc 1 45 0 discriminator 3
	lsrs	r0, r5, #8
	bl	putcharUSART2
.LVL13:
	.loc 1 46 0 discriminator 3
	uxtb	r0, r5
	bl	putcharUSART2
.LVL14:
	.loc 1 42 0 discriminator 3
	cmp	r4, r6
	bne	.L12
	.loc 1 49 0
	bl	blinkLED
.LVL15:
	b	.L20
.L22:
	.align	2
.L21:
	.word	1073898512
.LBE3:
	.cfi_endproc
.LFE110:
	.size	main, .-main
	.comm	g_led_k,1,1
	.global	g_led_state
	.data
	.align	2
	.set	.LANCHOR0,. + 0
	.type	g_led_state, %object
	.size	g_led_state, 16
g_led_state:
	.short	-4096
	.short	-8192
	.short	-16384
	.short	-32768
	.short	0
	.short	4096
	.short	12288
	.short	28672
	.text
.Letext0:
	.file 2 "/home/asmir/msut/STM32F407/gcc-arm-none-eabi/arm-none-eabi/include/machine/_default_types.h"
	.file 3 "/home/asmir/msut/STM32F407/gcc-arm-none-eabi/arm-none-eabi/include/stdint.h"
	.file 4 "../../../../STM32F407/Libraries/CMSIS/ST/STM32F4xx/Include/stm32f4xx.h"
	.file 5 "../../../../STM32F407/Libraries/CMSIS/Include/core_cm4.h"
	.file 6 "usart.h"
	.file 7 "adc.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x597
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF72
	.byte	0x1
	.4byte	.LASF73
	.4byte	.LASF74
	.4byte	.Ldebug_ranges0+0x18
	.4byte	0
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
	.4byte	0x97
	.uleb128 0x5
	.4byte	0xa2
	.uleb128 0x5
	.4byte	0xad
	.uleb128 0x8
	.byte	0x18
	.byte	0x4
	.2byte	0x1d7
	.4byte	0x145
	.uleb128 0x9
	.ascii	"CR\000"
	.byte	0x4
	.2byte	0x1d9
	.4byte	0xca
	.byte	0
	.uleb128 0xa
	.4byte	.LASF18
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
	.4byte	.LASF19
	.byte	0x4
	.2byte	0x1dc
	.4byte	0xca
	.byte	0xc
	.uleb128 0xa
	.4byte	.LASF20
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
	.4byte	.LASF21
	.byte	0x4
	.2byte	0x1df
	.4byte	0xee
	.uleb128 0x8
	.byte	0x28
	.byte	0x4
	.2byte	0x28e
	.4byte	0x1dd
	.uleb128 0xa
	.4byte	.LASF22
	.byte	0x4
	.2byte	0x290
	.4byte	0xca
	.byte	0
	.uleb128 0xa
	.4byte	.LASF23
	.byte	0x4
	.2byte	0x291
	.4byte	0xca
	.byte	0x4
	.uleb128 0xa
	.4byte	.LASF24
	.byte	0x4
	.2byte	0x292
	.4byte	0xca
	.byte	0x8
	.uleb128 0xa
	.4byte	.LASF25
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
	.4byte	.LASF26
	.byte	0x4
	.2byte	0x296
	.4byte	0xe4
	.byte	0x18
	.uleb128 0xa
	.4byte	.LASF27
	.byte	0x4
	.2byte	0x297
	.4byte	0xe4
	.byte	0x1a
	.uleb128 0xa
	.4byte	.LASF28
	.byte	0x4
	.2byte	0x298
	.4byte	0xca
	.byte	0x1c
	.uleb128 0x9
	.ascii	"AFR\000"
	.byte	0x4
	.2byte	0x299
	.4byte	0x1dd
	.byte	0x20
	.byte	0
	.uleb128 0x5
	.4byte	0xcf
	.uleb128 0xb
	.4byte	.LASF29
	.byte	0x4
	.2byte	0x29a
	.4byte	0x151
	.uleb128 0x8
	.byte	0x88
	.byte	0x4
	.2byte	0x2dd
	.4byte	0x37d
	.uleb128 0x9
	.ascii	"CR\000"
	.byte	0x4
	.2byte	0x2df
	.4byte	0xca
	.byte	0
	.uleb128 0xa
	.4byte	.LASF30
	.byte	0x4
	.2byte	0x2e0
	.4byte	0xca
	.byte	0x4
	.uleb128 0xa
	.4byte	.LASF31
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
	.4byte	.LASF32
	.byte	0x4
	.2byte	0x2e3
	.4byte	0xca
	.byte	0x10
	.uleb128 0xa
	.4byte	.LASF33
	.byte	0x4
	.2byte	0x2e4
	.4byte	0xca
	.byte	0x14
	.uleb128 0xa
	.4byte	.LASF34
	.byte	0x4
	.2byte	0x2e5
	.4byte	0xca
	.byte	0x18
	.uleb128 0xa
	.4byte	.LASF35
	.byte	0x4
	.2byte	0x2e6
	.4byte	0xb8
	.byte	0x1c
	.uleb128 0xa
	.4byte	.LASF36
	.byte	0x4
	.2byte	0x2e7
	.4byte	0xca
	.byte	0x20
	.uleb128 0xa
	.4byte	.LASF37
	.byte	0x4
	.2byte	0x2e8
	.4byte	0xca
	.byte	0x24
	.uleb128 0xa
	.4byte	.LASF38
	.byte	0x4
	.2byte	0x2e9
	.4byte	0xcf
	.byte	0x28
	.uleb128 0xa
	.4byte	.LASF39
	.byte	0x4
	.2byte	0x2ea
	.4byte	0xca
	.byte	0x30
	.uleb128 0xa
	.4byte	.LASF40
	.byte	0x4
	.2byte	0x2eb
	.4byte	0xca
	.byte	0x34
	.uleb128 0xa
	.4byte	.LASF41
	.byte	0x4
	.2byte	0x2ec
	.4byte	0xca
	.byte	0x38
	.uleb128 0xa
	.4byte	.LASF42
	.byte	0x4
	.2byte	0x2ed
	.4byte	0xb8
	.byte	0x3c
	.uleb128 0xa
	.4byte	.LASF43
	.byte	0x4
	.2byte	0x2ee
	.4byte	0xca
	.byte	0x40
	.uleb128 0xa
	.4byte	.LASF44
	.byte	0x4
	.2byte	0x2ef
	.4byte	0xca
	.byte	0x44
	.uleb128 0xa
	.4byte	.LASF45
	.byte	0x4
	.2byte	0x2f0
	.4byte	0xcf
	.byte	0x48
	.uleb128 0xa
	.4byte	.LASF46
	.byte	0x4
	.2byte	0x2f1
	.4byte	0xca
	.byte	0x50
	.uleb128 0xa
	.4byte	.LASF47
	.byte	0x4
	.2byte	0x2f2
	.4byte	0xca
	.byte	0x54
	.uleb128 0xa
	.4byte	.LASF48
	.byte	0x4
	.2byte	0x2f3
	.4byte	0xca
	.byte	0x58
	.uleb128 0xa
	.4byte	.LASF49
	.byte	0x4
	.2byte	0x2f4
	.4byte	0xb8
	.byte	0x5c
	.uleb128 0xa
	.4byte	.LASF50
	.byte	0x4
	.2byte	0x2f5
	.4byte	0xca
	.byte	0x60
	.uleb128 0xa
	.4byte	.LASF51
	.byte	0x4
	.2byte	0x2f6
	.4byte	0xca
	.byte	0x64
	.uleb128 0xa
	.4byte	.LASF52
	.byte	0x4
	.2byte	0x2f7
	.4byte	0xcf
	.byte	0x68
	.uleb128 0xa
	.4byte	.LASF53
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
	.4byte	.LASF54
	.byte	0x4
	.2byte	0x2fa
	.4byte	0xcf
	.byte	0x78
	.uleb128 0xa
	.4byte	.LASF55
	.byte	0x4
	.2byte	0x2fb
	.4byte	0xca
	.byte	0x80
	.uleb128 0xa
	.4byte	.LASF56
	.byte	0x4
	.2byte	0x2fc
	.4byte	0xca
	.byte	0x84
	.byte	0
	.uleb128 0xb
	.4byte	.LASF57
	.byte	0x4
	.2byte	0x2fd
	.4byte	0x1ee
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF58
	.uleb128 0xc
	.4byte	.LASF59
	.byte	0x1
	.byte	0x35
	.4byte	.LFB111
	.4byte	.LFE111-.LFB111
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0xc
	.4byte	.LASF60
	.byte	0x1
	.byte	0x42
	.4byte	.LFB112
	.4byte	.LFE112-.LFB112
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0xd
	.4byte	.LASF75
	.byte	0x1
	.byte	0xe
	.4byte	0x89
	.4byte	.LFB110
	.4byte	.LFE110-.LFB110
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x4f2
	.uleb128 0xe
	.4byte	.LASF61
	.byte	0x1
	.byte	0x10
	.4byte	0xb8
	.uleb128 0xf
	.ascii	"k\000"
	.byte	0x1
	.byte	0x10
	.4byte	0xb8
	.4byte	.LLST0
	.uleb128 0x10
	.ascii	"n\000"
	.byte	0x1
	.byte	0x11
	.4byte	0x97
	.byte	0
	.uleb128 0x11
	.ascii	"c\000"
	.byte	0x1
	.byte	0x11
	.4byte	0x97
	.uleb128 0x12
	.4byte	.LASF62
	.byte	0x1
	.byte	0x12
	.4byte	0xa2
	.4byte	.LLST1
	.uleb128 0x13
	.4byte	.LASF63
	.byte	0x1
	.byte	0x13
	.4byte	0x4f2
	.uleb128 0x3
	.byte	0x91
	.sleb128 -4024
	.uleb128 0x13
	.4byte	.LASF64
	.byte	0x1
	.byte	0x14
	.4byte	0x4f2
	.uleb128 0x3
	.byte	0x91
	.sleb128 -2024
	.uleb128 0x14
	.4byte	.Ldebug_ranges0+0
	.4byte	0x4b6
	.uleb128 0x15
	.4byte	.LASF68
	.byte	0x1
	.byte	0x1c
	.4byte	0x89
	.4byte	0x43d
	.uleb128 0x16
	.byte	0
	.uleb128 0x17
	.4byte	.LVL4
	.4byte	0x546
	.uleb128 0x18
	.4byte	.LVL7
	.4byte	0x557
	.4byte	0x45c
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x4
	.byte	0x75
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0
	.uleb128 0x18
	.4byte	.LVL8
	.4byte	0x557
	.4byte	0x470
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x75
	.sleb128 0
	.byte	0
	.uleb128 0x17
	.4byte	.LVL9
	.4byte	0x3a1
	.uleb128 0x17
	.4byte	.LVL10
	.4byte	0x546
	.uleb128 0x18
	.4byte	.LVL13
	.4byte	0x557
	.4byte	0x498
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x4
	.byte	0x75
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0
	.uleb128 0x18
	.4byte	.LVL14
	.4byte	0x557
	.4byte	0x4ac
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x75
	.sleb128 0
	.byte	0
	.uleb128 0x17
	.4byte	.LVL15
	.4byte	0x3a1
	.byte	0
	.uleb128 0x17
	.4byte	.LVL1
	.4byte	0x390
	.uleb128 0x18
	.4byte	.LVL2
	.4byte	0x568
	.4byte	0x4d3
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x8
	.byte	0x2d
	.byte	0
	.uleb128 0x1a
	.4byte	.LVL3
	.4byte	0x579
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3
	.byte	0xa
	.2byte	0x3e8
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0x91
	.sleb128 -2024
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0x6
	.4byte	0xa2
	.4byte	0x503
	.uleb128 0x1b
	.4byte	0xc3
	.2byte	0x3e7
	.byte	0
	.uleb128 0x1c
	.4byte	.LASF65
	.byte	0x5
	.2byte	0x51b
	.4byte	0xe9
	.uleb128 0x6
	.4byte	0xa2
	.4byte	0x51f
	.uleb128 0x7
	.4byte	0xc3
	.byte	0x7
	.byte	0
	.uleb128 0x1d
	.4byte	.LASF66
	.byte	0x1
	.byte	0xa
	.4byte	0x530
	.uleb128 0x5
	.byte	0x3
	.4byte	g_led_state
	.uleb128 0x5
	.4byte	0x50f
	.uleb128 0x1d
	.4byte	.LASF67
	.byte	0x1
	.byte	0xb
	.4byte	0xdf
	.uleb128 0x5
	.byte	0x3
	.4byte	g_led_k
	.uleb128 0x15
	.4byte	.LASF68
	.byte	0x1
	.byte	0x1c
	.4byte	0x89
	.4byte	0x557
	.uleb128 0x16
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF69
	.byte	0x6
	.byte	0xf
	.4byte	0x568
	.uleb128 0x1f
	.4byte	0x97
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF70
	.byte	0x6
	.byte	0xe
	.4byte	0x579
	.uleb128 0x1f
	.4byte	0xb8
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF71
	.byte	0x7
	.byte	0x8
	.4byte	0x594
	.uleb128 0x1f
	.4byte	0x594
	.uleb128 0x1f
	.4byte	0x594
	.uleb128 0x1f
	.4byte	0xa2
	.byte	0
	.uleb128 0x20
	.byte	0x4
	.4byte	0xa2
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
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
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
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
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
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x13
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
	.uleb128 0x14
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
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
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x1c
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
	.uleb128 0x1d
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
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1e
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
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",%progbits
.Ldebug_loc0:
.LLST0:
	.4byte	.LVL0
	.4byte	.LVL5
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL6
	.4byte	.LVL11
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL12
	.4byte	.LFE110
	.2byte	0x1
	.byte	0x55
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.LFB110
	.4byte	.LFE110-.LFB110
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",%progbits
.Ldebug_ranges0:
	.4byte	.LBB2
	.4byte	.LBE2
	.4byte	.LBB3
	.4byte	.LBE3
	.4byte	0
	.4byte	0
	.4byte	.Ltext0
	.4byte	.Letext0
	.4byte	.LFB110
	.4byte	.LFE110
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF46:
	.ascii	"AHB1LPENR\000"
.LASF24:
	.ascii	"OSPEEDR\000"
.LASF36:
	.ascii	"APB1RSTR\000"
.LASF40:
	.ascii	"AHB2ENR\000"
.LASF21:
	.ascii	"DMA_Stream_TypeDef\000"
.LASF2:
	.ascii	"short int\000"
.LASF74:
	.ascii	"/home/asmir/msut/STM32F407/examples/pred-04/adc-dma"
	.ascii	"-matlab\000"
.LASF17:
	.ascii	"sizetype\000"
.LASF53:
	.ascii	"BDCR\000"
.LASF71:
	.ascii	"initDmaADC1\000"
.LASF56:
	.ascii	"PLLI2SCFGR\000"
.LASF75:
	.ascii	"main\000"
.LASF8:
	.ascii	"__uint32_t\000"
.LASF4:
	.ascii	"__uint16_t\000"
.LASF55:
	.ascii	"SSCGR\000"
.LASF32:
	.ascii	"AHB1RSTR\000"
.LASF31:
	.ascii	"CFGR\000"
.LASF48:
	.ascii	"AHB3LPENR\000"
.LASF13:
	.ascii	"uint8_t\000"
.LASF43:
	.ascii	"APB1ENR\000"
.LASF72:
	.ascii	"GNU C 4.9.3 20141119 (release) [ARM/embedded-4_9-br"
	.ascii	"anch revision 218278] -mlittle-endian -mthumb -mcpu"
	.ascii	"=cortex-m4 -mthumb-interwork -mfloat-abi=hard -mfpu"
	.ascii	"=fpv4-sp-d16 -g -O2 -fsingle-precision-constant\000"
.LASF23:
	.ascii	"OTYPER\000"
.LASF41:
	.ascii	"AHB3ENR\000"
.LASF10:
	.ascii	"long long int\000"
.LASF25:
	.ascii	"PUPDR\000"
.LASF7:
	.ascii	"long int\000"
.LASF70:
	.ascii	"initUSART2\000"
.LASF57:
	.ascii	"RCC_TypeDef\000"
.LASF27:
	.ascii	"BSRRH\000"
.LASF22:
	.ascii	"MODER\000"
.LASF37:
	.ascii	"APB2RSTR\000"
.LASF3:
	.ascii	"__uint8_t\000"
.LASF60:
	.ascii	"blinkLED\000"
.LASF69:
	.ascii	"putcharUSART2\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF59:
	.ascii	"initLED\000"
.LASF44:
	.ascii	"APB2ENR\000"
.LASF0:
	.ascii	"signed char\000"
.LASF11:
	.ascii	"long long unsigned int\000"
.LASF16:
	.ascii	"uint32_t\000"
.LASF12:
	.ascii	"unsigned int\000"
.LASF33:
	.ascii	"AHB2RSTR\000"
.LASF67:
	.ascii	"g_led_k\000"
.LASF68:
	.ascii	"getcharUSART2\000"
.LASF9:
	.ascii	"long unsigned int\000"
.LASF66:
	.ascii	"g_led_state\000"
.LASF30:
	.ascii	"PLLCFGR\000"
.LASF5:
	.ascii	"short unsigned int\000"
.LASF50:
	.ascii	"APB1LPENR\000"
.LASF20:
	.ascii	"M1AR\000"
.LASF58:
	.ascii	"char\000"
.LASF14:
	.ascii	"uint16_t\000"
.LASF15:
	.ascii	"int32_t\000"
.LASF19:
	.ascii	"M0AR\000"
.LASF47:
	.ascii	"AHB2LPENR\000"
.LASF35:
	.ascii	"RESERVED0\000"
.LASF38:
	.ascii	"RESERVED1\000"
.LASF42:
	.ascii	"RESERVED2\000"
.LASF45:
	.ascii	"RESERVED3\000"
.LASF49:
	.ascii	"RESERVED4\000"
.LASF52:
	.ascii	"RESERVED5\000"
.LASF54:
	.ascii	"RESERVED6\000"
.LASF18:
	.ascii	"NDTR\000"
.LASF65:
	.ascii	"ITM_RxBuffer\000"
.LASF39:
	.ascii	"AHB1ENR\000"
.LASF61:
	.ascii	"utmp32\000"
.LASF6:
	.ascii	"__int32_t\000"
.LASF63:
	.ascii	"adc_buff0\000"
.LASF64:
	.ascii	"adc_buff1\000"
.LASF29:
	.ascii	"GPIO_TypeDef\000"
.LASF34:
	.ascii	"AHB3RSTR\000"
.LASF73:
	.ascii	"main.c\000"
.LASF26:
	.ascii	"BSRRL\000"
.LASF62:
	.ascii	"utmp16\000"
.LASF28:
	.ascii	"LCKR\000"
.LASF51:
	.ascii	"APB2LPENR\000"
	.ident	"GCC: (GNU Tools for ARM Embedded Processors) 4.9.3 20141119 (release) [ARM/embedded-4_9-branch revision 218278]"
