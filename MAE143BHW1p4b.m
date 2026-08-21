
Ts = 0.001; 
alpha = 2 / Ts;

z_lead = z;         
p_lead = p;         
zero_lag2 = z_lag2; 
pole_lag2 = p_lag2; 


num_lead = [1, z_lead];
den_lead = [1, p_lead];


num_lag2 = [1, 2*zero_lag2, zero_lag2^2];
den_lag2 = [1, 2*pole_lag2, pole_lag2^2];

num_lpf = G.num.poly;
den_lpf = G.den.poly;

num_s = conv(conv(num_lead, num_lag2), num_lpf);
den_s = conv(conv(den_lead, den_lag2), den_lpf);


N = max(length(num_s), length(den_s)) - 1; 
num_s = [zeros(1, N + 1 - length(num_s)), num_s];
den_s = [zeros(1, N + 1 - length(den_s)), den_s];


num_z = zeros(1, N + 1);
den_z = zeros(1, N + 1);

for k = 0:N
    
    idx = N + 1 - k; 
    
    
    term1 = 1;
    for i = 1:k, term1 = conv(term1, [1, -1]); end
    
    term2 = 1;
    for i = 1:(N - k), term2 = conv(term2, [1, 1]); end
    
    term_z = conv(term1, term2);
    
    
    num_z = num_z + num_s(idx) * (alpha^k) * term_z;
    den_z = den_z + den_s(idx) * (alpha^k) * term_z;
end


b_norm = num_z / den_z(1);
a_norm = den_z / den_z(1);


disp('Numerator coefficients (b0, b1, b2... for e[k], e[k-1]...):');
disp(b_norm');

disp('Denominator coefficients (1, a1, a2... for u[k], u[k-1]...):');
disp(a_norm');