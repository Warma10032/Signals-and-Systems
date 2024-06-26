function pascalTriangle(rows)
% 初始化一个空矩阵来存储杨辉三角
    triangle = zeros(rows);

     % 填充杨辉三角
    for i = 1:rows
        for j = 1:i
            if j == 1 || j == i
                triangle(i,j) = 1;
            else
                triangle(i,j) = triangle(i-1,j-1) + triangle(i-1,j);
            end
        end
    end

    % 以正三角形式输出杨辉三角到控制台
    for i = 1:rows
        fprintf('%*s', 2*(rows-i), '');
        for j = 1:i
            fprintf('%4d', triangle(i,j));
        end
        fprintf('\n');
    end
end