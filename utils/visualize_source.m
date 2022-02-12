function visualize_source(S,nodes,faces,opt)
if nargin == 3,opt = []; end
if ~isfield(opt,'theta1'), opt.theta1 = -180; end;
if ~isfield(opt,'theta2'), opt.theta2 = 0; end;
if ~isfield(opt,'threshold_plot') opt.threshold_plot = 1; end;
if isfield(opt,'threshold')
S(S<opt.threshold) = 0;
end
if opt.threshold_plot <1
  number_active_dipoles = sum(S>0);
    k = int32(number_active_dipoles*opt.threshold_plot);
    [~, idx] = maxk(S,k);
    S(idx)=1; 
end 
S = reshape(S,74382,1);
% S = S';
nodes_map = [nodes S];
plotsurf(nodes, faces,S)
% set(gca,'visible','off')
axis off
view(opt.theta1,opt.theta2)
if isfield(opt,'title'), title(opt.title); end

    
