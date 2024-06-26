% 参数释义input_matrix：被卷积矩阵，padding_height：要填充的高度，取决于卷积核的高度，padding_width：要填充的宽度，取决于卷积核的宽度，padding_value：填充的常数值
function padded_matrix = constant_padding(input_matrix, padding_height, padding_width, padding_value)
    % 获取输入矩阵的大小
    [input_height, input_width] = size(input_matrix);
    
    % 计算填充后的矩阵大小
    padded_height = input_height + 2 * padding_height;
    padded_width = input_width + 2 * padding_width;
    
    % 初始化填充后的矩阵
    padded_matrix = zeros(padded_height, padded_width);
    
    % 将输入矩阵复制到填充后的矩阵的中心位置
    padded_matrix(padding_height + 1:padding_height + input_height, padding_width + 1:padding_width + input_width) = input_matrix;
    
    % 对填充区域进行填充
    % 填充上方
    padded_matrix(1:padding_height, :) = padding_value;
    % 填充下方
    padded_matrix(end-padding_height+1:end, :) = padding_value;
    % 填充左侧
    padded_matrix(:, 1:padding_width) = padding_value;
    % 填充右侧
    padded_matrix(:, end-padding_width+1:end) = padding_value;
end
