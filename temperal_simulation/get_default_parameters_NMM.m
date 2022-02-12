function PARAM = get_default_NMM()
%References:
% [1] Jansen, Ben H., and Vincent G. Rit. "Electroencephalogram and visual evoked potential 
% generation in a mathematical model of coupled cortical columns." Biological cybernetics 
% 73, no. 4 (1995): 357-366.
% [2] Wendling, Fabrice, Jean-Jacques Bellanger, Fabrice Bartolomei, and Patrick Chauvel
% . "Relevance of nonlinear lumped-parameter models in the analysis of depth-EEG epileptic signals." Biological cybernetics 83, no. 4 (2000): 367-378.

PARAM = struct();

v_unit = 1;

PARAM.A = 8*v_unit;
% A = 3.25;
% A = 4.5;
% A = 8.5;
PARAM.B = 22*v_unit;
PARAM.a = 100;
PARAM.b=50;
% C = 65;
C = 135;
PARAM.C = C;
PARAM.C1=PARAM.C;PARAM.C2 = 0.8*C;PARAM.C3 = 0.25*C;PARAM.C4 = 0.25*C;
PARAM.v0=6*v_unit;
PARAM.e0=2.5;
PARAM.r=0.56*v_unit;
PARAM.ad=30;

% Wendling model
PARAM.K01 = 00;
PARAM.K02 = 0;
PARAM.K10 = 0;
PARAM.K12 = 00;
PARAM.K21 = 0;
PARAM.K20 = 00;


PARAM.signal_FS = 10000;
PARAM.signal_freq = 500;
PARAM.pulse_rate = randi([30,320],1,1);
% pulse_rate = 90;

%Tuning mu, sigma
PARAM.mu = 0;
PARAM.sigma =  1;
% PARAM.mu = 10;
% PARAM.sigma =  2;


%wendling 2002
PARAM.G = 10;
PARAM.g = 500;

end