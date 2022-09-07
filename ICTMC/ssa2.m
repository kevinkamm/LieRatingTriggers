function X=ssa2(A,tMarket,i0,M,dt)
%%SSA computes the Gillespie Stochastic Simulation Algorithmn of a
%%piecewise homogeneous CTMC for given generator, time partition and
%%starting state.
%   Input:
%       A (KxKxn array): contains the generator of the ICTMC
%       tMarket (1xn array): contains the time partition, when the
%                            generator changes
%       i0 (int): contains the initial state
%       M (int): number of simulations
%       dt (double): time discretization for output process
%   Output:
%       X (NxM array): contains the trajectories of an ICTMC starting in i0
options = optimset('Display','off');
t=linspace(0,tMarket(end),tMarket(end)/dt+1);
X=zeros(length(t),M);
time=cat(2,0,tMarket);
for m=1:1:M
    i=i0;
        tau=time(1);
        ti=1;
        while tau<time(end)
            if A(i,i,1)==0
                tau=time(end);
            else
                r=rand(2,1);
                temp1=fsolve(@(tt)f(squeeze(A(i,i,:)),time,tau,tt,r(1)),0,options);
                tau=tau+temp1;
                if tau>=time(end)
                    break;
                end
                k=find(time<=tau,1,'last');
                if isempty(k)
                    k=1;
                end
                tiNew=find(t<=tau,1,'last');
                X(ti:1:tiNew,m)=i;
                temp2=A(i,[1:1:i-1,i+1:1:end],k)./(-A(i,i,k));
                temp2=cumsum(temp2);
                j=find(temp2>=r(2),1,'first');
                if j<i
                    i=j;
                else
                    i=j+1;
                end
                ti=tiNew+1;
            end
        end
        X(ti:end,m)=i;
end
% figure();hold on;
% plot(t,X(:,:))
end
function y=f(A,time,t,tau,r)
    y=integral(@(s)piecewise(A,time,s),t,t+tau)-log(r);
end
function y=piecewise(A,time,t)
    y=zeros(size(t));
    for j=1:1:length(t)
        ti=find(time<t(j),1,'last');
        if isempty(ti)
            ti=1;
        elseif t(j)>time(end)
            ti=length(A);
        end
        y(j)=A(ti);
    end
end