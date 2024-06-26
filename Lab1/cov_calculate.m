x1 = [1:10];
h1 = [1,1];
[result1,len_result1] = my_cov(x1,h1);
x2 = [1,2,3,9,4,5,6,0,7,8];
h2 = [-1,2,-1];
[result2,len_result2] = my_cov(x2,h2);
x3 = x1;
h3 = x1;
[result3,len_result3] = my_cov(x3,h3);

% 输出三幅图
subplot(3, 1, 1); 
plot(1:len_result1, result1);
xlabel('n');
ylabel('y');
title('Convolution of x=[1,2,...,10],h=[1,1]');
subplot(3, 1, 2); 
plot(1:len_result2, result2);
xlabel('n');
ylabel('y');
title('Convolution of x=[1,2,3,9,4,5,6,0,7,8],h=[-1,2,-1]');
subplot(3, 1, 3); 
plot(1:len_result3, result3);
xlabel('n');
ylabel('y');
title('Convolution of x=[1,2,...,10],h=[1,2,...,10]');