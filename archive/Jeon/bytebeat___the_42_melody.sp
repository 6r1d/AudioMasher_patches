# "bytebeat :: the 42 melody"
# Jeon, 2019/04/06
# URL: https://audiomasher.org/patch/TMULMH

_t var
1 5 0 tdiv 255 dup * 4 * 0 count _t set

(_t get 10 >>) 42 & (_t get) *

255 % 255 /
9000 tone
0.2 * 12000 butlp 25 buthp

