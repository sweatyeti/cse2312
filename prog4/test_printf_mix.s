	.arch armv6
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu vfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"test_printf_mix.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%d\000"
	.align	2
.LC1:
	.ascii	"%d, %d, %f\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB0:
	.file 1 "test_printf_mix.c"
	.loc 1 4 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	.cfi_def_cfa_offset 8
	.cfi_offset 11, -8
	.cfi_offset 14, -4
	add	fp, sp, #4
	.cfi_def_cfa 11, 4
	sub	sp, sp, #32
	.loc 1 8 0
	sub	r3, fp, #20
	ldr	r0, .L3
	mov	r1, r3
	bl	__isoc99_scanf
	.loc 1 9 0
	sub	r3, fp, #24
	ldr	r0, .L3
	mov	r1, r3
	bl	__isoc99_scanf
	.loc 1 11 0
	ldr	r3, [fp, #-20]
	fmsr	s15, r3	@ int
	fsitos	s15, s15
	fsts	s15, [fp, #-8]
	.loc 1 12 0
	ldr	r3, [fp, #-24]
	fmsr	s15, r3	@ int
	fsitos	s15, s15
	fsts	s15, [fp, #-12]
	.loc 1 13 0
	flds	s14, [fp, #-8]
	flds	s15, [fp, #-12]
	fdivs	s15, s14, s15
	fsts	s15, [fp, #-16]
	.loc 1 16 0
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-24]
	flds	s15, [fp, #-16]
	fcvtds	d7, s15
	fstd	d7, [sp]
	ldr	r0, .L3+4
	mov	r1, r2
	mov	r2, r3
	bl	printf
	.loc 1 17 0
	mov	r3, #0
	.loc 1 18 0
	mov	r0, r3
	sub	sp, fp, #4
	.cfi_def_cfa 13, 8
	@ sp needed
	ldmfd	sp!, {fp, pc}
.L4:
	.align	2
.L3:
	.word	.LC0
	.word	.LC1
	.cfi_endproc
.LFE0:
	.size	main, .-main
.Letext0:
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0xd3
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF12
	.byte	0x1
	.4byte	.LASF13
	.4byte	.LASF14
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF2
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF4
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF5
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF6
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF7
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF8
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF9
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF10
	.uleb128 0x4
	.4byte	.LASF15
	.byte	0x1
	.byte	0x3
	.4byte	0x4f
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xcf
	.uleb128 0x5
	.ascii	"n\000"
	.byte	0x1
	.byte	0x5
	.4byte	0x4f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x5
	.ascii	"d\000"
	.byte	0x1
	.byte	0x5
	.4byte	0x4f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x5
	.ascii	"e\000"
	.byte	0x1
	.byte	0x6
	.4byte	0xcf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x5
	.ascii	"f\000"
	.byte	0x1
	.byte	0x6
	.4byte	0xcf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x5
	.ascii	"q\000"
	.byte	0x1
	.byte	0x6
	.4byte	0xcf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.4byte	.LASF11
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
	.uleb128 0x4
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
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
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
	.uleb128 0x18
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
.LASF0:
	.ascii	"unsigned int\000"
.LASF14:
	.ascii	"/home/pi/Documents/cse2312/prog4\000"
.LASF4:
	.ascii	"signed char\000"
.LASF12:
	.ascii	"GNU C 4.9.2 -mfpu=vfp -march=armv6 -mfloat-abi=hard"
	.ascii	" -mtls-dialect=gnu -g\000"
.LASF3:
	.ascii	"long unsigned int\000"
.LASF7:
	.ascii	"long long unsigned int\000"
.LASF10:
	.ascii	"char\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF15:
	.ascii	"main\000"
.LASF8:
	.ascii	"long int\000"
.LASF6:
	.ascii	"long long int\000"
.LASF13:
	.ascii	"test_printf_mix.c\000"
.LASF2:
	.ascii	"short unsigned int\000"
.LASF11:
	.ascii	"float\000"
.LASF5:
	.ascii	"short int\000"
.LASF9:
	.ascii	"sizetype\000"
	.ident	"GCC: (Raspbian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",%progbits
