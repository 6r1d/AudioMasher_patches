# "Scarbo"
# pac, 2018/05/21
# URL: https://audiomasher.org/patch/W6ZYZI

tick 1 0.3 0 dust +
500 (-200 500 30 randh)+ 0.3 110 pluck
1 p 0 0.2 delay 0.6 *
-1 500 50 pshift
dup dup 1 1 5000 zrev + 2 * +
50 buthp dup rot + 1 pset
