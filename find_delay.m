rec = 44;
mic1 =1;
mic2 = 4;
Audio1 = audioread("ZOOM00"+string(rec)+"/ZOOM00"+string(rec)+"_Tr"+string(mic1)+".WAV");
Audio2 = audioread("ZOOM00"+string(rec)+"/ZOOM00"+string(rec)+"_Tr"+string(mic2)+".WAV");
minsec = 30;
maxsec = 36;
sampfreq = 48000;
soundspeed = 343;
nf = 0.008;
Ts = 1/sampfreq;
ts = minsec:Ts:maxsec;

n = 50;
W1 = 400/sampfreq;
W2 = 2000/sampfreq;
Wn = [W1 W2];
b = fir1(n,Wn);
Audio1 = normalize(Audio1);
Audio2 = normalize(Audio2);
Audio1 = filter(b,1,Audio1);
Audio2 = filter(b,1,Audio2);

Audio1 = abs(Audio1);
Audio2 = abs(Audio2);
Delay = finddelay(Audio1,Audio2);
% Audio1 = movmean(Audio1,300);
% Audio2 = movmean(Audio2,300);
% Audio1(Audio1<=nf) = 0;
% Audio2(Audio2<=nf) = 0;
% Audio1(Audio1>nf) = 1;
% Audio2(Audio2>nf) = 1;
% % 
% for loop = 1:10
%     Audio1 = movmean(Audio1,10000);
%     Audio2 = movmean(Audio2,10000);
% end 

Audio1 = Audio1(minsec*sampfreq:maxsec*sampfreq);
Audio2 = Audio2(minsec*sampfreq:maxsec*sampfreq);


[xcor,lags] = xcorr(Audio1,Audio2);

xcor = abs(xcor);
xcor = movmean(xcor,100);

figure(1)
plot(Audio1);
figure(2)
plot(Audio2);
figure(3)
plot(lags,xcor)
distance = 0;
array = zeros(10);
    [cormax, I] = max(xcor);
    lag = lags(I);
    xcor(I)=0;
    distance = distance+ lag/sampfreq*soundspeed;
% r1 = risetime(Audio1,sampfreq);
% r2 = risetime(Audio2,sampfreq);
% f1 = falltime(Audio1,sampfreq);
% f2 = falltime(Audio2,sampfreq);
% 
% d2 = (r1(1)-r2(1)+f1(1)-f2(1))/2*soundspeed
% for c=1:10
%     [cormax, I] = max(xcor);
%     lag = lags(I);
%     xcor(I)=0;
%     distance = distance+ lag/sampfreq*soundspeed;
%     array(c)=lag/sampfreq*soundspeed;
% end
% distance = distance/10;
distance
x3 = circshift(Audio2,-Delay);
figure(5)
plot(ts,Audio1,ts,x3)
 


