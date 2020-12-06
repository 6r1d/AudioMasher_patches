# "Wildlife"
# pac, 2019/01/13
# URL: https://audiomasher.org/patch/YEGRNJ

_ctrl 9 palias # 0 - 1, 0.6

# smooth ctrl, amp ctrl, pitch ctrl, delay bandpass freq
_sctrl var _ctrl get 0.2 port _sctrl set
_actrl var _sctrl get dup 1 sdelay - abs 100000 * 0.1 port tanh _actrl set
_pctrl var 0.18 _actrl get * 0.82  _sctrl get * + _pctrl set
_dbpf var _pctrl get dup * 50 900 scale _dbpf set
_fb var _actrl get 10 * tanh 0.5 * 0.5 + _fb set
_freq1 392 varset
_tik var tick _tik set

# exciter
0.001 noise

# loop in, nonlinearity
(1 p) -1.068 * _fb get * dup dup dup * 1.02 + / swap 0.1 * + +

# delay
0 (_freq1 get inv _tik get 0.05 tport) (20 inv) vdelay

# branch 1: fundamental bandpass
dup _dbpf get 0.02 port 200 butbp

# branch 2: 3rd harmonic bandpass
swap _dbpf get 3 * 0.02 port 200 butbp 0.96 * +

# loop out
dup 1 pset

# tremolo
_amp var dup 3 * 1 bal dup * 1 min _amp set
dup ((0.2 8 sine 20 +) 0.3 sine 0.4 +) * (1 _amp get -) cf

# mix
0 0.01 -20 peaklim
dup dup 4 2 7000 zrev + 0.5 * +
