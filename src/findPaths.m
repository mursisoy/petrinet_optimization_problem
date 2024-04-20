function [mf, sigma, compliance, fval,exitflag,output] = findPaths(C, V, m0, formula, nr_props)
%FINDPATHS From petriNetBuilder return values and a boolean formula returns
% minimal step to accomplish the mission

% We obtain the constraints in matrix form.
[A,b] = formula2constraints(formula, nr_props);

% We calculate sizes for later use.
[nr_restrictions, ~] = size(A);
[m_size,sigma_size] = size(C); 
[nr_obs, ~ ] = size(V);

% We calculate the size of the target variable vector.
x_m = m_size + sigma_size + nr_props;

fprintf("Number of variables (%d): m(%d) + \\sigma(%d) + props(%d)\n", x_m , m_size, sigma_size, nr_props);

% Vector f
% x = [    m                 \sigma             Var         ]
f = [ zeros(1,m_size) ones(1,sigma_size) zeros(1, nr_props) ];

% Calculation of N strictly greater than the number of robots.
N = sum(m0) + 1;

% Aineq = [ 0  0  A
%           V  0  -N
%          -V  0  I  ]
Aineq = [
    zeros(nr_restrictions, m_size), zeros(nr_restrictions,sigma_size),  A;
    V,                              zeros(nr_obs, sigma_size),          -N*eye(nr_obs,nr_props);
    -V,                             zeros(nr_obs, sigma_size),          eye(nr_obs,nr_props);
];

% bineq = [ b 0 0 ]
bineq = [b; zeros(nr_obs,1); zeros(nr_obs,1)];

% Aeq = [ I  -C  0 ]
Aeq = [eye(m_size,m_size), -C, zeros(m_size, nr_props)];
beq = m0';

% Cplex Solver 
sostype=[];
sosind=[] ;
soswt=[];
ub=[];
% Set the lower limit.
lb = zeros(size(f));
% Create type vector
ctype = char([ones(1,m_size)*'I' ones(1,sigma_size)*'I' ones(1, nr_props)*'B']);

[x,fval,exitflag,output] = cplexmilp(f,Aineq,bineq,Aeq,beq,sostype,sosind,soswt,lb,ub,ctype);

% Final state
mf = x(1:m_size);
offset = m_size;
% Triggers
sigma = x(offset+1:offset+sigma_size);
offset = offset + sigma_size;

% Compliance
compliance = x(offset+1:offset+nr_props);

end