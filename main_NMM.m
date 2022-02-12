% solve systems of first order ODE / Neural mass model
clc,clear,close all;
init;
%%
% parameters of system of ODE 
PARAM = get_default_parameters_NMM()
acc = 5e-1;
options = odeset('RelTol',acc);
FS = 256; %step in ODE
tic
[t x] = ode45(@Wendling_model,[0:1/FS:5],1*randn(8,1),options); %Elapsed time ~90s.
toc 



%% 
figure; 
subplot(2,2,1)
plot(t,x(:,1));legend("y0")
subplot(2,2,2);
plot(t,x(:,2));legend("y1")
subplot(2,2,3)
plot(t,x(:,3));legend("y2")
subplot(2,2,4)
plot(t,x(:,4));legend("y3")
figure;
subplot(2,2,1)
plot(t,x(:,5));legend("y4")
subplot(2,2,2)
plot(t,x(:,6));legend("y5")
subplot(2,2,3)
plot(t,x(:,7));legend("y6")
subplot(2,2,4)
plot(t,x(:,8));legend("y7")
%%
figure(5);
plot(t,x(:,8))
legend("y7")
title(sprintf("A=%.1f",PARAM.A))