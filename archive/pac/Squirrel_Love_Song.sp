# "Squirrel Love Song"
# pac, 2018/05/23
# URL: https://audiomasher.org/patch/R7EYKN

_loseq '0 0 0 0 -2 -2 -4 -4' gen_vals
_miseq '0 5 0 3 0 3 5 0 3' gen_vals
_hiseq '0 -2 2' gen_vals
_arp '0 5 12 17' gen_vals

# rhythm triggers
_bar var _beat var _half var _bmix var _speed 4 varset
(_speed get) metro _half set
(_half get) 2 0 tdiv _beat set
(_beat get) 8 2 tdiv _bar set
(_bar get) 4 3 tdiv tog 2 port _bmix set

# prepare bass arp
_bass var
(_bar get 0 _loseq tseq (_half get 0 _arp tseq)+ ) 58 + mtof
 0.05 sine
_half get 0.001 0.01 0.2 tenvx * _bass set

# middle melody and chords
(_half get 0 _miseq tseq) (75 +) mtof 0.1 sine
(_bar get 0 _loseq tseq) (70 +) mtof 0.05 sine
(_bar get 0 _loseq tseq) (75 +) mtof 0.05 sine

# mix and add structured staccato
+ +
(0) (_bass get 1.2 *) (_bmix get) crossfade +
_half get 0.001 0.1 0.2 tenvx *
_beat get 0.001 0.1 0.2 tenvx *
(_bass get) (0) (_bmix get) crossfade +

# low-feedback delay
dup (0.3 (_speed get inv) delay) (0.5 *) +

# high slow melody with high-feedback delay
(_bar get 0 _hiseq tseq) (87 +) mtof 0.03 sine
_bar get 0.001 0.1 0.2 tenvx *
dup (0.76 (_speed get inv) delay) +
+

# crappy declick and eq
3500 butlp 200 buthp
500 0.3 0.3 0 pareq 4 *
