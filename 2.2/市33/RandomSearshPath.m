%% Random path srarsh algorithm
%   W  Ȩֵ����   st ���������   e �������յ�
function [path] = RandomSearshPath(W,st,e)
END=0;
while END==0
    n=length(W);%�ڵ���
    D = W(st,:); % W������ʼ����
    path(1)=st;
    visit= ones(1,n);
    visit(st)=0;%����visit�жϽڵ��Ƿ����,δ���ʽڵ�1
    num=1;
    for i=1:n-1
        num=num+1;
        temp = [];
        temp_tem=[];
        temp_tem_tem=[];
        %��������������̾������һ���㣬ÿ�β����ظ�ԭ���Ĺ켣������visit�жϽڵ��Ƿ����
        for j=1:n % ��δ�����ĵ��Dֵ����temp����temp��D��ֻ�ǽ������㴦��Ϊinf��
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
                temp_tem(count)=j;% temp��Ϊ1�����
            end
        end
        temp_tem_tem=randperm(length(temp_tem));% ���ѡȡtemp�е���
        if ~isempty(temp_tem)
            index=temp_tem(temp_tem_tem(1));
            path(num)=index;
            visit(index) = 0;     % ����δ�����ĵ�
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