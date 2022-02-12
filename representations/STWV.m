function H = STWV(X,ncomponent)
%References: Becker, Hanna, Laurent Albera, Pierre Comon, Martin Haardt, Gwénaël Birot, 
% Fabrice Wendling, Martine Gavaret, Christian G. Bénar, and Isabelle Merlet. "EEG extended source localization
% : tensor-based vs. conventional methods." NeuroImage 96 (2014): 143-157.
tX_stft = [];
hop = 2.5;
nfft = 512;
fs = 256;
[~,T]=size(X);
for i=1:T
    tX_stft(:,:,i) = abs(stft(X(:,i),kaiser(3),hop,nfft,fs));
    size(tX_stft)
%     break
end
tX_stft = tensor(tX_stft);


X3 = double(tenmat(tX_stft,3));
U3 = rica(X3',ncomponent);
U3 = U3.TransformWeights;
H = (X*pinv((U3)'));


% tX_es = cp_als(tX_stft,ncomponent);
% H = X*pinv(tX_es.U{3}');

end