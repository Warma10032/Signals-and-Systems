function X = myFFT(x)
    N = length(x);
    if N == 2
        X = [x(1)+x(2), x(1)-x(2)];
        return;
    end
    
    X_even = myFFT(x(1:2:end));  % 处理偶数索引的元素
    X_odd  = myFFT(x(2:2:end));  % 处理奇数索引的元素
    W = exp(-2i * pi * (0:N/2-1) / N); % 计算旋转因子
    
    % 结合结果
    X = [X_even + W .* X_odd, X_even - W .* X_odd];
end