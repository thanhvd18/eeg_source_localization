function result = eeg_filtering(data)
% Author : Dinh Van Viet
% Faculty: SSL labrotary at uet

Fs = 256 ; % Hz;
Fmax = Fs/2; 

% butter : butterworth filter
% lowpass filter
Flc = 70;
Wlc = Flc/Fmax;     
ordlow = 2;
[bl,al] =  butter(ordlow,Wlc,'low');

% notch filter
Fn1 = 48;
Fn2 = 52;
ordnot = 2;
Wn1 = Fn1 /Fmax;
Wn2 = Fn2 /Fmax;
[bn,an] =  butter(ordnot,[Wn1 Wn2],'stop');

% highpass filter

Fhc = 0.5;
Whc = Fhc / Fmax;
ordhigh = 1;
[bh,ah] =  butter(ordhigh,Whc,'high');

% dfilt.df2t : Discrete-time, direct-form II transposed filte
h1 = dfilt.df2t(bl,al);
h2 = dfilt.df2t(bn,an);
h3 = dfilt.df2t(bh,ah);

% dfilt.cascade : Cascade of discrete-time filters
hsys = dfilt.cascade(h1,h2,h3);

% tf : return transfer function of the filter system
% figure;
[b,a] = tf(hsys);
% [h,w] = freqz(b,a,2048);
% plot(w/pi*128,abs(h));
% two way for filtering 
% 1st : result = filter(b,a,data')';
% 2nd : result = filter(hsys,data,2); 
result = filter(hsys,data,2);
end 