clc,clear,close all;
set(0,'defaultfigurecolor',[1 1 1])

%%
signal_FS = 10000;
signal_freq = 500;
mu = 0;
sigma =  1;
t = [0:1/256:1];


%%
pulse_rate = randi([30,320],1,1);
% pulse_rate = 150;
%%

p = @(t) fun_random_gauss_pulse(t,signal_freq,pulse_rate,mu,sigma);
plot(t,p(t))
title(sprintf("p(t), \\mu=%d, \\sigma=%d, rate=%dHz",mu,sigma,pulse_rate))
xlabel('t')