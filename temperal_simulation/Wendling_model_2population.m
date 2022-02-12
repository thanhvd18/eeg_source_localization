function dYdt = Wendling_model_2population(x,y)
PARAM = gWet_default_NMM();
% load('params.mat')
a       = PARAM.a;
A       = PARAM.A;
b       = PARAM.b;
B       = PARAM.B;
C1      = PARAM.C1;
C2      = PARAM.C2;
C3      = PARAM.C3;
C4      = PARAM.C4;
ad      = PARAM.ad;

K01 = PARAM.K01;
K02 = PARAM.K02;
K10 = PARAM.K10;
K12 = PARAM.K12;
K21 = PARAM.K21;
K20 = PARAM.K20;

signal_FS = PARAM.signal_FS;
signal_freq = PARAM.signal_freq;
pulse_rate = PARAM.pulse_rate;
mu = PARAM.mu;
sigma = PARAM.sigma;


p = @(t) fun_random_gauss_pulse(t,signal_freq,pulse_rate,mu,sigma);
S= @(t) (2*PARAM.e0)./(1+exp(PARAM.r*(PARAM.v0-t)));


% dYdt=[y(2);(A*a*S(y(3)-y(2)) - 2*a*y(2)-a^2*y(1));...
%       y(4);(A*a*(p(x) + C2*S(C1*y(1))) -2*a*y(4)-a^2*y(3));...
%       y(6);(B*b*(C4*S(C3*y(1)))-2*b*y(6)-b^2*y(5));...
%       y(8);(A*ad*S(y(3)-y(5))-2*ad*y(8)-ad^2*y(7))];
  
dYdt=[y(2,:);(A*a*S(y(3,:)-y(2,:)) - 2*a*y(2,:)-a^2*y(1,:));...
      y(4,:);(A*a*(p(x) + C2*S(C1*y(1,:)) + K10*y(15)) -2*a*y(4,:)-a^2*y(3,:));...
      y(6,:);(B*b*(C4*S(C3*y(1,:)))-2*b*y(6,:)-b^2*y(5,:));...
      y(8,:);(A*ad*S(y(3,:)-y(5,:))-2*ad*y(8,:)-ad^2*y(7,:))
      
      y(10,:);(A*a*S(y(11,:)-y(10,:)) - 2*a*y(10,:)-a^2*y(9,:));...
      y(12,:);(A*a*(p(x) + C2*S(C1*y(9,:)) + K01*y(7)) -2*a*y(12,:)-a^2*y(11,:));...
      y(14,:);(B*b*(C4*S(C3*y(9,:)))-2*b*y(14,:)-b^2*y(13,:));...
      y(16,:);(A*ad*S(y(11,:)-y(13,:))-2*ad*y(16,:)-ad^2*y(15,:))
      ];
  

end