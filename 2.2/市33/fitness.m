% ������Ⱥ������Ӧ�ȣ��Բ�ͬ���Ż�Ŀ�꣬�޸�����ĺ���
% population_size: ��Ⱥ��С
% chromosome_size: Ⱦɫ�峤��

function fitness(population_size, chromosome_size,citypairs_num,pop_citypairs,dis_citypairs)
global fitness_value;
global population;
% global path_all;
% ������Ⱥ������Ӧ�ȳ�ʼ��Ϊ0
for i=1:population_size
    fitness_value(i) = 0;
end
count=0;
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
    if size(link_city_uni,1)~=12 %����δȫ���ӽ��гͷ�
        punish2=1;
    else %����ȫ���£��еĳ��ж�δ��������
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
    for j=1:chromosome_size %��������
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
        for j=1:chromosome_size %�������������гͷ�����
            if population(i,j) == 1
                city_start=citypairs_num(j,1);
                city_end=citypairs_num(j,2);
                capacity_seg=matrix_ca(city_start,city_end);
                fitness_value(i)=fitness_value(i)+(sqrt(pop_citypairs(j,1)*pop_citypairs(j,2)))*1*capacity_seg*0.08+punish1*(-10000)+punish2*(-10000);
            end
        end
    else 
        for j=1:chromosome_size %�����������·�����������Ȩ�أ�������Ӧ��
            if population(i,j) == 1
                path_all=zeros(1,12);
                city_start=citypairs_num(j,1);
                city_end=citypairs_num(j,2);
                capacity_seg=matrix_ca(city_start,city_end);
                path(1,1)=city_start;
                % �����·���������Ƿ���������0.08������λ���㣩
                rand_path=unidrnd(3)-1;%(0ʱ����·��ȫ������������ռ��)
                rand_weight=1;
                if rand_path~=0% �������0��·��
                    for k=1:rand_path% �������·������������Ӧ����
                        %�������·��
                        rand_point=unidrnd(3)-1;
                        % �γ�·��
                        rand=randperm(12);
                        rand = rand(~ismember(rand,city_start));
                        rand = rand(~ismember(rand,city_end));
                        path(1,2:(1+rand_point))=rand(1:rand_point);
                        path(1,rand_point+2)=city_end;
                        path_delete=0;%·���ܷ�ʹ�ñ�־��Ϊ1������
                        %���Ȩ��
                        weight=(unidrnd(11)-1)*0.1;
                        rand_weight=rand_weight-weight;
                        if rand_weight>0
                            % ·����·�Σ�����·�μ�������
                            matrix_ca_tem=matrix_ca;
                            for s=1:size(path,2)-1
                                seg1=path(1,s);
                                seg2=path(1,s+1);
                                matrix_ca_tem(seg1,seg2)=matrix_ca_tem(seg1,seg2)-weight*capacity_seg;
                                if matrix_ca_tem(seg1,seg2)<0%������Դ���꣬�����·��
                                    path_delete=1;
                                    break
                                end
                            end
                            if path_delete==0 && weight~=0%·�����ã�·������·���������٣�����·���������м�ֵ����
                                % ��������ȷ��
                                matrix_ca=matrix_ca_tem;
                                % ����·��
                                count=count+1;
                                path;
                                weight;
                                path_all(count,1:size(path,2))=path(:);
                                % ��ֵ����
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
