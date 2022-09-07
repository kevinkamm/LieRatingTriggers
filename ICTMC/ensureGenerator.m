function A=ensureGenerator(A)
%%ENSUREGENERATOR ensures that a given matrix A is a valid generator by
% setting all negative off-diagonals to zero and recomputing the diagonal
% as the negative sum of all off-diagonals.
%
%   Input:
%       A (K x K x n x m): possible invalid generator
%
%   Output:
%       A (K x K x n x m): valid generator
%

negativeAdjustment=0; % value for negative off-diagonals

% indices for diagonals
if ~ismatrix(A)
    diagInd=repmat(eye(size(A,1),'logical'),[1,1,size(A,3:ndims(A))]);
else
    diagInd=eye(size(A,1),'logical');
end

A(diagInd)=0;
A(A<0)=negativeAdjustment;
A(diagInd)=-sum(A,2);
end