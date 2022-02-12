clc,close all; clear

init;

%% load data sample
dataDir = './realdata_sample/';
labelDir = './realdata_sample/';
sample = 'Patient_5_dur1.mat'; %% (33), (51)
label_sample = 'Patient_Spk_5_dur1';
load([dataDir sample])                  %load graph variable
load([labelDir label_sample])           %load Spk_event variable

% channel indices and name
electrodes              = {"Fp1","Fp2","F3","F4","C3","C4","P3","P4","O1","O2","F7","F8","T7","T8","P7","P8","Fz","Cz","Pz"};
eloc                    = readlocs('channelLocation/Standard-10-20-Cap19.locs');
EEG_data       = 10^6*graph([1:16 19:21],:);


graph = average_montage(graph);
delta_t = 64;% 64 sample before and after spike
spike_time = randi([1000,10000],1,1);
plot(spike_time-delta_t:spike_time+delta_t,graph(:,spike_time-delta_t:spike_time+delta_t)');
ylabel('\muV')
xlabel('Sample')
title(" 10-20 system - 19 channel EEG")
legend(electrodes)
%%
figure;
s_spatial = graph(:,spike_time);
subplot(1,2,1)
topoplot((s_spatial),eloc, 'electrodes','labels')
% topoplot((s_spatial),chanlocs,'electrodes', 'labels')
subplot(1,2,2)
headplot(s_spatial,'channelLocation/Standard-10-20-Cap19.spl')
suptitle('Headplot and topoplot')

%
%% Filtering and view spectrum 

% close all
% PSD_welch(graph);
% filter_graph = eeg_filtering(graph); %already
filter_graph = graph;
filter_graph = 1e6*filter_graph;
Px = PSD_welch(filter_graph); %power spectrum density estimation
title("Power spectrum density estimation")
