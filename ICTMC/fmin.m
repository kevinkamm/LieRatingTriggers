function r=fmin(x,Amarket,PD,UQt0,t,t0,muQ,muP,comType)
if muP==0
    A=Amarket;
    h=[x;1];
    Ah=changeOfMeasure(A,h,'Type',comType);
    leftQ=UQt0*expm(Ah.*(t-t0));
    rightQ=PD;
    r=muQ*sum(abs(leftQ(1:end-1,end)-rightQ(1:end-1)).^2);
else
    A=x(:,1:end-1);
    h=x(:,end);
    Ah=changeOfMeasure(A,h,'Type',comType);

    leftQ=UQt0*expm(Ah.*(t-t0));
    rightQ=PD;
    r=muQ*sum(abs(leftQ(1:end-1,end)-rightQ(1:end-1)).^2)+muP*sum(abs(A-Amarket).^2,'all');
end
end