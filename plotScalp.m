clc,clear,close all;

init;

selected_spike = 1;
%% 1.real data sample
dataDir = './realdata_sample/';
labelDir = './realdata_sample/';
sample = 'Patient_5_dur1.mat'; %% (33), (51)
label_sample = 'Patient_Spk_5_dur1';
load([dataDir sample])                  %load graph variable
load([labelDir label_sample])           %load Spk_event variable


electrodes              = {"Fp1","Fp2","F3","F4","C3","C4","P3","P4","O1","O2","F7","F8","T7","T8","P7","P8","Fz","Cz","Pz"};
eloc                    = readlocs('channelLocation/Standard-10-20-Cap19.locs');

graph = average_montage(graph);
filter_graph = graph;
filter_graph = 1e6*filter_graph;

if istable(Spk_event),Spk_event = table2array(Spk_event), end;
spike_time = Spk_event(selected_spike,2);
s_spatial = filter_graph(:,spike_time);
subplot(1,2,1)
topoplot((s_spatial),eloc, 'electrodes','labels')
subplot(1,2,2)
headplot(s_spatial,'channelLocation/Standard-10-20-Cap19.spl')
suptitle('Headplot and topoplot')
set(gcf,'color','w');