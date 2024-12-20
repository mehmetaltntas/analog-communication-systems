% Mehmet ALTINTAŞ - 1901022065
% ELEC 361 PROJE - PROBLEM A

% Parameters
f1 = 150; % Hz
f2 = 250; % Hz
A1 = 8;
A2 = 10;

% Fundamental period to show one cycle of the combined waveform
T = 1/50;  % 0.02 s
Fs = 10000; % Sampling frequency (high enough to capture frequencies)
t = 0:1/Fs:T-1/Fs; 

% Message signal
m = A1*cos(2*pi*f1*t) + A2*sin(2*pi*f2*t);

% Plot the time-domain signal
figure;
plot(t, m, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Message Signal in Time domain m(t) / Mehmet ALTINTAŞ - 1901022065');
grid on;

% Compute the Fourier Transform (using FFT)
N = length(m);
M = fft(m);   % Discrete Fourier Transform
M_mag = abs(M)/N;  % Normalize the magnitude

% Frequency axis for plotting (two-sided)
f_axis = (-N/2:N/2-1)*(Fs/N);

% Shift FFT for plotting
M_mag_shifted = fftshift(M_mag);

% Define a threshold to remove near-zero amplitudes
threshold = 1e-3; % Adjust this value as needed

% Identify indices where magnitude is above the threshold
nonzero_indices = M_mag_shifted > threshold;

% Filter the frequency axis and magnitude spectrum
f_axis_nonzero = f_axis(nonzero_indices);
M_mag_nonzero = M_mag_shifted(nonzero_indices);

% Plot the magnitude spectrum (two-sided) 
figure;
stem(f_axis_nonzero, M_mag_nonzero, '^', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Message Signal in Frequency Domain M(f) / Mehmet ALTINTAŞ - 1901022065');
xlim([-300 300]); % Focus around the expected frequency lines
grid on;
