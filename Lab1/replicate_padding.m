% 参数释义input_matrix：被卷积矩阵，padding_height：要填充的高度，取决于卷积核的高度，padding_width：要填充的宽度，取决于卷积核的宽度
function padded_matrix = replicate_padding(input_matrix, padding_height, padding_width)
    % 获取输入矩阵的大小
    [input_height, input_width] = size(input_matrix);
    
    % 计算填充后的矩阵大小
    padded_height = input_height + 2 * padding_height;
    padded_width = input_width + 2 * padding_width;
    
    % 初始化填充后的矩阵
    padded_matrix = zeros(padded_height, padded_width);
    
    % 将输入矩阵复制到填充后的矩阵的中心位置
    padded_matrix(padding_height + 1:padding_height + input_height, padding_width + 1:padding_width + input_width) = input_matrix;
    
    % 复制边界值
    % 复制上方边界
    for i = 1:padding_height
        padded_matrix(i, :) = padded_matrix(padding_height + 1, :);
    end
    % 复制下方边界
    for i = 1:padding_height
        padded_matrix(end - i + 1, :) = padded_matrix(end - padding_height, :);
    end
    % 复制左侧边界
    for j = 1:padding_width
        padded_matrix(:, j) = padded_matrix(:, padding_width + 1);
    end
    % 复制右侧边界
    for j = 1:padding_width
        padded_matrix(:, end - j + 1) = padded_matrix(:, end - padding_width);
    end
end
