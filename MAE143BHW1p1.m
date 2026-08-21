% Define your calculated zero and pole
z = 2.672;
p = 37.41;

num_lead = [1, z]; 
den_lead = [1, p]; 

D_lead = RR_tf(num_lead, den_lead);

% Generate the Bode plot
figure;
RR_bode(D_lead);
title('Bode Plot of Lead Compensator');