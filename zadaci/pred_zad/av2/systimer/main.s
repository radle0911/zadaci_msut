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
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.thumb
	.thumb_func
	.type	main, %function
main:
.LFB110:
	.file 1 "main.c"
	.loc 1 6 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
.LVL0:
	push	{r3, r4, r5, lr}
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.cfi_offset 4, -12
	.cfi_offset 5, -8
	.cfi_offset 14, -4
	.loc 1 9 0
	mov	r0, #364
	bl	initUSART2
.LVL1:
	.loc 1 10 0
	ldr	r0, .L8
	bl	printUSART2
.LVL2:
	.loc 1 11 0
	ldr	r0, .L8+4
	bl	printUSART2
.LVL3:
	.loc 1 12 0
	ldr	r0, .L8
	bl	printUSART2
.LVL4:
	.loc 1 14 0
	bl	initSTOPWATCH
.LVL5:
	.loc 1 15 0
	bl	initSYSTIMER
.LVL6:
	.loc 1 7 0
	movs	r5, #0
.LVL7:
.L3:
	.loc 1 19 0
	mov	r1, r5
	ldr	r0, .L8+8
	bl	printUSART2
.LVL8:
	.loc 1 22 0
	bl	startSTOPWATCH
.LVL9:
	.loc 1 23 0
	movs	r0, #100
	bl	delay_ms
.LVL10:
	.loc 1 24 0
	movs	r0, #100
	bl	delay_ms
.LVL11:
	.loc 1 25 0
	bl	stopSTOPWATCH
.LVL12:
	mov	r1, r0
	.loc 1 26 0
	ldr	r0, .L8+12
	bl	printUSART2
.LVL13:
	.loc 1 28 0
	bl	getSYSTIMER
.LVL14:
	.loc 1 20 0
	adds	r5, r5, #1
.LVL15:
	.loc 1 28 0
	mov	r4, r0
.LVL16:
.L2:
	.loc 1 29 0 discriminator 1
	mov	r0, r4
	ldr	r1, .L8+16
	bl	chk4TimeoutSYSTIMER
.LVL17:
	cmp	r0, #1
	beq	.L2
	.loc 1 30 0
	bl	getSYSTIMER
.LVL18:
	subs	r1, r0, r4
.LVL19:
	.loc 1 31 0
	ldr	r0, .L8+20
	bl	printUSART2
.LVL20:
	.loc 1 33 0
	mov	r0, #1000
	bl	delay_ms
.LVL21:
	.loc 1 34 0
	b	.L3
.L9:
	.align	2
.L8:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	100000
	.word	.LC4
	.cfi_endproc
.LFE110:
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"\012wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"
	.ascii	"wwwwww\012\000"
.LC1:
	.ascii	"w Starting stopWATCH() test app...\012\000"
.LC2:
	.ascii	"-> SW: test [%d]\012\000"
	.space	2
.LC3:
	.ascii	"     -> [100 ms] with delay_ms: [%d] us\012\000"
	.space	3
.LC4:
	.ascii	"     -> [100 ms] with systimer: [%d] us\012\000"
	.text
