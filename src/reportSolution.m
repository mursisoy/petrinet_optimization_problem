function reportSolution(environment)
%REPORTSOLUTION Load a saved environment results to show the path and final
% state


close all
load(sprintf('%s/environment.mat', environment))
openfig(sprintf('%s/environment.fig', environment))
load(sprintf('%s/results.mat', environment))


% Find triggers
[o,d,~] = find(adj);
[t,~,f] = find(sigma);

% For each trigger, draw an arrow from source to target places, add trigger
% multiplier
for i=1:length(f)
    centr1=mean(T.Vert{o(t(i))},2)';
    centr2=mean(T.Vert{d(t(i))},2)';
    arrow = annotation('arrow');
    arrow.Parent = gca;
    arrow.Position = [centr1 centr2-centr1];
    arrow.Color = '#888';
    txtPos = centr1+(centr2-centr1)/2;
    text(txtPos(1),txtPos(2),{sprintf('x %d', f(i))}, 'FontSize',14, 'Color','#333')
end

% Find final marking
[mp, ~, mn] = find(mf);

% For each place, draw random points inside the triangle
% Source: https://blogs.sas.com/content/iml/2020/10/19/random-points-in-triangle.html
for i=1:length(mp)
    u = rand(2,mn(i))
    idx = sum(u)>1
    if nnz(idx) > 0
        u(:,idx) = 1 - u(:,idx)
    end
    a = T.Vert{mp(i)}(:,2) - T.Vert{mp(i)}(:,1)
    b = T.Vert{mp(i)}(:,3) - T.Vert{mp(i)}(:,1)
    w = kron(u(1,:),a) + kron(u(2,:),b)
    r =  T.Vert{mp(i)}(:,1) + w;
    scatter(r(1,:),r(2,:),'MarkerEdgeColor','blue')
end

end

