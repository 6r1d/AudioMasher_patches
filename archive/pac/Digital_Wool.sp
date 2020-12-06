# "Digital Wool"
# pac, 2019/06/20
# URL: https://audiomasher.org/patch/7IYN6G

_ss 4096 "0.1 1" gen_sinesum
_notes "0 2 5 7 12" gen_vals
_noteoffsets "0 -2" gen_vals
_beat var _note var
1 (0.137 0.15 sine) + metro _beat set

_beat get 1 _notes tseq dup _note set 48 +
_beat get 30 0 tdiv 0 _noteoffsets tseq +
mtof
dup (1 3 0.01 sine +) * 1 0 _ss osc
swap (1 3 0.01 sine -) * 1 + 1 0 _ss osc
+
dup 3 0.1 0 0 dist
	dup 2000 500 butbp
    swap
    	dup 3500 800 butbp 0.05 *
    	swap 6000 100 butbp 0.1 *
        +
    +
swap 1000 buthp +
5 *
_beat get 0 1 trand
(1 (_note get 0.05 *) -) *
0.02 port *
_beat get 0.6 0.65 0.2 tenvx *
dup
dup 0.9 (0.66 0.5 0.003 sine +) 1 vdelay +
swap
dup 0.9 (1.5 0.51 0.003 sine +) 1 vdelay +
+

tick tog 3 port dup * *
dup 10 10 500 zrev +

