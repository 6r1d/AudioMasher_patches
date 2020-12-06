# "Squirrel Vibraphone"
# pac, 2018/05/23
# URL: https://audiomasher.org/patch/Y3OOFF

_seq "0 5 0 3 0 3 5 0 3" gen_vals
_half var _beat var
4 metro _half set
_half get 2 0 tdiv _beat set

(_half get 0 _seq tseq) (75 +) mtof 0.1 sine

_half get 0.001 0.1 0.2 tenvx *
_beat get 0.001 0.1 0.2 tenvx *

dup (0.5 (4 inv) delay) (0.4 *) +
