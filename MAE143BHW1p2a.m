
z_lag1 = 0.88; 
p_lag1 = 0.0088; 


num_lag1 = [1, z_lag1]; 
den_lag1 = [1, p_lag1];

% Create and plot
D_lag1 = RR_tf(num_lag1, den_lag1);

figure;
RR_bode(D_lag1);
title('Bode Plot of Single Lag Compensator (2a)');