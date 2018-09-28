% ������Ⱥ������Ӧ�ȣ��Բ�ͬ���Ż�Ŀ�꣬�޸�����ĺ���
% population_size: ��Ⱥ��С
% chromosome_size: Ⱦɫ�峤��

function fitness(population_size, chromosome_size,citypairs_num,pop_citypairs,dis_citypairs)
global fitness_value;
global population;
% ������Ⱥ������Ӧ�ȳ�ʼ��Ϊ0
for i=1:population_size
    fitness_value(i) = 0;
end

% [citypairs,number_citypairs,citypairs_num,pop_citypairs,dis_citypairs]=citypairs_function(city,num_population,coordinate)
% �����Ⱥ���ֵ
for i=1:population_size
    % �쳣ֵ����
    if sum(population(i,:))~=33
        punish1=1;
    else
        punish1=0;
    end
    % ����δ���ӳͷ�
    link_city=[];
    count1=0;
    count2=0;
    for j=1:chromosome_size
        if population(i,j) == 1
            count1=count1+1;
            count2=count2+1;
            link_city(count1,1)=citypairs_num(j,1);
            link_citys(count2,1)=citypairs_num(j,1);
            link_citys(count2,2)=citypairs_num(j,2);
            count1=count1+1;
            link_city(count1,1)=citypairs_num(j,2);
        end
    end
    link_city_uni=unique(link_city);
    if size(link_city_uni,1)~=12
        punish2=1;
    else
        Value=tabulate(link_city(:));
        for j=1:size(link_citys,1)
            if Value(link_citys(j,1),2)==1 && Value(link_citys(j,2),2)==1
                punish2=1;
                break
            end
            punish2=0;
        end
    end
  
    for j=1:chromosome_size
        if population(i,j) == 1
            % �ж����������(���ݾ���)
            if dis_citypairs(j,1)>3000
                total_capacity=0;
            elseif dis_citypairs(j,1)>1200 && dis_citypairs(j,1)<=3000
                total_capacity=8;
            elseif dis_citypairs(j,1)>600 && dis_citypairs(j,1)<=1200
                total_capacity=16;
            else
                total_capacity=32;
            end
            % ��ֵ��ʽ
            fitness_value(i)=fitness_value(i)+(sqrt(pop_citypairs(j,1)*pop_citypairs(j,2)))*total_capacity+punish1*(-10000)+punish2*(-10000);
        end
    end
end