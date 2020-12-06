# "Lost in the Tubes"
# pac, 2019/06/20
# URL: https://audiomasher.org/patch/HSDXHY

_seq  '0  1  0  2' gen_vals
_seq2 '0  1  0 -1  0  2' gen_vals
_seq3 '0  0  0  1  1' gen_vals
_pulses '0 1 0 1 2 1 0 2 3 2 0' gen_vals
_sin 4096 gen_sine

# rhythm triggers
_r1 var _r2 var
4 metro _r1 set
(_r1 get 18 0 tdiv) 120 '+-++-+++-' tprop _r2 set

# generate melody and feed directly into a sine
64
(_r2 get 0 _seq tseq 12 *) +
(_r1 get 0 _seq2 tseq 5 *) +
(_r1 get 0 _seq3 tseq 2 *) +
mtof 0.15 sine 1500 butlp
_r1 get 0.003 0.003 0.05 tenvx *
3500 butlp 200 buthp

# prepare string section pitch with alternation and vibrato
_strpitch var
(_r1 get (8 _pulses tblsize *) 1 tdiv) 71 59 switch
(5 0.15 sine) + _strpitch set

# string section: pink noise -> resonators
(_r1 get 8 1 tdiv 0 _pulses tseq ) 1.2 port 0.01 * pinknoise
tick tog 20 1 1 1 adsr *
(_strpitch get mtof 0.5 *) 0.8 streson
(_strpitch get mtof      ) 0.6 streson
(_strpitch get mtof 1.5 *) 0.6 streson
3400 0 1 2 pareq
5000 0 0.6 2 pareq
4000 0 0.2 2 pareq
4000 0.2 0.5 lpf18
300 buthp
dup 0.7 1.7 delay + 3 *
+

# add ambiance (0% dry!)
dup 0.2 0.5 delay 0.4 * +
dup 5 3 6000 zrev + 4 *
620 0.3 0.3 0 pareq 4 *

