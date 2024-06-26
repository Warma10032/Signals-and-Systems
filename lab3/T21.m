%参数
wc = pi / 2; % 截止频率
N1 = 33; % 滤波器1阶数为33
N2 = 63; % 滤波器2阶数为63

% 设计两个滤波器
h1 = design_filter(N1, wc);
h2 = design_filter(N2, wc);

% 计算频率响应
fftLength = 1024;
H1 = fft(h1, fftLength);
H2 = fft(h2, fftLength);
W = linspace(0, 1, fftLength / 2) * pi;

% 绘图
figure;
subplot(2,1,1);
plot(W, 20*log10(abs(H1(1:fftLength/2))));
title('N=33的FIR低通滤波器幅度响应');
xlabel('归一化频率 (\times \pi rad/sample)');
ylabel('幅度 (dB)');

subplot(2,1,2);
plot(W, 20*log10(abs(H2(1:fftLength/2))));
title('N=63的FIR低通滤波器幅度响应');
xlabel('归一化频率 (\times \pi rad/sample)');
ylabel('幅度 (dB)');

% 手动实现Hamming窗函数
function w = manual_hamming(N)
    n = 0:N-1;
    w = 0.54 - 0.46 * cos(2 * pi * n / (N-1));
end

% 设计滤波器函数
function h = design_filter(N, wc)
    n = 0:N-1;
    sinc_part = sin(wc * (n - (N-1)/2)) ./ (pi * (n - (N-1)/2)); % 理想的冲击响应
    sinc_part((N-1)/2 + 1) = wc / pi; % 中心点，处理除零情况
    w = manual_hamming(N); 
    h = sinc_part .* w; % 实际的冲击响应
end
