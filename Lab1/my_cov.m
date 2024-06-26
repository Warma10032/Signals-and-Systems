function [result,len_result] = my_cov(x, h)
    % 获取输入序列的长度
    len_x = length(x);
    len_h = length(h);
    
    % 计算卷积结果的长度
    len_result = len_x + len_h - 1;
    
    % 初始化卷积结果数组
    result = zeros(1, len_result);
    
    % 计算卷积
    for n = 1:len_result
        % 计算当前卷积结果的值
        for k = max(1, n - len_h + 1):min(len_x, n)
            result(n) = result(n) + x(k) * h(n-k+1);
        end
    end
    disp(result)
end
