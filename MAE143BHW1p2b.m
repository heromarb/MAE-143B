
z_lag2 = 0.48; 
p_lag2 = 0.048; 


num_lag2 = [1, 2*z_lag2, z_lag2^2]; 
den_lag2 = [1, 2*p_lag2, p_lag2^2];

% Create and plot
D_lag2 = RR_tf(num_lag2, den_lag2);

figure;
RR_bode(D_lag2);
title('Bode Plot of Double Lag Compensator (2b)');