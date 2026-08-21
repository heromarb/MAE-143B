
clear; close all;


num_G = [100];
den_G = [1, 0, -100];
G = RR_tf(num_G, den_G);

z_simple = 10;
p_simple = 19.3;
num_simple = [1, z_simple];
den_simple = [1, p_simple];
D_simple = RR_tf(num_simple, den_simple);

num_L1 = conv(num_G, num_simple);
den_L1 = conv(den_G, den_simple);
L1 = RR_tf(num_L1, den_L1);


z_lead = 2.672; p_lead = 37.41;
num_lead = [1, z_lead]; den_lead = [1, p_lead];

z_lag2 = 0.48; p_lag2 = 0.048;
num_lag2 = [1, 2*z_lag2, z_lag2^2]; den_lag2 = [1, 2*p_lag2, p_lag2^2];


n = 4; delta = 0.1; omegac_cheb = 524;
D_lpf = RR_LPF_inv_chebyshev(n, delta, omegac_cheb);


num_Ls_unscaled = conv(conv(num_lead, num_lag2), D_lpf.num.poly);
den_Ls_unscaled = conv(conv(den_lead, den_lag2), D_lpf.den.poly);


num_L2_unscaled = conv(num_G, num_Ls_unscaled);
den_L2_unscaled = conv(den_G, den_Ls_unscaled);
L2_unscaled = RR_tf(num_L2_unscaled, den_L2_unscaled);


K = 7.48; 
L2 = RR_tf(K * num_L2_unscaled, den_L2_unscaled);


figure(1);

subplot(1,2,1);
RR_rlocus(L1);
title('Root Locus: Simple Lead G*D_{simple}');
xlim([-25, 5]);   
ylim([-15, 15]);  

subplot(1,2,2);
RR_rlocus(L2);
title('Root Locus: Loop-Shaping G*D_{loop}');
xlim([-100, 20]); 
ylim([-100, 100]);

figure(2);
subplot(2,1,1);
RR_bode(L1);
hold on;
RR_bode(L2);
legend('Simple Lead', 'Loop-Shaping');
title('Bode Comparison');
hold off;
