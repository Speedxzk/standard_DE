%%%%%%%%%%%%%%%%%%%%%%%%%%%Differential Evolution%%%%%%%%%%%%%%%%%%%%%%%%%%
%����Ե�Ŀ������
%����ܲ���NP��CR��Ӱ��ܴ�ÿ�����������仯1������
clear
clc
%----------------------------�趨��ʼ������-----------------------------------
NP = 10;                                        %��Ⱥ����
it_max = 100;                                   %����������
dim = 3;                                        %���߿ռ�ά��
  d_min = [-5.12, -5.12, -5.12];                %���߱���ȡֵ��Χ��Сֵ
  d_max = [5.12, 5.12, 5.12];                   %���߱���ȡֵ��Χ���ֵ
CR = 0.8;                                       %�������
F = 0.5;                                        %��������
%------------------------------��ʼ����Ⱥ------------------------------------
init_pop = init_pop(NP, dim, d_min, d_max);
fitness_value = fitness(init_pop, dim);
init_pop = [init_pop, fitness_value];
pop = init_pop;
for iter = 1:it_max
    %-----------------------------����ʵ�����V------------------------------
    num = randperm(NP,4);                           %����x_1,x_2,x_3,x_4��pop�еı��
    %���ɲ��ʸ��diff_var
    x_2 = pop(num(2),:);
    x_3 = pop(num(3),:);
    diff_var = x_2 - x_3;
    %����ʵ�����V
    x_1 = pop(num(1),:);
    V = x_1 + F*diff_var;
    V(:,dim+1) = fitness(V(:,1:dim),dim);
    %-------------------------------����õ�U-------------------------------
    x_4 = pop(num(4),:);                            %������V����ĸ���
    n = randperm(dim,1);                            %��ʼ�����ά��
    %�õ������ά��L,L/in{0,1,...,dim-n+1}
    for i = 1:dim
        pro_cross_all(:,dim-i+1) = CR^i;            
    end
    pro_cross_all = [0,pro_cross_all,1];            %��������Ľ������
    pro_cross = [0,pro_cross_all(:,n+1:size(pro_cross_all,2))];   
                                                    %���n����ȡ����Lֵ�����н������              
    location = find(rand <= pro_cross);             %location�����n����ȡ��Lֵ��λ��
    L = dim - find(pro_cross_all == pro_cross(:,location(:,1))) + 2;
                                                    %L�ǽ����ά��
    U = x_4;                                        %������������ô�죡��������
    U(:,n:n+L-1) = V(:,n:n+L-1);
    U(:,end) = fitness(U(:,1:dim),dim);             %U�ǽ�������
    %--------------------------ѡ����ֵС�Ĵ���x_4--------------------------
    if U(:,end) < x_4(:,end)
        pop(num(4),:) = U;
    else
        pop(num(4),:) = x_4;
    end
    pop = sortrows(pop,dim+1);
    optimal(iter) = pop(1,dim+1);
end
%-------------------------------���Ƴ���Ӧ�ȱ仯����ͼ-------------------------
plot(optimal,'*-')
xlabel('��������')
ylabel('��Ӧ��ֵ')
title('Sphere function')
        