.data
	formatendl: .asciz "\n"
	ok: .space 10
	leninput: .space 10
	minus: .asciz "-"
	chDelim: .asciz " "
	res: .space 10
	n: .space 4
	m: .space 4
	s: .space 600
	v: .space 600
	sol: .space 600
	frecv: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
	formatScanf: .asciz "%[^\n]"
	formatPrintf: .asciz "%d "
	formatp: .asciz "%c"
.text
back:
	pushl %ebp
	movl %esp, %ebp
		pushl %ebx
		pushl %edi
		pushl %esi
	movl $v, %edi
        movl $sol, %esi
	xorl %ebx, %ebx
	movl leninput, %ebx
	cmp 8(%ebp), %ebx
	je scrie
	xorl %ebx, %ebx
	movl 8(%ebp), %ebx
	xorl %ecx, %ecx
	movl (%edi, %ebx, 4), %ecx
	cmp $0, %ecx
	je nuedeja
	movl %ecx, (%esi, %ebx, 4)
	pushl %ebx
	movl 8(%ebp), %ebx
	incl %ebx
	pushl %ecx
	pushl %edx
	pushl %ebx
	call back
	popl %ebx
	popl %edx
	popl %ecx
	popl %ebx

        cmp $0, %eax
        je gata_for
		popl %esi
		popl %edi
		popl %ebx
	popl %ebp
        ret
nuedeja:
	xorl %ebx, %ebx
nuedeja_for:
	incl %ebx
	xorl %ecx, %ecx
	movl n, %ecx
	incl %ecx
	cmp %ecx, %ebx
	je gata_for

	movl $frecv, %edx
	xorl %ecx, %ecx
	movl (%edx, %ebx, 4), %ecx
	incl %ecx
	movl %ecx, (%edx, %ebx, 4)
	xorl %eax, %eax
	movl $3, %eax
	cmp %eax, %ecx
	ja okfals

	pushl %ebx
	movl $1, %ebx
	movl %ebx, ok
	popl %ebx
	xorl %eax, %eax
	movl 8(%ebp), %eax
	movl %ebx, (%esi,%eax,4)
	xorl %ecx, %ecx
	movl m, %ecx
	cmp %ecx, %eax
	jae  pozmarem
	movl $0, %eax
	jmp lala
pozmarem:
	subl %ecx, %eax

lala:
	xorl %ecx, %ecx
	movl 8(%ebp), %ecx
	cmp %eax, %ecx
	je gata_lala
	xorl %ecx, %ecx
	movl (%esi, %eax,4), %ecx
	cmp %ebx, %ecx
	je nulala
	incl %eax
	jmp lala
nulala:

	pushl %ebx
        movl $0, %ebx
        movl %ebx, ok
        popl %ebx
	jmp okfals
gata_lala:
	xorl %ecx, %ecx
        movl m, %ecx
	xorl %eax, %eax
        movl 8(%ebp), %eax
	addl %ecx, %eax
	xorl %ecx, %ecx
	movl leninput, %ecx
	cmp  %ecx, %eax
	jae nana
	incl %eax
	movl %eax, %ecx
nana:
	xorl %eax, %eax
	movl 8(%ebp), %eax

nana_for:
	incl %eax
	cmp %eax, %ecx
	je gata_nana
	cmp (%edi,%eax,4),%ebx
	je nulala
	jmp nana_for
gata_nana:
	xorl %eax, %eax
	pushl %ebx
        movl 8(%ebp), %ebx
        incl %ebx
        pushl %ecx
        pushl %edx
        pushl %ebx
        call back
        popl %ebx
        popl %edx
        popl %ecx
        popl %ebx
	cmp $0, %eax
	je okfals
                popl %esi
                popl %edi
                popl %ebx
	popl %ebp
	ret
okfals:
	xorl %ecx, %ecx
	movl $frecv, %edx
	movl (%edx, %ebx, 4), %ecx
	decl %ecx
	movl %ecx,(%edx, %ebx, 4)
	jmp nuedeja_for

gata_for:
	movl $0, %eax
                popl %esi
                popl %edi
                popl %ebx
	popl %ebp
	ret
scrie:
	xorl %ecx, %ecx
scrie_for:
	xorl %ebx, %ebx
	xorl %eax, %eax
	movl leninput, %ebx

	cmp %ecx, %ebx
	je stop
	movl (%esi, %ecx, 4),%eax
	pushl %ecx
	pushl %edx
	pushl %eax
        pushl $formatPrintf
        call printf
        popl %ebx
        popl %ebx
	popl %edx
	popl %ecx
	incl %ecx
	jmp scrie_for
stop:
	xorl %eax, %eax
	movl $1, %eax
                popl %esi
                popl %edi
                popl %ebx
	popl %ebp
	ret
gata:
                popl %esi
                popl %edi
                popl %ebx
	popl %ebp
	ret

.global main
main:
	movl $v, %edi
	movl $frecv, %edx
	movl $sol, %esi
	pushl $s
        pushl $formatScanf
        call scanf
        popl %ebx
        popl %ebx
	xorl %eax, %eax
	pushl $chDelim
	pushl $s
	call strtok 
	popl %ebx
	popl %ebx
	movl %eax, res
        pushl res
        call atoi
	popl %ebx
	movl %eax, n
	xorl %eax, %eax
        pushl $chDelim
        pushl $0
        call strtok
        popl %ebx
        popl %ebx
        movl %eax, res
        pushl res
        call atoi
        popl %ebx
        movl %eax, m

	xorl %ecx, %ecx

tokk:
	xorl %eax, %eax
	pushl %ecx
        pushl $chDelim
        pushl $0
        call strtok
        popl %ebx
        popl %ebx
	popl %ecx
	cmp $0, %eax
        je gata_strtok
        movl %eax, res
	pushl %ecx
        pushl res
        call atoi
        popl %ebx
	popl %ecx
	movl %eax, (%edi,%ecx,4)
	incl %ecx
	cmp $0, %eax
	je tokk
	pushl %ebx
	xorl %ebx, %ebx
	movl $frecv, %edx
	movl (%edx, %eax, 4), %ebx
	incl %ebx
	movl %ebx, (%edx, %eax, 4)
	popl %ebx
	jmp tokk
gata_strtok:
	xorl %eax, %eax
	xorl %ebx, %ebx
	pushl %edx
	movl n, %eax
	movl $3, %ebx
	mull %ebx
	popl %edx
	cmp %eax, %ecx
	jb nuexista
	movl %ecx, leninput
	xorl %ebx, %ebx
	xorl %eax, %eax
	movl $frecv, %edx
	movl leninput, %ecx
	xorl %ebx, %ebx
	xorl %eax, %eax
	xorl %ecx, %ecx
	pushl %ecx
	call back
	popl %ebx
	cmp $0, %eax
	je nuexista
	jmp et_exit
nuexista:
	pushl minus
        pushl $formatp
        call printf
        popl %ebx
        popl %ebx
	pushl $1
        pushl $formatPrintf
        call printf
        popl %ebx
        popl %ebx
et_exit:
	pushl $0
        call fflush
        popl %ebx

	pushl $formatendl
	call printf
	popl %ebx

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
