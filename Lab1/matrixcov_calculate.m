input_matrix = [0 1 0; 1 1 1; 0 1 0];
conv_kernel = input_matrix;

% 使用常数填充
result_constant = matrix_cov(input_matrix, conv_kernel, 'constant')

% 使用边界复制填充
result_replicate = matrix_cov(input_matrix, conv_kernel, 'replicate')
