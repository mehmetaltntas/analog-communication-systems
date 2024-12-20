% Mehmet ALTINTAŞ - 1901022065
% ELEC 361 PROJE - PROBLEM C - OPTION II

% Parameters
Fs = 100000; % Sampling frequency
T = 1/50;    % Duration: one period that includes both message frequencies cycles
t = 0:1/Fs:T-1/Fs;

% Given AM signal parameters
A_c = 10;
A_side = 28/18; % ~1.5556
A_side2 = 35/18; % ~1.9444

fc = 1500;
f_lower1 = 1350; % fc - 150
f_upper1 = 1650; % fc + 150
f_lower2 = 1250; % fc - 250
f_upper2 = 1750; % fc + 250

% Construct y(t)
y = A_c*cos(2*pi*fc*t) ...
  + A_side*cos(2*pi*f_lower1*t) ...
  + A_side*cos(2*pi*f_upper1*t) ...
  + A_side2*sin(2*pi*f_upper2*t) ...
  - A_side2*sin(2*pi*f_lower2*t);

% Full-wave rectification
rect_y = abs(y);

% FFT of the rectified signal
N = length(rect_y);
Y_rect = fft(rect_y);
f_axis = (0:N-1)*(Fs/N); 

% Define cutoff frequency for LPF
% The highest message frequency is 250 Hz, so choose a cutoff safely above that
f_cutoff = 500; % Hz

% Create a low-pass filter mask in frequency domain
% Pass frequencies <= f_cutoff and also the mirrored part near Fs-f_cutoff
H = double(f_axis <= f_cutoff) + double(f_axis >= (Fs - f_cutoff));

% Apply the low-pass filter
Y_filtered = Y_rect .* H;

% Inverse FFT to obtain the smooth envelope
envelope = ifft(Y_filtered, 'symmetric');

% Remove DC offset
DC_level = mean(envelope);
demodulated = envelope - DC_level;

% Plot the demodulated signal
figure;
plot(t, demodulated, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Demodulated Signal (Envelope - DC) / Mehmet ALTINTAŞ - 1901022065');
grid on;
