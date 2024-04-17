
[PRE, POST, m0, V] = petriNetBuilder(T);
C = POST - PRE;

formula='A&B';
constraints =2;
[A,b] = formula2constraints(formula, constraints);
[restriction_number, ~] = size(A); 
%% 

[m_size,sigma_size] = size(C); 

n = m_size + sigma_size + constraints;

f = [ zeros(1,m_size) ones(1,sigma_size) zeros(1, constraints) ];

N = numel(T.R0) + 1;

Aineq = [
    zeros(restriction_number, m_size), zeros(restriction_number,sigma_size), A;
    V,  zeros(numel(T.props), sigma_size), -N*ones(numel(T.props),constraints);
    -V,  zeros(numel(T.props), sigma_size), eye(numel(T.props),constraints);
];

bineq = [b;zeros(numel(T.props),1);zeros(numel(T.props),1)];

Aeq = [eye(m_size,m_size), -C, zeros(m_size, constraints)];
beq = m0';
%% 
[x,fval,exitflag,output] = cplexmilp(f,Aineq,bineq,Aeq,beq) 




