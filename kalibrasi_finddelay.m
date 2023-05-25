record = [45 46];
res = [zeros(3,4) zeros(3,4)];
minsec =12.5;
maxsec = 55;
sampfreq = 48000;
soundspeed = 343;
nf = 0.008;
Ts = 1/sampfreq;
ts = minsec:Ts:maxsec;
n = 500;
W1 = 400/sampfreq;
W2 = 2000/sampfreq;
Wn = [W1 W2];
b = fir1(n,Wn);
pros = 1;
for note = 1:2
    for mic1 = 1:3
        for mic2 = (mic1+1):4
            Audio1 = audioread("ZOOM00"+string(record(note))+"/ZOOM00"+string(record(note))+"_Tr"+string(mic1)+".WAV");
            Audio2 = audioread("ZOOM00"+string(record(note))+"/ZOOM00"+string(record(note))+"_Tr"+string(mic2)+".WAV");
            Audio1 = normalize(Audio1);
            Audio2 = normalize(Audio2);
            Audio1 = filter(b,1,Audio1);
            Audio2 = filter(b,1,Audio2);
            
            Audio1 = abs(Audio1);
            Audio2 = abs(Audio2);
            Audio1 = Audio1(minsec*sampfreq:maxsec*sampfreq);
            Audio2 = Audio2(minsec*sampfreq:maxsec*sampfreq);
            
            
            [xcor,lags] = xcorr(Audio1,Audio2);
            
            xcor = abs(xcor);
            xcor = movmean(xcor,100);
            [cormax, I] = max(xcor);
            lag = lags(I);
            lag = finddelay(Audio1,Audio2);
            xcor(I)=0;
            distance = lag/sampfreq*soundspeed;
            res(mic2,mic1,note)=distance;
            fprintf("Process : %d / 12\n",pros)
            pros = pros+1;
        end
        mic2 = 1;
    end
    mic1 = 1;
end