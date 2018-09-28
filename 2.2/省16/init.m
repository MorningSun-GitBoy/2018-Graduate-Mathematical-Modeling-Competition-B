% 初始化种群 写约束条件
% population_size: 种群大小
% chromosome_size: 染色体长度

function init(population_size)
global population;
for i=1:population_size
    rand=randperm(66);
    for j=1:16 %赋值16次
        population(i,rand(1,j))=1;
    end
end
clear i;
clear j;
