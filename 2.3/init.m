% ��ʼ����Ⱥ дԼ������
% population_size: ��Ⱥ��С
% chromosome_size: Ⱦɫ�峤��

function init(population_size)
global population;
for i=1:population_size
    rand=randperm(66);
    for j=1:16 %��ֵ16��
        population(i,rand(1,j))=1;
    end
end
clear i;
clear j;
