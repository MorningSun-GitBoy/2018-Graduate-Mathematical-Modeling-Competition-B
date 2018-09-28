%% Solution for genetic algorithm
% function [best_individual,best_fitness,iterations,x]=SolutionGeneticAlgorithm(matrix_flow_adjust,matrix_ca,node_ca,matrix_man_cross_dis)
clear
load('BasicInformation.mat')
[~,chromosome_size,citypairs_num,~,~]=citypairs_function(city,num_population,coordinate); % Ⱦɫ�峤��
elitism = true;             % ѡ��Ӣ����
population_size =85;      % ��Ⱥ��С
generation_size = 3000;      % ����������
cross_rate = 1;           % �������
mutate_rate = 1;         % �������

[best_individual,best_fitness,iterations,x] = genetic_algorithm(population_size, chromosome_size, generation_size, cross_rate, mutate_rate, elitism)
disp ���Ÿ���:
best_individual
disp ������Ӧ��:
best_fitness
disp ���Ÿ����Ӧ�Ա���ֵ:
x
disp �ﵽ���Ž���ĵ�������:
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