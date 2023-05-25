rec = 45;
Audio1 = audioread("ZOOM00"+string(rec)+"/ZOOM00"+string(rec)+"_Tr3.WAV");
Audio2 = audioread("ZOOM00"+string(rec)+"/ZOOM00"+string(rec)+"_Tr4.WAV");
minsec =18.8;
maxsec = 23;
sampfreq = 48000;
soundspeed = 343;
nf = 0.01;
Ts = 1/sampfreq;
ts = minsec:Ts:(maxsec);


n = 20;
W1 = 500/sampfreq;
W2 = 2000/sampfreq;
b = fir1(n,[W1 W2]);
% Audio1 = normalize(Audio1);
% Audio2 = normalize(Audio2);
% Audio1 = filter(b,1,Audio1);
% Audio2 = filter(b,1,Audio2);

% Audio1 = abs(Audio1);
% Audio2 = abs(Audio2);
% Audio1 = movmean(Audio1,300);
% Audio2 = movmean(Audio2,300);
Audio1(Audio1<=nf) = 0;
Audio2(Audio2<=nf) = 0;
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
    distance
    [pk1, loc1] = findpeaks(Audio1);
    [pk2, loc2] = findpeaks(Audio2);
A1 = zeros(length(Audio1),1);
A2 = zeros(length(Audio1),1);
A1(loc1) = pk1;
A2(loc2) = pk2;
% A1 = normalize(A1);
% A2 = normalize(A2);
    [pk1, loc1] = findpeaks(pk1,loc1);
    [pk2, loc2] = findpeaks(pk2,loc2);


[xcor,lags] = xcorr(A1,A2);

xcor = abs(xcor);
xcor = movmean(xcor,100);
[cormax, I] = max(xcor);
    lag = lags(I);
    xcor(I)=0;
    distance = distance+ lag/sampfreq*soundspeed;
        figure(6)
plot(lags,xcor)

% [r1,lt1,ut1] = risetime(Audio1);
% [r2,lt2,ut2] = risetime(Audio2);
% [r3,lt3,ut3] = falltime(Audio1);
% [r4,lt4,ut4] = falltime(Audio2);
% 
% 
% d2 = (lt1(1)-lt2(1)+ut3(1)-ut4(1))/sampfreq/2*soundspeed;
% for c=1:10
%     [cormax, I] = max(xcor);
%     lag = lags(I);
%     xcor(I)=0;
%     distance = distance+ lag/sampfreq*soundspeed;
%     array(c)=lag/sampfreq*soundspeed;
% end
% distance = distance/10;
distance
% [r,lt1,ut1] = risetime(xcor);
% [f,lt2,ut2] = falltime(xcor);
% lag2 = (lt1(abs(ut1-length(Audio1))<1000)-length(Audio1)*2+lt2(abs(ut2-length(Audio1))<1000))/2;
x3 = circshift(A2,lag);
figure(5)
plot(ts,A1,ts,x3)
 


