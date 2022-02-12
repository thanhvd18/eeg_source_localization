function patchs_array = gen_patches(D,vc,tri)
[~,nd] = size(G);
% generate all pack
D = 5;
faces = tri;
nodes = vc;
patchs= {};
% point_source =[-0.06,-0.02,0.08;0.004,-0.025,0.12;0.08,-0.02,0.08]; % back right
% point_source =[0.075,-0.05,0.05;0.017,-0.07,0.065;-0.055,-0.05,0.05]; % top right  view(0,0)
tic
parfor k=1:nd
fprintf('k=%d\n',k)
source_k = nodes(k,:);
[mIdx,mD] = knnsearch(nodes,source_k,'K',D);
patch_k = zeros(nd,1);
patch_k(mIdx) = 1;
patchs_array(:,k) = sparse(patch_k);
end
toc
% 

% save('patchs_74382.mat', 'patchs_array_5', '-append')