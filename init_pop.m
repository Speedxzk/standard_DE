function init_pop = init_pop(NP, dim, d_min, d_max)
init_pop = [];
for i = 1:NP %��i������
    for j = 1:dim %��jά���߱�����ȡֵ
    init_pop(i,j) = d_min(j) + (d_max(j) - d_min(j)).*rand;
    end
end

