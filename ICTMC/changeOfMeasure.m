function Ah=changeOfMeasure(A,kappa,varargin)
%%CHANGEOFMEASURE computes the generator of an ICTMC for a given change of
% measure parametrized by kappa. kappa can either be a vector or a matrix
% whoes diagonal is irrelevant, i.e.:
%   A_{ij}^{\kappa} = (1+\kappa_{ij})A_{ij}, 
%   A_{ii} = - \sum_{j\neq i} A_{ij}^{\kappa}
%
%   Input:
%       A (K x K x n x m): generator under measure P
%       kappa (K x K or K x 1): change of measure parameters
%
%       varargin (cell array): name-value pair
%           - 'Type': type of change of measure, 'JLT' (default), 'Exp'
%                     and 'General' possible
%   Output:
%       Ah (K x K x n x m): generator under measure Q^h

    comType = 'JLT';
    for iV=1:1:length(varargin)
        switch varargin{iV}
            case 'Type'
                comType = varargin{iV+1};
        end
    end
    switch comType
        case 'JLT'
            h=kappa(:);
            Ah=generalChangeOfMeasure(A,h);
        case 'Exp'
            h=kappa(:);
            H=h./h';
            Ah=generalChangeOfMeasure(A,H);
        case 'General'
            Ah=generalChangeOfMeasure(A,1+kappa);
        otherwise
            error('Unkown change of measure')
    end
    
end
function Ah=generalChangeOfMeasure(A,kappa)
    Ah=A.*kappa;
    if ~ismatrix(A)
        diagInd=repmat(eye(size(A,1),'logical'),[1,1,size(A,3:ndims(A))]);
    else
        diagInd=eye(size(A,1),'logical');
    end
    Ah(diagInd)=0;
    Ah(diagInd)=-sum(Ah,2);
end