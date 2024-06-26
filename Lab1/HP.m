% 初始化小怪的初始血量
initial_health = 100;

% 初始化每次攻击的掉血效果
damage_per_second = [5, 4, 3, 2, 1];

% 模拟3次技能攻击，分别在第一秒，第二秒，第三秒进行攻击
attack = [1,1,1];

% 通过卷积计算每秒损失的血量
[damage,len_damage] = my_cov(attack,damage_per_second);
    
% 定义每秒血量值，并用每秒损失血量迭代计算
health = zeros(1,len_damage);
for i = 1:len_damage
    if i == 1
        health(i) = initial_health - damage(i);
    else    
        health(i) = health(i-1) - damage(i);
    end
end    

health = [initial_health,health]

plot(0:len_damage, health);
xlabel('S');
ylabel('HP');