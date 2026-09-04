clear;
close all;
clc;

% Given parameters
d = 0.1;
a = 1;

% Plant using 2,2 Pade approximation
G = RR_pade(d,2,2)*RR_tf(1,[1 a]);

% Start with D = 1
D = 1;

% Open-loop system
L = G*D;

%Root locus
figure(1);
RR_rlocus(G*D);
title('Root Locus - 2,2 Pade Approximation');

% Find imaginary-axis crossing frequency

omega = fzero(@(w) ...
    imag(RR_evaluate(-1/L,1i*w)),[15 18]);

% Calculate critical gain
Kcrit22 = real(RR_evaluate(-1/L,1i*omega));

% Plot root locus at calculated critical gain
figure(2);
D = Kcrit22;
RR_rlocus(G*D);
title('Root Locus at Critical Gain');


% 16,12 Pade approximation


% Plant using 16,12 Pade approximation
G1612 = RR_pade(d,16,12)*RR_tf(1,[1 a]);

D = 1;

% Open-loop system
L1612 = G1612*D;

% Root locus
figure(3);
RR_rlocus(G1612*D);
title('Root Locus - 16,12 Pade Approximation');

% Find imaginary-axis crossing frequency

omega1612 = fzero(@(w) ...
    imag(RR_evaluate(-1/L1612,1i*w)),[15 18]);

% Calculate critical gain
Kcrit1612 = real(RR_evaluate(-1/L1612,1i*omega1612));


% Nyquist plots

Khalf = Kcrit22/2;
Kdouble = 2*Kcrit22;

omega_nyq = logspace(-3,4,5000);

% FIGURE 4: Nyquist plot at HALF critical gain

D = Khalf;
Lhalf = G*D;

% Evaluate positive-frequency response
Lhalf_pos = arrayfun(@(w) ...
    RR_evaluate(Lhalf,1i*w),omega_nyq);

% Construct negative-frequency response using conjugate symmetry
Lhalf_neg = conj(fliplr(Lhalf_pos));

% Complete Nyquist contour
Lhalf_full = [Lhalf_neg Lhalf_pos];

figure(4);
plot(real(Lhalf_full),imag(Lhalf_full),'LineWidth',1.5);
hold on;
plot(-1,0,'kx','MarkerSize',12,'LineWidth',2);
grid on;
xlabel('Real\{L(i\omega)\}');
ylabel('Imag\{L(i\omega)\}');
title(sprintf('Nyquist Plot, K = %.4f',Khalf));
axis equal;
hold off;

% FIGURE 5: Nyquist plot at DOUBLE critical gain

D = Kdouble;
Ldouble = G*D;

% Evaluate positive-frequency response
Ldouble_pos = arrayfun(@(w) ...
    RR_evaluate(Ldouble,1i*w),omega_nyq);

% Construct negative-frequency response
Ldouble_neg = conj(fliplr(Ldouble_pos));

% Complete Nyquist contour
Ldouble_full = [Ldouble_neg Ldouble_pos];

figure(5);
plot(real(Ldouble_full),imag(Ldouble_full),'LineWidth',1.5);
hold on;
plot(-1,0,'kx','MarkerSize',12,'LineWidth',2);
grid on;
xlabel('Real\{L(i\omega)\}');
ylabel('Imag\{L(i\omega)\}');
title(sprintf('Nyquist Plot, K = %.4f',Kdouble));
axis equal;
hold off;