.Letext0:
	.file 2 "/home/semir/Dropbox/Fakultet/2019/MSUT/STM32F407/gcc-arm-none-eabi/arm-none-eabi/include/machine/_default_types.h"
	.file 3 "/home/semir/Dropbox/Fakultet/2019/MSUT/STM32F407/gcc-arm-none-eabi/arm-none-eabi/include/stdint.h"
	.file 4 "usart.h"
	.file 5 "delay.h"
	.file 6 "../../../../STM32F407/Libraries/CMSIS/Include/core_cm4.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x2ad
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF27
	.byte	0x1
	.4byte	.LASF28
	.4byte	.LASF29
	.4byte	.Ldebug_ranges0+0
	.4byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF0
	.uleb128 0x3
	.4byte	.LASF4
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
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x3
	.4byte	.LASF5
	.byte	0x2
	.byte	0x3f
	.4byte	0x57
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF6
	.uleb128 0x3
	.4byte	.LASF7
	.byte	0x2
	.byte	0x41
	.4byte	0x69
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF9
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF10
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF11
	.uleb128 0x3
	.4byte	.LASF12
	.byte	0x3
	.byte	0x15
	.4byte	0x2c
	.uleb128 0x3
	.4byte	.LASF13
	.byte	0x3
	.byte	0x2c
	.4byte	0x4c
	.uleb128 0x3
	.4byte	.LASF14
	.byte	0x3
	.byte	0x2d
	.4byte	0x5e
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF15
	.uleb128 0x5
	.4byte	0x97
	.uleb128 0x6
	.byte	0x4
	.4byte	0xbf
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF16
	.uleb128 0x7
	.4byte	.LASF30
	.byte	0x1
	.byte	0x5
	.4byte	0x7e
	.4byte	.LFB110
	.4byte	.LFE110-.LFB110
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x22f
	.uleb128 0x8
	.ascii	"cnt\000"
	.byte	0x1
	.byte	0x7
	.4byte	0xa2
	.4byte	.LLST0
	.uleb128 0x9
	.4byte	.LASF17
	.byte	0x1
	.byte	0x7
	.4byte	0xa2
	.4byte	.LLST1
	.uleb128 0xa
	.4byte	.LVL1
	.4byte	0x23b
	.4byte	0x112
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x3
	.byte	0xa
	.2byte	0x16c
	.byte	0
	.uleb128 0xa
	.4byte	.LVL2
	.4byte	0x24c
	.4byte	0x129
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.byte	0
	.uleb128 0xa
	.4byte	.LVL3
	.4byte	0x24c
	.4byte	0x140
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC1
	.byte	0
	.uleb128 0xa
	.4byte	.LVL4
	.4byte	0x24c
	.4byte	0x157
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.byte	0
	.uleb128 0xc
	.4byte	.LVL5
	.4byte	0x25e
	.uleb128 0xc
	.4byte	.LVL6
	.4byte	0x265
	.uleb128 0xa
	.4byte	.LVL8
	.4byte	0x24c
	.4byte	0x186
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x75
	.sleb128 0
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC2
	.byte	0
	.uleb128 0xc
	.4byte	.LVL9
	.4byte	0x26c
	.uleb128 0xa
	.4byte	.LVL10
	.4byte	0x273
	.4byte	0x1a3
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x8
	.byte	0x64
	.byte	0
	.uleb128 0xa
	.4byte	.LVL11
	.4byte	0x273
	.4byte	0x1b7
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x8
	.byte	0x64
	.byte	0
	.uleb128 0xc
	.4byte	.LVL12
	.4byte	0x284
	.uleb128 0xa
	.4byte	.LVL13
	.4byte	0x24c
	.4byte	0x1d7
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC3
	.byte	0
	.uleb128 0xc
	.4byte	.LVL14
	.4byte	0x28f
	.uleb128 0xa
	.4byte	.LVL17
	.4byte	0x29a
	.4byte	0x1fd
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0xc
	.4byte	0x186a0
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x74
	.sleb128 0
	.byte	0
	.uleb128 0xc
	.4byte	.LVL18
	.4byte	0x28f
	.uleb128 0xa
	.4byte	.LVL20
	.4byte	0x24c
	.4byte	0x21d
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC4
	.byte	0
	.uleb128 0xd
	.4byte	.LVL21
	.4byte	0x273
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x3
	.byte	0xa
	.2byte	0x3e8
	.byte	0
	.byte	0
	.uleb128 0xe
	.4byte	.LASF31
	.byte	0x6
	.2byte	0x51b
	.4byte	0xb4
	.uleb128 0xf
	.4byte	.LASF18
	.byte	0x4
	.byte	0xc
	.4byte	0x24c
	.uleb128 0x10
	.4byte	0xa2
	.byte	0
	.uleb128 0xf
	.4byte	.LASF19
	.byte	0x4
	.byte	0xe
	.4byte	0x25e
	.uleb128 0x10
	.4byte	0xb9
	.uleb128 0x11
	.byte	0
	.uleb128 0x12
	.4byte	.LASF20
	.byte	0x5
	.byte	0xd
	.uleb128 0x12
	.4byte	.LASF21
	.byte	0x5
	.byte	0x11
	.uleb128 0x12
	.4byte	.LASF22
	.byte	0x5
	.byte	0xe
	.uleb128 0xf
	.4byte	.LASF23
	.byte	0x5
	.byte	0x9
	.4byte	0x284
	.uleb128 0x10
	.4byte	0xa2
	.byte	0
	.uleb128 0x13
	.4byte	.LASF24
	.byte	0x5
	.byte	0xf
	.4byte	0xa2
	.uleb128 0x13
	.4byte	.LASF25
	.byte	0x5
	.byte	0x12
	.4byte	0xa2
	.uleb128 0x14
	.4byte	.LASF26
	.byte	0x5
	.byte	0x13
	.4byte	0x8c
	.uleb128 0x10
	.4byte	0xa2
	.uleb128 0x10
	.4byte	0xa2
	.byte	0
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
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0x9
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
	.uleb128 0xa
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
	.uleb128 0xb
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
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
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
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
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x12
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
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x13
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
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x14
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
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",%progbits
.Ldebug_loc0:
.LLST0:
	.4byte	.LVL0
	.4byte	.LVL7
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL7
	.4byte	.LFE110
	.2byte	0x1
	.byte	0x55
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL16
	.4byte	.LVL18
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL18
	.4byte	.LVL19
	.2byte	0x6
	.byte	0x70
	.sleb128 0
	.byte	0x74
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.4byte	.LVL19
	.4byte	.LVL20-1
	.2byte	0x1
	.byte	0x51
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB110
	.4byte	.LFE110-.LFB110
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",%progbits
.Ldebug_ranges0:
	.4byte	.LFB110
	.4byte	.LFE110
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF4:
	.ascii	"__uint8_t\000"
