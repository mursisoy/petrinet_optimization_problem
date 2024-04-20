%% Test 1 

%% Solve
clear
load('test1/test1.mat')
openfig('test1/test1.fig')

[PRE, POST, C, m0, V, adj] = petriNetBuilder(T);
formula='!A&B';
nr_props = 2;
[mf, sigma, compliance, fval,exitflag,output] = findPaths(C, V, m0, formula, nr_props);
save('test1/test1_results.mat', 'PRE', 'POST', 'C', 'm0', 'V', 'adj', 'mf', 'sigma', 'compliance', 'fval','exitflag','output')
%%
clear
reportSolution('test1')

%% Test 2
clear
load('test2/test2.mat')
openfig('test2/test2.fig')

[PRE, POST, C, m0, V, adj] = petriNetBuilder(T);
formula='A&B&!C';
nr_props = 3;
[mf, sigma, compliance, fval,exitflag,output] = findPaths(C, V, m0, formula, nr_props);
save('test2/test2_results.mat', 'PRE', 'POST', 'C', 'm0', 'V', 'adj', 'mf', 'sigma', 'compliance', 'fval','exitflag','output')
%%
clear
reportSolution('test2')
%% Test 3
clear
load('test3/test3.mat')
openfig('test3/test3.fig')

[PRE, POST, C, m0, V, adj] = petriNetBuilder(T);
formula='!A&!B&!C&D';
nr_props = 4;
[mf, sigma, compliance, fval,exitflag,output] = findPaths(C, V, m0, formula, nr_props);
save('test3/test3_results.mat', 'PRE', 'POST', 'C', 'm0', 'V', 'adj', 'mf', 'sigma', 'compliance', 'fval','exitflag','output')
%% 
clear
reportSolution('test3')