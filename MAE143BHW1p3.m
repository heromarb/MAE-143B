
n = 4;

% 3a: Butterworth Filter 
omegac_butter = 301; 
F = RR_LPF_butterworth(n, omegac_butter);

% 3b: Inverse Chebyshev Filter 
omegac_cheb = 524;
delta = 0.1;
G = RR_LPF_inv_chebyshev(n, delta, omegac_cheb);

% --- Figure 1: Butterworth Bode Plot (3a) ---
figure(1);
RR_bode(F);
title('4th-Order Butterworth Filter Bode Plot');

% --- Figure 2: Overlaid Bode Plots (3b) ---
figure(2);
RR_bode(F);
hold on;
RR_bode(G);
title('Butterworth vs. Inverse Chebyshev Filters');
legend('4th-Order Butterworth', '4th-Order Inverse Chebyshev');
hold off;