.LASF19:
	.ascii	"printUSART2\000"
.LASF5:
	.ascii	"__int32_t\000"
.LASF10:
	.ascii	"long long unsigned int\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF29:
	.ascii	"/home/semir/Dropbox/Fakultet/2019/MSUT/STM32F407/P2"
	.ascii	"/primjeri/systimer\000"
.LASF8:
	.ascii	"long unsigned int\000"
.LASF3:
	.ascii	"short unsigned int\000"
.LASF27:
	.ascii	"GNU C 4.9.3 20141119 (release) [ARM/embedded-4_9-br"
	.ascii	"anch revision 218278] -mlittle-endian -mthumb -mcpu"
	.ascii	"=cortex-m4 -mthumb-interwork -mfloat-abi=hard -mfpu"
	.ascii	"=fpv4-sp-d16 -g -O2 -fsingle-precision-constant\000"
.LASF7:
	.ascii	"__uint32_t\000"
.LASF23:
	.ascii	"delay_ms\000"
.LASF30:
	.ascii	"main\000"
.LASF31:
	.ascii	"ITM_RxBuffer\000"
.LASF25:
	.ascii	"getSYSTIMER\000"
.LASF11:
	.ascii	"unsigned int\000"
.LASF16:
	.ascii	"char\000"
.LASF12:
	.ascii	"uint8_t\000"
.LASF20:
	.ascii	"initSTOPWATCH\000"
.LASF17:
	.ascii	"time\000"
.LASF13:
	.ascii	"int32_t\000"
.LASF15:
	.ascii	"sizetype\000"
.LASF21:
	.ascii	"initSYSTIMER\000"
.LASF9:
	.ascii	"long long int\000"
.LASF28:
	.ascii	"main.c\000"
.LASF22:
	.ascii	"startSTOPWATCH\000"
.LASF2:
	.ascii	"short int\000"
.LASF26:
	.ascii	"chk4TimeoutSYSTIMER\000"
.LASF14:
	.ascii	"uint32_t\000"
.LASF6:
	.ascii	"long int\000"
.LASF24:
	.ascii	"stopSTOPWATCH\000"
.LASF0:
	.ascii	"signed char\000"
.LASF18:
	.ascii	"initUSART2\000"
	.ident	"GCC: (GNU Tools for ARM Embedded Processors) 4.9.3 20141119 (release) [ARM/embedded-4_9-branch revision 218278]"
