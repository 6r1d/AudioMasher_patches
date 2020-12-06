# "Harmo"
# pac, 2018/05/24
# URL: https://audiomasher.org/patch/SCHW6V

_bar var _sweepf var
0.2 metro _bar set

400 (0.05 150 sine)+
(_bar get 0.01 0.01 2 tenvx 800 *)+
_sweepf set

100 0.5 (_bar get 0.3 2.6 0.12 tenvx)* blsaw
_sweepf get 50 butbp
_sweepf get 68 butbp
_sweepf get 75 butbp
200 0 0.2 1 pareq 8 *

dup 0 2.5 delay 0.6 * +
dup 10 10 2000 zrev +
