% Mehmet ALTINTAŞ - 1901022065
% ELEC 361 PROJE - PROBLEM B - OPTION I

% Parameters
f1 = 150;    % Message frequency 1 in Hz
f2 = 250;    % Message frequency 2 in Hz
A1 = 8;      % Amplitude of the first cosine in m(t)
A2 = 10;     % Amplitude of the second sine in m(t)

fc = 1500;   % Carrier frequency in Hz
Ac = 10;     % Carrier amplitude

% Time parameters
T = 1/50;                   % Fundamental period to capture all components (0.02 s)
Fs = 100000;                % Sampling frequency for better frequency resolution
t = 0:1/Fs:T-1/Fs;          % Time vector

% Message signal
m = A1*cos(2*pi*f1*t) + A2*sin(2*pi*f2*t);

% Carrier signal
c = Ac*cos(2*pi*fc*t);

% DSB-SC modulated signal
y = m .* c;

% Plot time-domain signal
figure;
plot(t, y, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('DSB-SC Modulated Signal in Time Domain y(t) / Mehmet ALTINTAŞ - 1901022065');
grid on;

% Compute spectrum via FFT
N = length(y);
Y = fft(y);
Y_mag = abs(Y)/N;           % Normalize the magnitude

% Frequency axis for plotting (two-sided)
f_axis = (-N/2:N/2-1)*(Fs/N);

% Shift FFT for plotting
Y_mag_shifted = fftshift(Y_mag);

% Define a threshold to remove near-zero amplitudes
threshold = 1e-3;            % Adjust this value as needed

% Identify indices where magnitude is above the threshold
nonzero_indices = Y_mag_shifted > threshold;

% Filter the frequency axis and magnitude spectrum
f_axis_nonzero = f_axis(nonzero_indices);
Y_mag_nonzero = Y_mag_shifted(nonzero_indices);

% Plot the magnitude spectrum (two-sided) 
figure;
stem(f_axis_nonzero, Y_mag_nonzero, '^', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title(' DSB-SC Modulated Signal in Frequency Domain Y(f) / Mehmet ALTINTAŞ - 1901022065');
xlim([-2000 2000]);           % Focus on frequencies up to ±2000 Hz
grid on;
