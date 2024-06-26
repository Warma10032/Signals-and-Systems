clc; clear;

% 读取音频文件并转换为单声道
[x, fs] = audioread('music.wav');
x = (x(:, 1))'; % 转置为行向量

% 获取信号长度
FS = length(x);

% 计算FFT
X = fft(x);

% 时间轴
t = (0:FS-1) / fs;

% 低通滤波器设计参数
Fp_lp = 1000; % 低通滤波器通带截止频率 (Hz)
Fs_lp = 1200; % 低通滤波器阻带截止频率 (Hz)
Ft = fs; % 采样频率
wp_lp = 2*pi*Fp_lp/Ft;
N_lp = 100; % 滤波器阶数

% 设计低通滤波器
h_lp = fir1_lp(N_lp, wp_lp);

% 应用低通滤波器
y1 = filter(h_lp, 1, x);

% 高通滤波器设计参数
Fp_hp = 5000; % 高通滤波器通带截止频率 (Hz)
Fs_hp = 4800; % 高通滤波器阻带截止频率 (Hz)
wp_hp = 2*pi*Fp_hp/Ft;
N_hp = 100; % 滤波器阶数

% 设计高通滤波器
h_hp = fir1_hp(N_hp, wp_hp);

% 应用高通滤波器
y2 = filter(h_hp, 1, x);

% 绘制原始和滤波后的信号时域波形和频谱
figure;

% 原始信号时域波形
subplot(3, 2, 1);
plot(t, x);
title('原始语音信号时域波形');
xlabel('时间');
ylabel('幅值');
grid on;

% 原始信号频谱
subplot(3, 2, 2);
yy = abs(X);
f = (0:floor(FS/2)-1)*(fs/FS); % 计算频率轴
plot(f, yy(1:floor(FS/2)));
title('原始语音信号频谱');
xlabel('频率 (Hz)');
ylabel('幅度');
grid on;

% 低通滤波后信号时域波形
subplot(3, 2, 3);
plot(t, y1);
title('低通滤波后信号时域波形');
xlabel('时间');
ylabel('幅值');
grid on;

% 低通滤波后信号频谱
subplot(3, 2, 4);
yy_lp = abs(fft(y1));
plot(f, yy_lp(1:floor(FS/2)));
title('低通滤波后信号频谱');
xlabel('频率 (Hz)');
ylabel('幅度');
grid on;

% 高通滤波后信号时域波形
subplot(3, 2, 5);
plot(t, y2);
title('高通滤波后信号时域波形');
xlabel('时间');
ylabel('幅值');
grid on;

% 高通滤波后信号频谱
subplot(3, 2, 6);
yy_hp = abs(fft(y2));
plot(f, yy_hp(1:floor(FS/2)));
title('高通滤波后信号频谱');
xlabel('频率 (Hz)');
ylabel('幅度');
grid on;

% 手动实现低通FIR滤波器设计函数
function h = fir1_lp(N, wc)
    n = 0:N;
    alpha = N / 2;
    m = n - alpha;
    h = sin(wc * m) ./ (pi * m); % 理想低通滤波器冲激响应
    h(alpha + 1) = wc / pi; 
    h = h .* (0.54 - 0.46 * cos(2 * pi * n / N)); % Hamming窗
end

% 手动实现高通FIR滤波器设计函数
function h = fir1_hp(N, wc)
    n = 0:N;
    alpha = N / 2;
    m = n - alpha;
    h = -sin(wc * m) ./ (pi * m); % 理想高通滤波器冲激响应
    h(alpha + 1) = 1 - wc / pi;
    h = h .* (0.54 - 0.46 * cos(2 * pi * n / N)); % Hamming窗
end
