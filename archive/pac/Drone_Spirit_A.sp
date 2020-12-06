# "Drone Spirit A"
# pac, 2018/05/21
# URL: https://audiomasher.org/patch/OZOIGB

_sin 4096 gen_sine
_env 4096 '0.5 0.5 270 0.5' gen_composite
_pulse 64 'tick dur 0.22 * tgate dur 0.1 * port' gen_eval

# base MIDI note
_key 50 varset

# generate drone: pinknoise -> string resonators
0.15 pinknoise
(_key get mtof) 0.1 (0.05 0.4 0.5 _pulse osc)+ streson
(_key get mtof 0.5 *) 0.2 streson
(_key get mtof 0.25 *) 0.95 streson
dcblk

# shape drone spectrum: moving equalizer
# (pareq: freq, boost, Q, mode)
1000  0.1 (0.1 0.7 0.7 _pulse osc)+ 0.6 2 pareq
3000  0.02(0.1 1.5 0.3 _pulse osc)+ 0.7 2 pareq
4000  0.001 1 2 pareq

# add granular sweep - fof has 12 arguments:
# amp  fundamental            formant
0.06   (_key get mtof 0.5 *) (0.1 200 sine 500 +)
# oct band ris   dec    dur  iphs laps win  sine
  0   1    0.003 0.0007 0.02 0    5    _env _sin fof

# mix and add ambiance
(+) dup 0.6 0.33 delay +
dup 10 6 6000 zrev + # (zrev: in1 rtlo rthi hfdmp)
500 0.3 0.3 0 pareq 2 *
