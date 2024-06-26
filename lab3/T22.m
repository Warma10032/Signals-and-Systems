% 参数设置
N = 33; % 滤波器的长度
wc = pi/2; % 截止频率
M1 = fix(wc/(2*pi/N)); 
M2 = N - 2 * M1 - 1; 
theta = -pi * (0:N-1) * (N-1) / N; 
resolution = 512; % 设置频率响应的分辨率

% 设计第一个滤波器
T1 = 0.3;
A1 = [ones(1, M1), T1, zeros(1, M2), T1, ones(1, M1-1)];
h1 = computeFilterResponse(A1, theta);
[H1, w1] = manualFreqz(h1, resolution);

% 设计第二个滤波器
T2 = 0.3; T3 = 0.6;
A2 = [ones(1, M1), T2, T3, zeros(1, M2-2), T3, T2, ones(1, M1-1)];
h2 = computeFilterResponse(A2, theta);
[H2, w2] = manualFreqz(h2, resolution);

% 绘制两个滤波器的幅度响应图
subplot(1, 2, 1);
plot(w1/pi, abs(H1), w2/pi, abs(H2), 'r');
grid on;
xlabel('频率(单位\pi)');
ylabel('幅度');


dbH1 = 20 * log10(abs(H1) / max(abs(H1)));
dbH2 = 20 * log10(abs(H2) / max(abs(H2)));

% 绘制两个滤波器的分贝幅度响应图
subplot(1, 2, 2);
plot(w1/pi, dbH1, w2/pi, dbH2, 'r');
grid on;
xlabel('频率(单位\pi)');
ylabel('幅度');

function [H, w] = manualFreqz(h, N)
    H_full = fft(h, N); % 使用FFT计算频率响应
    H = H_full(1:N/2+1); 
    w = 2 * pi * (0:N/2) / N;
end

function h = computeFilterResponse(A, theta)
    Hk = A .* exp(1i * theta);
    h = real(ifft(Hk));
end
