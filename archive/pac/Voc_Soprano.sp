# "Voc Soprano"
# pac, 2018/05/25
# URL: https://audiomasher.org/patch/KX6FWK

_mel "0 5 7 5 2 2 0 2 2" gen_vals
_beat var _note var _f var _tik var tick _tik set
1 metro _beat set
71 (_beat get 0 _mel tseq)+ _note set

_note get mtof _tik get 0.08 tport
(dup 5 0.05 sine *
  (_note get changed 0.04 0.08 0.5 tenvx) 1 - *
  (_note get changed 0.01 1 1 tenvx) *
)+ _f set

_f get 0.1 0.9 0.4 2 voc
_f get 4 * 0 0.5 2 pareq 1.4 *
6000 0 0.5 2 pareq
550 0.6 0.6 0 pareq

_tik get 0 1 delay tog 0.2 port *
dup 0.2 0.3 delay 0.2 * +
dup dup 1 2 8000 zrev + +
0.5 *
