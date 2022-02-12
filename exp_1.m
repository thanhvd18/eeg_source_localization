% real data sample => spike segment + spike channel => tensor
% representation => Blind source seperation => inverse problem
% 
clc,clear,close all;

init;
%% 1.real data sample
dataDir = './realdata_sample/';
labelDir = './realdata_sample/';
sample = 'Patient_5_dur1.mat'; %% (33), (51)
label_sample = 'Patient_Spk_5_dur1';
load([dataDir sample])                  %load graph variable
load([labelDir label_sample])           %load Spk_event variable

%% 
opt.spike_id             = 1;
opt.representation_method = "GWT"; % ["GWT","STF","STWV"]
opt.inverse_problem_method = "sLORETA"; %["sLORETA","MNE", "MUSIC"]

%% 
exp1(graph,Spk_event,opt)

function exp1(graph,Spk_event,opt)

spike_id                = opt.spike_id;
representation_method   = opt.representation_method;
inverse_problem_method  = opt.inverse_problem_method;
% channel indices and name
electrodes              = {"Fp1","Fp2","F3","F4","C3","C4","P3","P4","O1","O2","F7","F8","T7","T8","P7","P8","Fz","Cz","Pz"};
eloc                    = readlocs('channelLocation/Standard-10-20-Cap19.locs');

graph = average_montage(graph);
filter_graph = graph;
filter_graph = 1e6*filter_graph;




%% spike segment
Spk_event = table2array(Spk_event);
[n_spikes,~] = size(Spk_event);

is_plot = 1;

X_segment = get_spike_segment(filter_graph,Spk_event,electrodes,spike_id,is_plot);

%% Scalp plot
figure;
spike_time = Spk_event(spike_id,2);
s_spatial = filter_graph(:,spike_time);
subplot(1,2,1)
topoplot((s_spatial),eloc, 'electrodes','labels')
subplot(1,2,2)
headplot(s_spatial,'channelLocation/Standard-10-20-Cap19.spl')
suptitle(sprintf('Scalp distribution at spike %d',spike_id))

%% tensor representation + Blind source seperation
ncomponent = 5;
if strcmp(representation_method,"SWF")
    H = SWF(X,ncomponent);
elseif strcmp(representation_method,"STWV")
    H = STWV(X,ncomponent);
elseif strcmp(representation_method,"GWT")
    H = GWT(X_segment,ncomponent);
end


%% Forward problem 
load("sa")
idx_lead_field          = cellfun( @(x)( find(sa.EEG_clab_electrodes==x) ), electrodes );
G                       = sa.cortex75K.EEG_V_fem_normal(:, sa.cortex2K.in_from_cortex75K);
G                       = G(idx_lead_field,:);
%%
vc                      = sa.cortex75K.vc;
tri                     = sa.cortex75K.tri;

%% Inverse problem 
dipole_number = size(vc,1);
inverse_problem_method = "MNE";
S_es = solve_inverse_problem(G,H,sa.cortex2K.in_to_cortex75K_eucl,dipole_number,ncomponent,inverse_problem_method);

%% Visualization results
for j=1:ncomponent
figure(); 
subplot(2,2,[1 2]);
visualize_source(S_es(:,j),vc,tri);
subplot(2,2,3);
topoplot((H(:,j)),eloc, 'electrodes','labels');
% topoplot((s_spatial),chanlocs,'electrodes', 'labels')
subplot(2,2,4);
headplot(H(:,j),'channelLocation/Standard-10-20-Cap19.spl');
suptitle(sprintf("Spike %i - Component %i",spike_id,j));
end
end

%%
