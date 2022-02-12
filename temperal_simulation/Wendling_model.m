function dYdt = Wendling_model(x,y)
% References: Wendling, Fabrice, Jean-Jacques Bellanger, Fabrice Bartolomei, and Patrick Chauvel
% . "Relevance of nonlinear lumped-parameter models in the analysis of depth-EEG epileptic signals." Biological cybernetics 83, no. 4 (2000): 367-378.

PARAM = get_default_parameters_NMM();
% load('params.mat')
a       = PARAM.a;

% if x>2 && x<2.2
%     A = 4.5;
% elseif x>2.2 && x<2.5
%     A = -4.5;
% else
%     A       = PARAM.A;
% end
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



dYdt=[y(2,:);(A*a*S(y(3,:)-y(5,:)) - 2*a*y(2,:)-a^2*y(1,:));...
      y(4,:);(A*a*(p(x) + C2*S(C1*y(1,:))) -2*a*y(4,:)-a^2*y(3,:));...
      y(6,:);(B*b*(C4*S(C3*y(1,:)))-2*b*y(6,:)-b^2*y(5,:));...
      y(8,:);(A*ad*S(y(3,:)-y(5,:))-2*ad*y(8,:)-ad^2*y(7,:))];

% dYdt=[y(1);y(5);...
% y(6);(A*a*S(y(2)-y(3)) - 2*a*y(4)-a^2*y(1));...
% (A*a*(p(x) + C2*S(C1*y(1))) -2*a*y(5)-a^2*y(2));(B*b*(C4*S(C3*y(1)))-2*b*y(6)-b^2*y(3));...
%  y(8);(A*ad*S(y(2)-y(3))-2*ad*y(8)-ad^2*y(7))];

end