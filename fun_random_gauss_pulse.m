function result = fun_random_gauss_pulse(t,signal_freq,pulse_rate,mu,sigma)
% tham khao code: https://www.mathworks.com/help/signal/ref/pulstran.html
% p(t) = @(t) fun_random_gauss_pulse(t,signal_freq,pulse_rate,mu,sigma)
% signal_freq: decay rate each pulse 
% mu, sigma: mean and standard deviation of pulse 
%
    rng('shuffle')
    t = t - floor(t * pulse_rate) / pulse_rate;
    pp = mu +(sigma*rand(size(t))).*exp(-signal_freq*abs(t));
    result = pp;
        
%     t0 =inf  ;n = 7; w = 0.005;q = 0.5;
%     vt = (q*((t-t0)/w).^n.* exp(-(t-t0)/w)).*double(t>t0);
%     vt(isnan(vt)) = 0;
%     result = pp + vt;

end

