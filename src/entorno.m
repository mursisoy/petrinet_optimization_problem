clear all;
addpath('functions');

%define world boundaries and regions (propositions) via mouse clicks:
x_max=16;
y_max=9;
regions = define_regions(x_max,y_max);

% plot_environment(regions,x_max,y_max);
T = create_partition(regions,[0,x_max,0,y_max]);    %partition, adjacency, observations
% plot_environment(regions,x_max,y_max,T.Vert);

%3 robots: 
%R0=[14 33 35]; formula = 'a&!B&(C|D)&c&e'; 

%R0=[33 35];
%R0=input('Row vector with index of initial cell for each robot: ');

%rob_color={'r','b','g','c'};
N_r=input('Number of robots: ');
plot_environment(regions,x_max,y_max,T.Vert);
x0=cell(1,N_r);
R0=zeros(1,N_r);
for r=1:N_r
    x0{r}=zeros(2,1);
    title(sprintf('Click on initial position of robot %d',r));
    [x,y]=ginput(1);
    x0{r}(1,1)=x;   %initial continuous position
    x0{r}(2,1)=y;
    plot(x0{r}(1,1),x0{r}(2,1),'*r');
    for i=1:length(T.Q) %find initial discrete state
        if inpolygon(x0{r}(1,1),x0{r}(2,1),T.Vert{i}(1,:),T.Vert{i}(2,:))
            R0(r)=i;
            break;
        end
    end
end
T.R0=R0;
title('');


return

T.m0=zeros(length(T.Q),1);    %initial marking (for PN)
for i=T.Q
    T.m0(i)=sum(ismember(R0,i));  %number of robots initially in state i
end
Tr = quotient_T(T); %quotient of partition T, with fewer states (based on collapsing states with same observables in same connected component with same obs)

rmpath('functions');
