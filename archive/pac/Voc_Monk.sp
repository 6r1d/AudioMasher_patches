# "Voc Monk"
# pac, 2018/05/25
# URL: https://audiomasher.org/patch/MPRBQS

_sin 4096 gen_sine
_f var _dry var _sweep var _tik var tick _tik set

40 _tik get tog 0.2 port 30 * +
(3.5 0.2 1.2 sine +) 1 sine +
_f set

350 (0.05 130 0.75 _sin osc)+
(0.2 250 0.75 _sin osc 250+)+
_sweep set

# freq, pos
_f get 0.4 (0.1 0.38 sine)+
# diam
0.4 (0.07 0.3 0.75 _sin osc)+
# tenseness, velum
0.9 1 (0.06 0.5 0.75 _sin osc)+
voc _tik get 0 0.2 delay tog 0.1 port * _dry set

_dry get
_sweep get 68 butbp
_sweep get 75 butbp
200 0 0.2 1 pareq 2 *

_dry get _f get 4 * 0.6 0.5 lpf18 +
_dry get _f get 8 * 0.6 0.4 lpf18 0.6 * +
_dry get _f get 16 * 0.6 0.3 lpf18 0.3 * +
_dry get 0.1 * +

50 buthp 2.6 *
dup 0 2.5 delay 0.6 * +
dup dup 10 10 2000 zrev + +
