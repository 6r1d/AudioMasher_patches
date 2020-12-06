# "Bytebeat :: B"
# Jeon, 2019/04/06
# URL: https://audiomasher.org/patch/TRMB2X

_t var
1 6 0 tdiv 255 dup * 4 * 0 count _t set

(_t get 9 >>) (_t get 13 >>) | (_t get) * 16 &

255 % 255 /
5000 tone
1.5 * 12000 butlp 25 buthp
