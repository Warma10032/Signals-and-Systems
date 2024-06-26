% 参数设置
wp = 0.2 * pi; % 通带截止频率
ws = 0.4 * pi; % 阻带截止频率
As = 50; % 阻带最小衰减（dB）

delta_w = ws - wp; % 过渡带宽
N = ceil((As - 8) / (2.285 * delta_w)); % 估算滤波器阶次

if mod(N, 2) == 0
    N = N + 1; 
end

n = 0:N-1;
wc = (wp + ws) / 2; % 截止频率
hd = sin(wc * (n - (N-1)/2)) ./ (pi * (n - (N-1)/2));
hd((N-1)/2 + 1) = wc / pi; 

% 汉明窗
w = 0.54 - 0.46 * cos(2 * pi * n / (N-1));

% 实际滤波器的单位脉冲响应
h = hd .* w;

% 计算频率响应
N_fft = 1024; 
H = fft(h, N_fft); % 计算频率响应
H = H(1:N_fft/2+1); 
W = (0:N_fft/2) * (2*pi/N_fft); % 归一化频率

% 绘制图形
figure;

subplot(5, 1, 1);
stem(n, w, 'filled');
title('汉明窗');
xlabel('n');
ylabel('w[n]');

subplot(5, 1, 2);
stem(n, hd, 'filled');
title('理想单位脉冲响应');
xlabel('n');
ylabel('hd[n]');

subplot(5, 1, 3);
stem(n, h, 'filled');
title('实际单位脉冲响应');
xlabel('n');
ylabel('h[n]');

subplot(5, 1, 4);
plot(W/pi, 20*log10(abs(H)));
title('幅频响应 (dB)');
xlabel('归一化频率 (\times\pi rad/sample)');
ylabel('幅度 (dB)');
ylim([-100 10]);

subplot(5, 1, 5);
plot(W/pi, angle(H));
title('相频响应');
xlabel('归一化频率 (\times\pi rad/sample)');
ylabel('相位 (弧度)');

