function [M, number_state_variable] = double_column_model(PARAM,pt,S)

a       = PARAM.a;
A       = PARAM.A;
b       = PARAM.b;
B       = PARAM.B;
C1      = PARAM.C1;
C2      = PARAM.C2;
C3      = PARAM.C3;
C4      = PARAM.C4;
ad      = PARAM.ad;



syms y0(t) y1(t) y2(t) y3(t) y4(t) y5(t)  ...
    y6(t) y7(t) y8(t) y9(t) y10(t) y11(t) ...
    y12(t) y13(t) y14(t) y15(t)
ode1 = diff(y0) == y3;
ode2 = diff(y3) == A*a*S(y1-y2) - 2*a*y3-a^2*y0;
ode3 = diff(y1) == y4;
ode4 = diff(y4) == A*a*(pt(t) + C2*S(C1*y0)) -2*a*y4-a^2*y1;
ode5 = diff(y2) == y5;
ode6 = diff(y5) == B*b*(C4*S(C3*y0))-2*b*y5-b^2*y2;
ode7 = diff(y6) == y9;
ode8 = diff(y9) == A'*a*S(y7-y8) - 2*a*y9 - a^2*y6;
ode9 = diff(y7) == y10
ode10 = diff(y10) == A'*a*(pt(t) + C2'*S(C1'*y6)+ K1*y12) -2*a*y10-a^2*y7
ode11 = diff(y8) == y11
ode12 = diff(y11) == B'*b*(C4'*S(C3*y6)) - 2*b*y11 - b^2 y8
ode13 = diff(y12) == y14
ode14 = diff(y14) == A'*ad*S(y1-y2)-2*ad*y14-a^2*y12
ode15 = diff(y13) == y15
ode16 = diff(y15) == A'*ad*S(y7-y8)-2*ad*y15-a^2*y13;

eqns = [ode1,ode2,ode3,ode4,ode5,ode6, ...
        ode7,ode8,ode9,ode10,ode11,ode12
        ode13,ode14,ode15,ode16];
[V] = odeToVectorField(eqns);
M = matlabFunction(V,'vars', {'t', 'Y'});
number_state_variable = 6;

end

