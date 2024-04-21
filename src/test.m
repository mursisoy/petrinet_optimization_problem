%% Test 1 

%% Solve
clear
load('test1/environment.mat')
openfig('test1/environment.fig')

[PRE, POST, C, m0, V, adj] = petriNetBuilder(T);
formula='!A&B';
nr_props = 2;
[mf, sigma, compliance, fval,exitflag,output] = findPaths(C, V, m0, formula, nr_props);
save('test1/results.mat', 'PRE', 'POST', 'C', 'm0', 'V', 'adj', 'mf', 'sigma', 'compliance', 'fval','exitflag','output')
%%
clear
reportSolution('test1')

%% Test 2
clear
load('test2/environment.mat')
openfig('test2/environment.fig')

[PRE, POST, C, m0, V, adj] = petriNetBuilder(T);
formula='A&B&!C';
nr_props = 3;
[mf, sigma, compliance, fval,exitflag,output] = findPaths(C, V, m0, formula, nr_props);
save('test2/results.mat', 'PRE', 'POST', 'C', 'm0', 'V', 'adj', 'mf', 'sigma', 'compliance', 'fval','exitflag','output')
%%
clear
reportSolution('test2')
%% Test 3
clear
load('test3/environment.mat')

[PRE, POST, C, m0, V, adj] = petriNetBuilder(T);
formula='!A&!B&!C&D';
nr_props = 4;
[mf, sigma, compliance, fval,exitflag,output] = findPaths(C, V, m0, formula, nr_props);
save('test3/results.mat', 'PRE', 'POST', 'C', 'm0', 'V', 'adj', 'mf', 'sigma', 'compliance', 'fval','exitflag','output')
%% 
clear
reportSolution('test3')
%% Test 4
clear
load('test4/environment.mat')

[PRE, POST, C, m0, V, adj] = petriNetBuilder(T);
formula='A&B&C&!D&!E';
nr_props = 5;
[mf, sigma, compliance, fval,exitflag,output] = findPaths(C, V, m0, formula, nr_props);
save('test4/results.mat', 'PRE', 'POST', 'C', 'm0', 'V', 'adj', 'mf', 'sigma', 'compliance', 'fval','exitflag','output')
%% 
clear
reportSolution('test4')