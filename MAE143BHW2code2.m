%% Proportional Controller: Reduced K

clear;
close all;
clc;

%% System parameters
T0 = 35;
T1 = 45;
Tmax = 50;
Tmin = 10;

a0 = 0.02;
d = 12;

%% Plant
G = RR_pade(d,2,2)*RR_tf(1,[1/a0 1]);

%% Reduced proportional gain
K = 0.488;
D = RR_tf(K);

%% Loop prefactor
G0 = 1;
P = (1 + G0*K)/(G0*K);

%% Root locus
figure(1)
RR_rlocus(G,D)
axis([-.4 .3 -.3 .3])
grid on
title('Root Locus: K = 0.488')

%% Temperature response
figure(2)
g.T = 200;

[t,~,y] = RR_plot_response( ...
    35 + 10*P*G*D/(1+G*D), ...
    0, g);

grid on
hold on
axis([0 200 34 55])

xlabel('Time (s)')
ylabel('Bath Temperature (deg C)')
title('Temperature Response: K = 0.488')

%% Find first entry into settling band
idx = find(abs(y - 45) < 0.5);

if ~isempty(idx)
    settling_time = t(idx(1));
    disp(['Settling time = ',num2str(settling_time),' s'])
end

%% Control input
figure(3)

[t,u,~] = RR_plot_response( ...
    35 + 10*P*D/(1+G*D), ...
    0, g);

grid on
hold on
axis([0 200 40 60])

xlabel('Time (s)')
ylabel('Control Input (deg C)')
title('Control Input: K = 0.488')

disp(['Maximum control input = ',num2str(max(u)),' deg C'])