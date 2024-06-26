function result = matrix_cov(input_matrix, conv_kernel, padding_method)
    % 获取输入矩阵和卷积核的大小
    [input_height, input_width] = size(input_matrix);
    [kernel_height, kernel_width] = size(conv_kernel);
    
    % 计算填充的大小
    padding_height = floor(kernel_height / 2);
    padding_width = floor(kernel_width / 2);
    
    % 根据填充方法对输入矩阵进行填充
    if strcmp(padding_method, 'constant')
        padded_matrix = constant_padding(input_matrix, padding_height, padding_width, 0)
    elseif strcmp(padding_method, 'replicate')
        padded_matrix = replicate_padding(input_matrix, padding_height, padding_width)
    else
        error('Unknown padding method');
    end
    
    % 初始化卷积结果矩阵
    result = zeros(input_height, input_width);
    
    % 执行卷积操作
    for i = 1:input_height
        for j = 1:input_width
            % 计算(i, j)点的卷积结果
            conv_result = 0;
            for m = 1:kernel_height
                for n = 1:kernel_width
                    % 计算卷积结果的中心点位置
                    conv_result = conv_result + padded_matrix(i+m-1, j+n-1) * conv_kernel(m, n);
                end
            end
            % 将卷积结果填入结果矩阵中
            result(i, j) = conv_result;
        end
    end
end
