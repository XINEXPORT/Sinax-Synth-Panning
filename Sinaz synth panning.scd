(
SynthDef("Sinaz", {arg out = 0, freq=100, pan = 0, rate=5, amp=0.1, gate=1, width=2,speed=0.1;
	var acco, snd;
	acco = Env.adsr(
		attackTime:0.4,
		decayTime:0.8,
		sustainLevel:0.8,
		releaseTime:1.5,
		peakLevel:2,
		curve:-4.0,
		bias:0).kr(gate: gate, doneAction:2);
	snd = LPF.ar(
		in: SinOsc.ar(freq: [freq,100,70]), mul: 0.1);
	snd = snd*acco;
	snd = PanAz.ar(
		numChans: 8,
		width: width,
		in: snd,
		pos: LFSaw.kr(speed));
    Out.ar(0, snd);
}).add;
)

c = Synth(\Sinaz, [\bufnum,\width,4]);
c.set(\speed, 4)

(
Synth (\Sinaz)
)
(
Pbind(
			\instrument, \Sinaz,
	// \scale, Scale.dorian,
	        \midinote, Prand([50,55,65,50],inf),
			\dur, 1.5,
			\amp, 0.1,
	        \pan, Pseq((0,0.1..2), inf), // circle
		    \legato,0.8
	).trace.play;
	4.wait;

SinOsc.ar (

