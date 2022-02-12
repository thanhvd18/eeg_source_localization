function X_segment  = get_spike_segment(filter_graph,Spk_event,electrodes,selected_spike,is_plot)
%filter_graph: number electrode x time
%Spk_event: spike time and channel label
% electrodes:  electrode indices and name
%selected_spike: index of spike 1-> #spikes


spike_channel = Spk_event(selected_spike,3);
if spike_channel >19
    spike_channel = spike_channel -2;
end
spike_time = Spk_event(selected_spike,2);
delta_t = 64; %64 sample ~ 0.25s
%plot spike segment

if is_plot
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

X_segment = filter_graph(:,spike_time-delta_t:spike_time+delta_t);
end