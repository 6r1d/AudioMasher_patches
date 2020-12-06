# "Voc Psycreep"
# pac, 2018/05/25
# URL: https://audiomasher.org/patch/4QDNSY

_sint 4096 gen_sine
_tik var _beat var _env1 var _env2 var
4 metro 0 0.4 delay _beat set
_beat get 0.05 0.1 0.2 tenvx _env1 set
_beat get 0.1 0.26 0.1 tenvx _env2 set

# freq
90 (30 _env1 get *) + 
# freq: occasional high-pitched beat
(_beat get 0.2 maytrig 0.1 tgate 100 *) +
# freq: high burst at the beginning of every beat
(
  _beat get 0.02 (0.1 -0.007 sine +) tgate 
  (0.12 100 phasor 100 * 50 +) *
) +
# pos diameter tenseness
0.2 (2.5 (-1.7 _env2 get) *) + 0.6 
# velum
0.5 (0.1 -0.5 sine) +
voc

# volume envelope
_beat get 0.0005 0.08 0.01 tenvx 0.1 + *

# effects
dup 0 0.25 delay +
#dup 3 3 0 0 dist 0.3 * + 0.5 *
0.001 0.01 -36 peaklim 10 *
0.5 * dup -12 1000 100 pshift 2 * 100 buthp +
300 0.5 0.5 1 pareq 1.4 *

# kick
_beat get 0 0.00005 0.012 tenvx
400 * 60 +
_beat get 0.001 0.005 0.04 tenvx
0.25 * sine
+

# flanger
0.3 0.01 (0.1 0.004 0   _sint osc)+ 0.1 vdelay
0.3 0.01 (0.1 0.004 0.4 _sint osc)+ 0.1 vdelay
0.6 *

