%% Random path srarsh algorithm
%   W  权值矩阵   st 搜索的起点   e 搜索的终点
function [path] = RandomSearshPath(W,st,e)
END=0;
while END==0
    n=length(W);%节点数
    D = W(st,:); % W矩阵起始点行
    path(1)=st;
    visit= ones(1,n);
    visit(st)=0;%设置visit判断节点是否访问,未访问节点1
    num=1;
    for i=1:n-1
        num=num+1;
        temp = [];
        temp_tem=[];
        temp_tem_tem=[];
        %从起点出发，找最短距离的下一个点，每次不会重复原来的轨迹，设置visit判断节点是否访问
        for j=1:n % 将未遍历的点的D值赋给temp，（temp即D，只是将遍历点处赋为inf）
            if visit(j)
                temp =[temp D(j)];
            else
                temp =[temp inf];
            end
        end
        count=0;
        for j=1:length(temp)
            if temp(j)==1
                count=count+1;
                temp_tem(count)=j;% temp中为1的序号
            end
        end
        temp_tem_tem=randperm(length(temp_tem));% 随机选取temp中的数
        if ~isempty(temp_tem)
            index=temp_tem(temp_tem_tem(1));
            path(num)=index;
            visit(index) = 0;     % 更新未遍历的点
            D=W(index,:);
            if index==e
                END=1;
                break;
            end
        else
            break;
        end
    end
end
end