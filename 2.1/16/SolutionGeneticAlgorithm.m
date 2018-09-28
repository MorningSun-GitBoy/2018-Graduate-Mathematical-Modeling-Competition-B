%% Solution for genetic algorithm
% function [best_individual,best_fitness,iterations,x]=SolutionGeneticAlgorithm(matrix_flow_adjust,matrix_ca,node_ca,matrix_man_cross_dis)
clear
load('BasicInformation.mat')
[~,chromosome_size,citypairs_num,~,~]=citypairs_function(city,num_population,coordinate); % 染色体长度
elitism = true;             % 选择精英操作
population_size =85;      % 种群大小
generation_size = 3000;      % 最大迭代次数
cross_rate = 1;           % 交叉概率
mutate_rate = 1;         % 变异概率

[best_individual,best_fitness,iterations,x] = genetic_algorithm(population_size, chromosome_size, generation_size, cross_rate, mutate_rate, elitism)
disp 最优个体:
best_individual
disp 最优适应度:
best_fitness
disp 最优个体对应自变量值:
x
disp 达到最优结果的迭代次数:
iterations

sum(best_individual)

figure(2)
% plot
for i=1:size(coordinate,1)
    plot(coordinate(i,1), coordinate(i,2),'o')
    hold on
end
hold on
for i=1:chromosome_size
    if best_individual(1,i)==1
        x=[coordinate(citypairs_num(i,1),1) coordinate(citypairs_num(i,2),1)];
        y=[coordinate(citypairs_num(i,1),2) coordinate(citypairs_num(i,2),2)];
        plot(x,y)
        hold on
    end
end