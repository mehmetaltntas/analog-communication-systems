% Mehmet ALTINTAŞ - 1901022065
% ELEC 361 PROJE - PROBLEM B - OPTION III

% Parameters
f1 = 150;    % Hz (message frequency 1)
f2 = 250;    % Hz (message frequency 2)
A1 = 8;
A2 = 10;

fc = 1500;   % carrier frequency
Ac = 10;     % carrier amplitude

% Time settings
T = 1/50;    % One period
Fs = 100000; % Sampling frequency
t = 0:1/Fs:T-1/Fs;

% Message signal
m = A1*cos(2*pi*f1*t) + A2*sin(2*pi*f2*t);

% DSB-SC modulation
c = Ac*cos(2*pi*fc*t);
y = m .* c; % DSB-SC modulated signal

% Demodulator carrier
c_hat = cos(2*pi*fc*t);

% Signal at the input of LPF (mixer output)
e = y .* c_hat;

% Frequency-domain low-pass filter
% --------------------------------
% Define cutoff frequency
f_cutoff = 500; % in Hz

N = length(e);
E = fft(e);
f_axis = (0:N-1)*(Fs/N);  % frequency axis from 0 to Fs-Δf

% Shift frequency axis to range [-Fs/2, Fs/2)
f_axis_shifted = f_axis - Fs*(f_axis >= Fs/2);

% Find indices that correspond to frequencies outside the low-pass band
low_pass_indices = abs(f_axis_shifted) <= f_cutoff;

% Construct a filter mask
H = zeros(size(E));
H(low_pass_indices) = 1;  % 1 inside cutoff, 0 outside

% Apply filter
E_filtered = E .* H;

% Reconstruct time-domain signal
z = ifft(E_filtered, 'symmetric');

% Plot the time-domain output of LPF
figure;
plot(t, z, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Output of the LPF z(t) / Mehmet ALTINTAŞ - 1901022065');
grid on;

% Compute and plot the spectrum of z(t)
Z_fft = fft(z);
Z_mag = abs(Z_fft)/N;
f_axis_plot = (-N/2:N/2-1)*(Fs/N);
Z_mag_shifted = fftshift(Z_mag);

% Define frequencies to keep and tolerance
keep_freqs = [-250, -150, 150, 250]; % in Hz
tol = 10; % tolerance in Hz

% Initialize mask
mask = false(size(f_axis_plot));

% Create mask for desired frequencies within the tolerance
for k = 1:length(keep_freqs)
    mask = mask | (abs(f_axis_plot - keep_freqs(k)) <= tol);
end

% Apply mask to the magnitude spectrum
Z_mag_shifted_filtered = Z_mag_shifted .* mask;

% **Remove zero amplitude values from the plot**
% Find indices where magnitude is greater than zero
nonzero_indices = Z_mag_shifted_filtered > 0;

% Extract only the non-zero frequency components
f_nonzero = f_axis_plot(nonzero_indices);
Z_nonzero = Z_mag_shifted_filtered(nonzero_indices);

% Plot the filtered spectrum with only the selected frequencies
figure;
stem(f_nonzero, Z_nonzero, '^', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Output of LPF Spectrum Z(f)  / Mehmet ALTINTAŞ - 1901022065');
xlim([-300 300]); % Focus on low frequencies
grid on;
