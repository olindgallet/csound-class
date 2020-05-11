 #10 sec file named foobar.wav
 konsole --new-tab -e arecord -d 10 -f S32_LE -r 44100 -t wav foobar.wav & 
 konsole --new-tab -e csound BasicOpcodes.csd
