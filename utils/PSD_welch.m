function Px = PSD_welch(graph)
[n_channel, n_sample] = size(graph);
N_fft = 256;
window = 200;
noverlap = 0;
for i_channel=1:n_channel
   Pxx = pwelch(graph(i_channel,:), window,noverlap,N_fft);
   Pxx = 20.*log10(Pxx);
   Px(:,i_channel) = Pxx;
end
Fs = 256;
Fn = Fs/2;
f = [0:N_fft/2]/(N_fft/2)*Fn;
figure;
plot(f,Px)
xlabel('hz')
ylabel('Absolute power (log \muV^2)')
