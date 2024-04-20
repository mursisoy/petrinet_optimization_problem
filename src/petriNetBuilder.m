function [ PRE, POST, C, m0, V, adj] = petriNetBuilder( T )
%PETRINETBUILDER From an environment definition build the petri net model

% From adjacency matrix, remove diag.
adj = T.adj - sparse(T.Q,T.Q,ones(1,numel(T.Q)));

% We thus obtain the total number of transitions from one place to another,
% in both directions.
[ii,jj,~] = find(adj);

% We construct the PRE and POST matrices and use the non-zero indices from 
% the previous matrix. The transitions are numbered sequentially in the 
% columns, and the rows correspond to the places.
PRE =  sparse(ii,1:length(ii),ones(1,length(ii)));
POST =  sparse(jj,1:length(jj),ones(1,length(jj)));

% We create the incidence matrix.
C = POST - PRE;

% We construct the initial marking through the vector T.R0 which contains
% the position of each robot. We create a sparse matrix, taking advantage 
% of the fact that the sparse function accumulates the value if the indices
% are repeated.
m0 = sparse(1,T.R0(:), 1, 1,numel(T.Q));

% We create the matrix with the characteristic vectors of each observation.
% This means that for each region of interest (row), the places
% (columns) that contain them are marked.
V = spalloc(numel(T.props), numel(T.obs), numel(cell2mat(T.props)));
for i=1:length(T.props)
    V(i,T.props{i}) = 1;
end

end