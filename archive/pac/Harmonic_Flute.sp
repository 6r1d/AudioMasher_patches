# "Harmonic Flute"
# pac, 2019/01/13
# URL: https://audiomasher.org/patch/U3U3B5

_bp_freq 14 palias # 80 - 4200, 1100 (Hz)
_lp_freq 13 palias # 80 - 10000, 3500 (Hz)
_crossfade 10 palias # 0 - 0.95, 0.6
_feedback 11 palias # -2 - 2, 1.4
_exciter_cutoff 12 palias # 80 - 10000, 700 (Hz)
_tik var tick _tik set

# prepare feedback, beat, pitch and delay length
_fb var _feedback get dup 2 * tanh 5 * + 0.1718 * 
_bp_freq get 50000 / 1 + * _fb set
_seq "0 4 7 12 16 7 12 16" gen_vals
_beat var 4 metro _beat set
_freq var _beat get 0 _seq tseq 64 + mtof _freq set
_len var _freq get dup dup * 0.1786 * _lp_freq get _bp_freq get + / + inv
1.011 * sr inv - _len set

# exciter
0.01 noise
_beat get dup 0.001 0.01 0.01 tenvx swap 0.001 0.08 0.03 tenvx + *
_exciter_cutoff get _tik get 0.03 tport butlp

# receive feedback, apply nonlinearity and beat
0 p
(_fb get _beat get 0.001 0.1 0.2 tenvx 0.4 * 0.6 + *)
* tanh +

# delay
0 (_len get _tik get 0.001 tport) 0.1 vdelay

# filters
dup _lp_freq get _bp_freq get + _tik get 0.03 tport tone
swap _bp_freq get _tik get 0.03 tport 1000 butbp 1.1 *
_crossfade get cf

# fork feedback and output
dup 0 pset

# some mixing
dup dup 0.5 3 1200 zrev + 0.75 * + 0 0.01 -15 peaklim

