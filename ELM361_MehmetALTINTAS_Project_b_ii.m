% Mehmet ALTINTAŞ - 1901022065
% ELEC 361 PROJE - PROBLEM B - OPTION II

% Parameters
f1 = 150;     % Message frequency 1 in Hz
f2 = 250;     % Message frequency 2 in Hz
A1 = 8;       % Amplitude for cos(2*pi*150*t)
A2 = 10;      % Amplitude for sin(2*pi*250*t)

fc = 1500;    % Carrier frequency in Hz
Ac = 10;      % Carrier amplitude

% Time settings
T = 1/50;         % One period of the combined baseband signal (0.02 s)
Fs = 100000;      % High sampling rate for better resolution (100 kHz)
t = 0:1/Fs:T-1/Fs; % Time vector

% Message and carrier signals
m = (A1*cos(2*pi*f1*t) + A2*sin(2*pi*f2*t)); % Message signal
c = Ac*cos(2*pi*fc*t);                      % Carrier signal

% DSB-SC Modulated signal
y = m .* c;

% Demodulator carrier
c_hat = cos(2*pi*1500*t); % Given as cos(3000*pi*t)

% Signal at the input of LPF (mixer output)
e = y .* c_hat;

% Plot the time-domain signal at LPF input
figure;
plot(t, e, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Demodulated Signal In Time Domain e(t) / Mehmet ALTINTAŞ - 1901022065');
grid on;

% Compute spectrum via FFT
N = length(e);
E = fft(e);
E_mag = abs(E)/N;           % Normalize the magnitude

% Frequency axis for plotting (two-sided)
f_axis = (-N/2:N/2-1)*(Fs/N);

% Shift FFT for plotting
E_mag_shifted = fftshift(E_mag);

% Define a threshold to remove near-zero amplitudes
threshold = 1e-3;            

% Identify indices where magnitude is above the threshold
nonzero_indices = E_mag_shifted > threshold;

% Filter the frequency axis and magnitude spectrum
f_axis_nonzero = f_axis(nonzero_indices);
E_mag_nonzero = E_mag_shifted(nonzero_indices);

% Plot the magnitude spectrum (two-sided)
figure;
stem(f_axis_nonzero, E_mag_nonzero, '^', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Demodulated Signal In Frequency Domain E(f) / Mehmet ALTINTAŞ - 1901022065');
xlim([-3500 3500]);          % Focus on frequencies up to ±3500 Hz
grid on;
