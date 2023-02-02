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

selected_spike = 1;
% plotChannel(graph,Spk_event,selected_spike)
% function plotChannel(graph,Spk_event,selected_spike)

spike_time = Spk_event(selected_spike,2);
delta_t = 64; %64 sample ~ 0.25s


graph = average_montage(graph);
filter_graph = graph;
filter_graph = 1e6*filter_graph;

if istable(Spk_event),Spk_event = table2array(Spk_event), end;
spike_channel = double(Spk_event(selected_spike,3));
if spike_channel >19
    spike_channel = spike_channel -2;
end
if spike_channel ~= 1
    plot(spike_time-delta_t:spike_time+delta_t,filter_graph(spike_channel,spike_time-delta_t:spike_time+delta_t)','b', 'linewidth', 1.5);
end
hold on;
plot(spike_time-delta_t:spike_time+delta_t,filter_graph([1:spike_channel-1, spike_channel+1:end],spike_time-delta_t:spike_time+delta_t)');
hold on;
plot(spike_time,filter_graph(spike_channel,spike_time),'r*', 'MarkerSize', 10,'linewidth', 2)

ylabel('\muV')
xlabel('Sample')
title(" 10-20 system - 19 channel EEG")
legend(electrodes)
end

