%% RR_temp_controlled_bath_feedback
% MAE 143B HW2
% Linear feedback control using F2,2 Pade approximation

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

%% Plant using F2,2 Pade approximation
G = RR_pade(d,2,2)*RR_tf(1,[1/a0 1]);

%% Proportional controller
K = 1;
D = RR_tf(K);

%% Loop prefactor
P = 1/0.5;

%% Root locus
figure(1)
RR_rlocus(G,D)
axis([-.4 .3 -.3 .3])
grid on
title('Root Locus: Proportional Controller K = 1')

%% Temperature response
figure(2)
g.T = 200;

RR_step(35 + 10*P*G*D/(1+G*D),g)

axis([0 200 32 55])
grid on
xlabel('Time (s)')
ylabel('Bath Temperature (deg C)')
title('Temperature Response: K = 1')

%% Control input response
figure(3)

RR_step(35 + 10*P*D/(1+G*D),g)

axis([0 200 40 60])
grid on
xlabel('Time (s)')
ylabel('Control Input (deg C)')
title('Control Input: K = 1')