record = 51;
% res =  [zeros(3,4) zeros(3,4) zeros(3,4) zeros(3,4) zeros(3,4) zeros(3,4) zeros(3,4) zeros(3,4) zeros(3,4) zeros(3,4) zeros(3,4) zeros(3,4) zeros(3,4) zeros(3,4)];
res = zeros(6,14);
minsec =20;
maxsec = 26;
sampfreq = 48000;
soundspeed = 343;
nf = 0.008;
Ts = 1/sampfreq;
ts = minsec:Ts:maxsec;
n = 500;
W1 = 1000/sampfreq;
W2 = 1400/sampfreq;
Wn = [W1 W2];
b = fir1(n,Wn);
pros = 1;
for seq = 1:14
    for mic1 = 1:3
        for mic2 = (mic1+1):4
            Audio1 = audioread("FIltered_3"+"/ZOOM00"+string(record)+"_Tr"+string(mic1)+".WAV");
            Audio2 = audioread("Filtered_3"+"/ZOOM00"+string(record)+"_Tr"+string(mic2)+".WAV");
            Audio1 = normalize(Audio1);
            Audio2 = normalize(Audio2);
%             Audio1 = filter(b,1,Audio1);
%             Audio2 = filter(b,1,Audio2);
%             
            Audio1 = abs(Audio1);
            Audio2 = abs(Audio2);
            Audio1 = Audio1(minsec*sampfreq:maxsec*sampfreq);
            Audio2 = Audio2(minsec*sampfreq:maxsec*sampfreq);
            

            lag = finddelay(Audio1,Audio2);
            distance = lag/sampfreq*soundspeed;
            res((pros-(seq-1)*6),seq)=distance;
            fprintf("Process : %d / 84\n",pros)
            pros = pros+1;
        end
        mic2 = 1;
    end
    mic1 = 1;
    minsec = minsec + 12;
    maxsec = maxsec +12;
end 
