<CsoundSynthesizer>
	<CsOptions>
		; Select audio/midi flags here according to platform
		-odac    ;;;realtime audio out
		;-iadc    ;;;uncomment -iadc if realtime audio input is needed too
		; For Non-realtime ouput leave only the line below:
		; -o oscils.wav -W ;;; for file output any platform
	</CsOptions>
	<CsInstruments>

		/**
		 * Many of the examples here are taken from http://www.csounds.com/manual/html/oscils.html
		 * This is intended as a learning exercise and reference guide. Still learning for a good
		 * coding style, so expect a lot of poor documentation here.
		 *
		 * I'm excluding loscil here as it uses an external file and deserves
		 * a dedicated example.  Grain also seems a bit complicated as it uses function tables.
		 *
		 * @author: Olin Gallet
		 * @date:   11 May 2020
		 */

		sr = 44100 ; sampling rate
		ksmps = 32
		nchnls = 1 ; number of channels
		0dbfs  = 1

		// http://www.csounds.com/manual/html/oscils.html
		instr ExSineOsc
			/**
			 * = Sine Oscillator Example =
			 * asig oscils iamp, icps, iphs [, iflg]
			 * iamp - output amplitude
			 * icps - frequency in Hz (may be zero or negative, however the absolute value must be less than sr/2).
			 * iphs - start phase between 0 and 1
			 * iflg - 2 to use double precision (improves quality but has slowdown) 
			 */
			iamp = .3
			icps = 2121
			iphs = 0.21

			asig oscils iamp, icps, iphs
		    out asig
		endin

		// http://www.csounds.com/manual/html/pluck.html
		instr ExPluck
			/**
			 * = Pluck Example =
			 * asig pluck kamp, kcps, icps, ifn, imeth [, iparm1] [, iparm2]
			 * kamp  - output amplitude
			 * kcps  - resampling frequency in cycles per second
			 * icps  - intended pitch value in hertz
			 * ifn   - table number of a stored function used to initialize the cyclic decay buffer
			 * imeth - natural decay, 1-6 as follows:
			 * 1. simple averaging. A simple smoothing process, uninfluenced by parameter values.
		   	 * 2. stretched averaging. As above, with smoothing time stretched by a factor of iparm1 (>=1).
		   	 * 3. simple drum. The range from pitch to noise is controlled by a 'roughness factor' in iparm1 (0 to 1). Zero gives the plucked string effect, while 1 reverses the polarity of every sample (octave down, odd harmonics). The setting .5 gives an optimum snare drum.
		   	 * 4. stretched drum. Combines both roughness and stretch factors. iparm1 is roughness (0 to 1), and iparm2 the stretch factor (>=1).
		   	 * 5. weighted averaging. As method 1, with iparm1 weighting the current sample (the status quo) and iparm2 weighting the previous adjacent one. iparm1 + iparm2 must be <= 1.
			 * 6. 1st order recursive filter, with coefs .5. Unaffected by parameter values.
			 */	
			kamp = 0.7
			kcps = 220
			icps = 220
			ifn  = 0
			imeth = 4
			asig pluck kamp, kcps, icps, ifn, imeth, .1, 10
		    out asig
		endin

		// http://www.csounds.com/manual/html/buzz.html
		instr ExBuzz
		  /**
		   * = Buzz Example =
		   * = Harmonically related sine waves =
		   * xamp - amplitude
		   * xcps - frequency in cycles per second
		   * knh  - number of harmonics requested
		   * ifn  - table number of a stored function containing a sine wave. A large table of at least 8192 points is recommended.
		   * asig buzz xamp, xcps, knh, ifn [, iphs]
		   */
			kcps = 110
			ifn  = 1
			knh	line p4, p3, p5
			asig buzz 1, kcps, knh, ifn
			out asig
		endin

		// http://www.csounds.com/manual/html/gbuzz.html
		instr ExGBuzz
		  /**
		   * = Buzz Example =
		   * = Harmonically related sine waves =
		   * xamp - amplitude
		   * xcps - frequency in cycles per second
		   * knh  - number of harmonics requested
		   * ifn  - table number of a stored function containing a sine wave. A large table of at least 8192 points is recommended.
		   * asig buzz xamp, xcps, knh, ifn [, iphs]
		   */
			kcps = 110
			ifn  = 1
			knh	line p4, p3, p5
			asig buzz 1, kcps, knh, ifn
			out asig
		endin
	</CsInstruments>
	<CsScore>
		; # loadtime table-size GENroutine params
		; http://www.csounds.com/manual/html/ScoreGenRef.html
		f 1 0        8192       10         1

		; inst       start duration amp frequency
		i "ExSineOsc"  0     2         
		i "ExPluck"    1     .2
		i "ExPluck"    1.5   .2
		i "ExBuzz"     0     1.5    20  3
		i "ExGBuzz"    1.5   1.5    20  3
		i "ExPluck"    2     .5       
		i "ExSineOsc"  3     2        
		e
	</CsScore>
</CsoundSynthesizer>
