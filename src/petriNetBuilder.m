function [ PRE, POST, m0, V] = petriNetBuilder( T )
%PETRINETBUILDER Summary of this function goes here
%   Detailed explanation goes here

aux = T.adj - sparse(T.Q,T.Q,ones(1,numel(T.Q)));
[ii,jj,ss] = find(aux);

PRE =  sparse(ii,1:length(ii),ones(1,length(ii)));
POST =  sparse(jj,1:length(jj),ones(1,length(jj)));

% Initial marking
m0 = ones(1,numel(T.Q))*sparse(T.R0(:),T.R0(:), 1,numel(T.Q),numel(T.Q));

V = zeros(numel(T.props), numel(T.obs))
for i=1:length(T.props)
    V(ones(1,numel(T.props{i}))*i,T.props{i}) = 1;
end

% PRE  = sparse(numel(T.Q),nnz(T.adj)-numel(T.Q));
% POST = sparse(numel(T.Q),nnz(T.adj)-numel(T.Q));
% 
% 
% 
% for k=1:length(ii)    
%     if ii(k) == jj(k) 
%         continue
%     end
%     fprintf('%d,%d\n', ii(k),jj(k))
%     PRE(ii(k),  k) = 1;
%     POST(jj(k), k) = 1;  
% end

end

