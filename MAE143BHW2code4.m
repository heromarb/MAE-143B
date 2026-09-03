%% Lead Compensator - F16,13 Verification

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

%% Plant using F16,13 Pade approximation
G = RR_pade(d,16,13)*RR_tf(1,[1/a0 1]);

%% Same lead compensator
K = 0.47;
z = 0.1;
p = 0.05;

D = RR_tf(K*[1 z],[1 p]);

%% Same loop prefactor
P = 2.0639;

%% Root locus
figure(1)
RR_rlocus(G,D)
axis([-5 2 -3 3])
grid on
title('Root Locus: Lead Compensator with F16,13')

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
title('Temperature Response: F16,13')

yline(45,'--')
yline(44.5,':')
yline(45.5,':')

%% Settling time
idx = find(abs(y - 45) < 0.5);

if ~isempty(idx)
    settling_time = t(idx(1));
    disp(['F16,13 settling time = ', ...
        num2str(settling_time),' s'])
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
title('Control Input: F16,13')

yline(50,'--')
yline(10,'--')

%% Maximum control input
max_u = max(u);

disp(['F16,13 maximum control input = ', ...
    num2str(max_u),' deg C'])