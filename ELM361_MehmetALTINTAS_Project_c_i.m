% Mehmet ALTINTAŞ - 1901022065
% ELEC 361 PROJE - PROBLEM C - OPTION I

% Parameters
f1 = 150;    % Hz (message frequency 1)
f2 = 250;    % Hz (message frequency 2)
A1 = 8;      % Amplitude of cos(2*pi*150*t)
A2 = 10;     % Amplitude of sin(2*pi*250*t)
u = 0.7;     % The modulation index 𝜇
mp = 18;     % Peek value
m = 8*cos(2*pi*150*t) + 10*sin(2*pi*250*t); % Message signal m(t)
m_n =m ./mp; % Normalized signal

fc = 1500;   % Carrier frequency in Hz
Ac = 10;     % Carrier amplitude

% Time settings
T = 1/50;             % One period that includes multiple cycles of both tones (0.02 seconds)
Fs = 100000;          % Sampling frequency (100 kHz)
t = 0:1/Fs:T-1/Fs;    % Time vector



% Construct y(t) with specified frequency components
y = Ac .* (1+u.*m_n) .* cos(2*pi*fc*t);

% Plot y(t) in the time domain
figure;
plot(t, y, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('DSB-LC Modulated Signal in Time Domain y(t) / Mehmet ALTINTAŞ - 1901022065');

grid on;

% Compute Spectrum via FFT
N = length(y);
Y = fft(y);
Y_mag = abs(Y)/N;                % Normalize the magnitude

% Frequency axis for two-sided spectrum
f_axis = (-N/2:N/2-1)*(Fs/N);

% Shift FFT for plotting
Y_mag_shifted = fftshift(Y_mag);

% Define a threshold to remove near-zero amplitudes
threshold = 1e-3;                % Adjust this value as needed

% Identify indices where magnitude is above the threshold
nonzero_indices = Y_mag_shifted > threshold;

% Filter the frequency axis and magnitude spectrum
f_axis_nonzero = f_axis(nonzero_indices);
Y_mag_nonzero = Y_mag_shifted(nonzero_indices);

% Plot the magnitude spectrum 
figure;
stem(f_axis_nonzero, Y_mag_nonzero, '^', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('DSB-LC Modulated Signal in Frequency Domain Y(f) / Mehmet ALTINTAŞ - 1901022065');
xlim([-2000 2000]);               % Focus on the relevant frequency range
grid on;
