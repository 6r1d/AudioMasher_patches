# "Trance by the Book"
# pac, 2019/06/20
# URL: https://audiomasher.org/patch/WRZXQH

_sint 4096 gen_sine
_notes '0 0 5 9 5' gen_vals
_beat var _note var _env2 var

4 metro _beat set
_beat get 32 0 tdiv 0 _notes tseq _note set

# the lord saw how wicked man's sawtooth had become,
# and it was phat
38 mtof 0.12 blsaw 
50 mtof 1.005 * 0.06 blsaw +
57 _note get + mtof 0.995 * 0.05 blsaw +
57 _note get + mtof 1.003 * 0.05 blsaw +
30 (0.125 0 phasor 7000 *) + 0.6 1 lpf18
0.4 * dup jcrev 7 * +
dup 0.3 0.5 delay +
0.7 *
1 1 0 0 dist 0.3 *
(_beat get 2 1 tdiv) 0.05 0.22 0.001 tenv 0.2 + *

# "yea," sayth the lord, "i will uphold your snares
# and your hi-hats with my righteous filters"
0.3 noise dup 
4000 0.5 0.5 lpf18
swap 8000 0.5 0.5 lpf18 0.5 * +
_beat get 0.0001 0.01 0.001 tenv 
dup 0 0.127 delay 0.3 * + 0.1 *
_beat get 4 2 tdiv 0.001 0.003 0.1 tenvx + *
+

# and gave unto man a sine wave,
# that he may craft a kick drum,
# and bob his head in green pastures
_beat get 2 0 tdiv 0 0.00005 0.012 tenvx 400 * 60 +
_beat get 2 0 tdiv 0.001 0.005 0.04 tenvx 2 *
sine
+

2 2 0.6 0 dist 0.08 * 1 clip
dup
0 0.002 (0.17 0.001 0 _sint osc)+ 0.1 vdelay
0.3 (0.17 0.2 0.8 _sint osc)+ *
+
2500 2 0.2 2 pareq
0.001 0.02 -32 peaklim 3 *

