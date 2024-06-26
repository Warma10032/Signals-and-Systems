f = input('输入信号的频率');
N = input('输入采样点数');
T = input('输入采样间隔');
zero = input('输入补零个数（不补零则输入0）');
x1 = x(f, N, T);
if (zero > 0)
    x1 = [x1, zeros(1, zero)];
    N = N + zero;
end
X = myFFT(x1);
disp(X);
X = abs(X);
X = X/max(X);
freq=(0:N-1);

% 绘制频谱
figure;
stem(freq, X) % 使用 stem 来显示离散点

xlabel('k')
ylabel('|X(k)|')

function u = u(n)
    if (n >= 0)
        u = 1;
    else
        u = 0;
    end
end

function x = x(f, N, T)
    n = (0:N-1);
    x = sin(2*pi*f*n*T)*(u(n) - u(n - N));
end