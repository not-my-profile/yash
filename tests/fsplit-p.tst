# fsplit-p.tst: test of field splitting for any POSIX-compliant shell

posix="true"
setup -d

test_oE -e 0 'field splitting applies to results of expansions'
IFS=' 0' a='1 2'
bracket -${a}- -$(echo '3 4')- -`echo '5 6'`- -$((708))-
__IN__
[-1][2-][-3][4-][-5][6-][-7][8-]
__OUT__

test_oE -e 0 'field splitting does not apply to quoted expansions'
IFS=' 0' a='1 2'
bracket "-${a}-" "-$(echo '3 4')-" "-`echo '5 6'`-" "-$((708))-"
bracket -${a}-"-${a}-"
__IN__
[-1 2-][-3 4-][-5 6-][-708-]
[-1][2--1 2-]
__OUT__

test_oE 'field splitting does not apply to non-expansions'
IFS=' 0'
bracket -102- "-304 5-"
__IN__
[-102-][-304 5-]
__OUT__

test_oE 'no field splitting with empty IFS'
IFS= a='1 2	3
4'
bracket $a
__IN__
[1 2	3
4]
__OUT__

test_oE 'field splitting with unset IFS'
unset IFS
a='1 2	3
4' b=' 	
5 	
6 	
'
bracket $a $b
__IN__
[1][2][3][4][5][6]
__OUT__

test_oE 'field splitting with standard IFS'
IFS=' 	
'
a='1 2	3
4' b=' 	
5 	
6 	
' c='-"%"\'
bracket $a $b $c
__IN__
[1][2][3][4][5][6][-"%"\]
__OUT__

# POSIX's rationale says the standard is based on the behavior of ksh, but the
# strict interpretation of the standard is inconsistent with the actual ksh
# behavior. ksh and some other shells fail the following tests because of
# omitted last empty field.

test_oE 'field splitting with non-whitespace IFS'
IFS='-"'
a='1-2"3' b='--4-"5"-6--'
bracket $a
bracket $b
__IN__
[1][2][3]
[][][4][][5][][6][][]
__OUT__

test_oE 'complex field splitting with nonsuccessive non-whitespace IFS'
IFS=' -"'
a='1%2-3"4&5' b='- 22- 3- 44- ' c=' -22 -3 -44 -' d=' - 22 - 3 - 44 - '
bracket $a
bracket $b
bracket $c
bracket $d
__IN__
[1%2][3][4&5]
[][22][3][44][]
[][22][3][44][]
[][22][3][44][]
__OUT__

test_oE 'complex field splitting with successive non-whitespace IFS'
IFS=' -'
a='--3""3--' b='  --33  --' c='-  -33-  -' d='--  33--  '
bracket $a
bracket $b
bracket $c
bracket $d
__IN__
[][][3""3][][]
[][][33][][]
[][][33][][]
[][][33][][]
__OUT__

test_oE 'backslash not in IFS'
IFS=' -'
a='\' b='\ \' c='\  \' d='\-\' e='\--\' f='-\\ -\-'
bracket $a
bracket $b
bracket $c
bracket $d
bracket $e
bracket $f
__IN__
[\]
[\][\]
[\][\]
[\][\]
[\][][\]
[][\\][\][]
__OUT__

test_oE 'backslash in IFS'
IFS=' \-'
a='\' b='\ \' c='\  \' d='\-\' e='\--\' f='-\\ -\-' g='1\2\\ 4-5\- 7\'
bracket $a
bracket $b
bracket $c
bracket $d
bracket $e
bracket $f
bracket $g
__IN__
[][]
[][][]
[][][]
[][][][]
[][][][][]
[][][][][][][]
[1][2][][4][5][][7][]
__OUT__

# If field splitting yields a single empty field and it is not quoted, then it
# is removed.
# TODO: yash is broken
#test_oE 'empty field removal'
#a= b=' ' c=' - '
#bracket 1 $a
#bracket 2 $b
#bracket 3 ''$a
#bracket 4 ''$b
#bracket 5 $a''
#bracket 6 $b''
#bracket 7 ''$a''
#bracket 8 ''$b''
#bracket 9 ''$c''
#bracket 10 ${a:-""}
#bracket 11 "${a:-""}"
#bracket 12 "$a"
#bracket 13 "$b"
#bracket 14 "" """"""
#bracket 15 '' ''''''
#__IN__
#[1]
#[2]
#[3][]
#[4][]
#[5][]
#[6][]
#[7][]
#[8][][]
#[9][][-][]
#[10][]
#[11][]
#[12][]
#[13][ ]
#[14][][]
#[15][][]
#__OUT__

# vim: set ft=sh ts=8 sts=4 sw=4 noet:
