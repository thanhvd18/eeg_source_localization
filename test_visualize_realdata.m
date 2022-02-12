clc,close all; clear

init;

%% load data sample
dataDir                 = './realdata_sample/';
labelDir                = './realdata_sample/';
sample                  = 'Patient_5_dur1.mat'; %% (33), (51)
label_sample            = 'Patient_Spk_5_dur1';
load([dataDir sample])                  %load graph variable
load([labelDir label_sample])           %load Spk_event variable

% channel indices and name
electrodes              = {"Fp1","Fp2","F3","F4","C3","C4","P3","P4","O1","O2","F7","F8","T7","T8","P7","P8","Fz","Cz","Pz"};
eloc                    = readlocs('channelLocation/Standard-10-20-Cap19.locs');

graph = average_montage(graph);
filter_graph = graph;
filter_graph = 1e6*filter_graph;

%spike infomation
Spk_event = table2array(Spk_event);
[n_spikes,~] = size(Spk_event);
selected_spike = randi(length(n_spikes),1,1);
is_plot = 1;
X_segment = get_spike_segment(filter_graph,Spk_event,electrodes,selected_spike,is_plot);



%% Scalp plot
figure;
spike_time = Spk_event(selected_spike,2);
s_spatial = filter_graph(:,spike_time);
subplot(1,2,1)
topoplot((s_spatial),eloc, 'electrodes','labels')
subplot(1,2,2)
headplot(s_spatial,'channelLocation/Standard-10-20-Cap19.spl')
suptitle('Headplot and topoplot')

%
%% Filtering and view spectrum 

% close all
% PSD_welch(graph);
% filter_graph = eeg_filtering(graph); %already

Px = PSD_welch(filter_graph); %power spectrum density estimation
title("Power spectrum density estimation")



