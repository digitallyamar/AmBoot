	.global _start

_start:
	ldr x0,=0x70006000
	mov w1, 'A'
	str w1, [x0]
	mov w1, 'M'
	str w1, [x0]
	mov w1, 'A'
	str w1, [x0]
	mov w1, 'R'
	str w1, [x0]
	b .















