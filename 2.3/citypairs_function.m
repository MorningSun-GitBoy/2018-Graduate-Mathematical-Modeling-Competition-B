%% 创建染色体对应城市对
% pop_citypairs:population of citypairs
% dis_citypairs:distance of citypairs
function [citypairs,number_citypairs,citypairs_num,pop_citypairs,gdp_citypairs,dis_citypairs]=citypairs_function(city,num_population,coordinate,GDP)
% 生成城市对
citypairs={};
count=0;
for i=1:size(city,1)
    for j =i+1:size(city,1)
        count=count+1;
        citypairs(count,1)=city(i);
        citypairs(count,2)=city(j);
    end
end
number_citypairs=size(citypairs,1);
% 城市对序号
citypairs_num=zeros(number_citypairs,2);
for i=1:number_citypairs
    for j=1:size(city,1)
        if strcmp(citypairs(i,1),city(j,1))==1
            citypairs_num(i,1)=j;
        end
    end
    for j=1:size(city,1)
        if strcmp(citypairs(i,2),city(j,1))==1
            citypairs_num(i,2)=j;
        end
    end
end
% 人口
pop_citypairs=zeros(size(city,1),2);
for i= 1:size(citypairs,1)
    for j=1:size(city,1)
        if  strcmp(citypairs(i,1),city(j,1))==1
            pop_citypairs(i,1)=num_population(j,1);
            break
        end
    end
    for j=1:size(city,1)
        if  strcmp(citypairs(i,2),city(j,1))==1
            pop_citypairs(i,2)=num_population(j,1);
            break
        end
    end
end
% GDP
gdp_citypairs=zeros(size(city,1),2);
for i= 1:size(citypairs,1)
    for j=1:size(city,1)
        if  strcmp(citypairs(i,1),city(j,1))==1
            gdp_citypairs(i,1)=GDP(j,1);
            break
        end
    end
    for j=1:size(city,1)
        if  strcmp(citypairs(i,2),city(j,1))==1
            gdp_citypairs(i,2)=GDP(j,1);
            break
        end
    end
end
% 距离
% [ Distance_num ] = dist_lonlat( Lat_Orig, Long_Orig,Lat_Dest,Long_Dest)
dis_citypairs=zeros(size(city,1),1);
for i= 1:size(citypairs,1)
    for j=1:size(city,1)
        if  strcmp(citypairs(i,1),city(j,1))==1
            num1=j;
            break
        end
    end
    for j=1:size(city,1)
        if  strcmp(citypairs(i,2),city(j,1))==1
            num2=j;
            break
        end
    end
    dis_citypairs(i,1)= dist_lonlat( coordinate(num1,2), coordinate(num1,1),coordinate(num2,2),coordinate(num2,1));
end