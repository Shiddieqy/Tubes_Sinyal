record = [43 44 47];
res = zeros(3);
minsec =1;
maxsec = 60;
sampfreq = 48000;
soundspeed = 343;
nf = 0.008;
Ts = 1/sampfreq;
ts = minsec:Ts:maxsec;
n = 50;
Wn = 2000/sampfreq;
b = fir1(n,Wn);
for note = 1:3
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
            xcor(I)=0;
            distance = lag/sampfreq*soundspeed;
            res(note,mic1,mic2)=distance;
        end
    end
end