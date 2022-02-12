function H = GWT(X,ncomponent)
% References 
% [1] Hammond, David K., Pierre Vandergheynst, and Rémi Gribonval. 
% "The spectral graph wavelet transform: Fundamental theory and fast computation."
% In Vertex-Frequency Analysis of Graph Signals, pp. 141-175. Springer, Cham, 2019.
% 
% [2] Le, Thanh Xuyen, Trung Thanh Le, Linh Trung Nguyen, Thi Thuy Quynh Tran, 
% and Duc Thuan Nguyen. "EEG Source Localization: 
% A New Multiway Temporal-Spatial Spectral Analysis." (2019).

table = readtable('chanloc.csv');
chanlocs = [table.Var2,table.Var3,table.Var4];
chanlocs = rand(19,3);
D = slmetric_pw(chanlocs',chanlocs','eucdist');
for i=1:19
   D(i,i) = 0; 
end


%create graph gsp
% location = table.Var5;
table = readtable('chanloc.csv');
chanlocs = [table.Var2,table.Var3,table.Var4];
%weighted adjacency matrix.
Z1 = gsp_distanz(X(:, :)').^2;
%%
method = 2;
if method == 1
    s = sqrt(2*(n-1))/2 / 3;
else
    s =  1/2/sqrt(2);
end

params.maxit = 50000;
params.step_size = 0.1;
params.verbosity = 1;
params.tol = 1e-5;
if method == 1
%      W1 = gsp_learn_graph_log_degrees(s*Z1, s*1.5, s*1, params);
   W1 = sqrt(1.5)*gsp_learn_graph_log_degrees(Z1/sqrt(1.5), 1, 1, params);
else
    W1 = gsp_learn_graph_l2_degrees(s*Z1, s*1.2, params);
end
% if method == 1
%     W2 = gsp_learn_graph_log_degrees(s*Z1, s*3, s*1, params);
% else
%     W2 = gsp_learn_graph_l2_degrees(s*Z1, s*1, params);
% end
W1(W1<1e-5) = 0;
G1 = gsp_graph(W1, chanlocs);
% % W1(W1<1e-5) = 0;
% G1 = gsp_graph(W1, chanlocs);%

%%
Nf = 10;
Wk = gsp_design_mexican_hat(G1, Nf);
% param_filter.filter = Wk;
% Wkw = gsp_design_warped_translates(G1,Nf,param_filter);
%%
% vertex_delta = 1;
% S = zeros(G1.N*Nf,Nf);
% S(vertex_delta) = 1;
% for ii=1:Nf
%     S(vertex_delta+(ii-1)*G1.N,ii) = 1
% end

% Sf = gsp_filter_synthesis(G1,Wk,S);
clear tX
[~, T] = size(X);
for i=1:T
   coeffs = gsp_filter(G1, Wk, X(:,i));
   coeffs = reshape(coeffs,19,Nf);
   tX(:,:,i) =  coeffs;
end
%%
tX = tensor(tX);

X3 = double(tenmat(tX,3));
U3 = rica(X3',ncomponent); %ICA
U3 = U3.TransformWeights;
H = (X*pinv((U3)'));
% tX_es = cp_als(tX,ncomponent);
% err = tX- tX_es;
% fitness = norm(err)/norm(tX)
% H = (X*pinv((tX_es.U{3})'));