% 计算种群个体适应度，对不同的优化目标，修改下面的函数
% population_size: 种群大小
% chromosome_size: 染色体长度

function fitness(population_size, chromosome_size,citypairs_num,pop_citypairs,dis_citypairs)
global fitness_value;
global population;
% global path_all;
% 所有种群个体适应度初始化为0
for i=1:population_size
    fitness_value(i) = 0;
end
count=0;
% [citypairs,number_citypairs,citypairs_num,pop_citypairs,dis_citypairs]=citypairs_function(city,num_population,coordinate)
% 求各种群最大值
for i=1:population_size
    % 异常值处理
    if sum(population(i,:))~=33
        punish1=1;
    else
        punish1=0;
    end
    % 城市未连接惩罚
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
    if size(link_city_uni,1)~=12 %城市未全连接进行惩罚
        punish2=1;
    else %城市全连下，有的城市对未接入网络
        Value=tabulate(link_city(:));
        for j=1:size(link_citys,1)
            if Value(link_citys(j,1),2)==1 && Value(link_citys(j,2),2)==1
                punish2=1;
                break
            end
            punish2=0;
        end
    end
    
    % capacity matrix
    matrix_ca=zeros(12,12);
    matrix_zero=zeros(12,12);
    for j=1:chromosome_size %容量矩阵
        if population(i,j) == 1
            if dis_citypairs(j,1)>3000
                matrix_ca(citypairs_num(j,1),citypairs_num(j,2))=0;
            elseif dis_citypairs(j,1)>1200 && dis_citypairs(j,1)<=3000
                matrix_ca(citypairs_num(j,1),citypairs_num(j,2))=100;
                matrix_ca(citypairs_num(j,2),citypairs_num(j,1))=100;
                matrix_zero(citypairs_num(j,1),citypairs_num(j,2))=1;
                matrix_zero(citypairs_num(j,2),citypairs_num(j,1))=1;
            elseif dis_citypairs(j,1)>600 && dis_citypairs(j,1)<=1200
                matrix_ca(citypairs_num(j,1),citypairs_num(j,2))=200;
                matrix_ca(citypairs_num(j,2),citypairs_num(j,1))=200;
                matrix_zero(citypairs_num(j,1),citypairs_num(j,2))=1;
                matrix_zero(citypairs_num(j,2),citypairs_num(j,1))=1;
            else
                matrix_ca(citypairs_num(j,1),citypairs_num(j,2))=400;
                matrix_ca(citypairs_num(j,2),citypairs_num(j,1))=400;
                matrix_zero(citypairs_num(j,1),citypairs_num(j,2))=1;
                matrix_zero(citypairs_num(j,2),citypairs_num(j,1))=1;
            end
        end
    end
    if punish1==1||punish2==1
        for j=1:chromosome_size %不满足条件进行惩罚计算
            if population(i,j) == 1
                city_start=citypairs_num(j,1);
                city_end=citypairs_num(j,2);
                capacity_seg=matrix_ca(city_start,city_end);
                fitness_value(i)=fitness_value(i)+(sqrt(pop_citypairs(j,1)*pop_citypairs(j,2)))*1*capacity_seg*0.08+punish1*(-10000)+punish2*(-10000);
            end
        end
    else 
        for j=1:chromosome_size %随机多条搜索路径并随机分配权重，计算适应度
            if population(i,j) == 1
                path_all=zeros(1,12);
                city_start=citypairs_num(j,1);
                city_end=citypairs_num(j,2);
                capacity_seg=matrix_ca(city_start,city_end);
                path(1,1)=city_start;
                % 随机条路径，容量是分配流量的0.08倍（单位换算）
                rand_path=unidrnd(3)-1;%(0时，此路径全部被其他流量占用)
                rand_weight=1;
                if rand_path~=0% 随机到非0条路径
                    for k=1:rand_path% 随机搜索路径，并减少相应容量
                        %随机搜索路径
                        rand_point=unidrnd(3)-1;
                        % 形成路径
                        rand=randperm(12);
                        rand = rand(~ismember(rand,city_start));
                        rand = rand(~ismember(rand,city_end));
                        path(1,2:(1+rand_point))=rand(1:rand_point);
                        path(1,rand_point+2)=city_end;
                        path_delete=0;%路径能否使用标志，为1则不能用
                        %随机权重
                        weight=(unidrnd(11)-1)*0.1;
                        rand_weight=rand_weight-weight;
                        if rand_weight>0
                            % 路径变路段，并对路段减少容量
                            matrix_ca_tem=matrix_ca;
                            for s=1:size(path,2)-1
                                seg1=path(1,s);
                                seg2=path(1,s+1);
                                matrix_ca_tem(seg1,seg2)=matrix_ca_tem(seg1,seg2)-weight*capacity_seg;
                                if matrix_ca_tem(seg1,seg2)<0%容量资源用完，舍掉此路径
                                    path_delete=1;
                                    break
                                end
                            end
                            if path_delete==0 && weight~=0%路径可用，路径所有路段容量减少，保存路径，并进行价值计算
                                % 容量减少确认
                                matrix_ca=matrix_ca_tem;
                                % 保存路径
                                count=count+1;
                                path;
                                weight;
                                path_all(count,1:size(path,2))=path(:);
                                % 价值计算
                                fitness_value(i)=fitness_value(i)+(sqrt(pop_citypairs(j,1)*pop_citypairs(j,2)))*weight*capacity_seg*0.08+punish1*(-10000)+punish2*(-10000);
                            end
                        else
                            break
                        end
                    end
                end
            end
        end
    end
end
