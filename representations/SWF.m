function  H = SWF(X,ncomponent)
%References: Becker, Hanna, Laurent Albera, Pierre Comon, Martin Haardt, Gwénaël Birot, 
% Fabrice Wendling, Martine Gavaret, Christian G. Bénar, and Isabelle Merlet. "EEG extended source localization
% : tensor-based vs. conventional methods." NeuroImage 96 (2014): 143-157.

ne = 19;
tX = [];
for i=1:ne
    tX(i,:,:) = (cwt(X(i,:)));
    size(tX)
%     break
end
tX = tensor(tX);

X1 = double(tenmat(tX,1));
U1 = rica(abs(X1'),ncomponent);
U1 = U1.TransformWeights;
H = abs(U1);

% tX_es = cp_als(tX,ncomponent);
% H = abs(tX_es.U{1});
end