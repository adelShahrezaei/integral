% Calculate Mutual Information for three particles
clear all
tic  % time counter
load('savedist_3d.txt') %loading data
Z=savedist_3d;
clear savedist_3d;
% surf([-2:0.1:2],[-2:0.1:2],reshape(Z(:,3),41,41))

% creating P({y}|{x}) matrix for all input time combination
% for example 1st row of this matrix (B) gives P(y|(0,0))
% Last row of matrix B give P(y|(1,1))

[x,y]=meshgrid([0:0.1:1]);
y=reshape(y,[],1);
x=reshape(x,[],1);
Pin=inDist3(x,y,0.5); %inDist function calculate input distribution
Pin=Pin';

%rule to fetch element column-wise
indexy=[];
for k=1:11
a=[1+41*(k-1):11+41*(k-1)];
indexy=[indexy,a]; % indexy give us all input combinations (all {x})
end
indexy=fliplr(indexy);

%rule to fetch element row-wise
indexx=[];
    for i=0:20
        z=[i*41:i*41+20];
        indexx=[indexx,z];
    end

% get input distribution for [(0,0)->(1,1)]

count=1;
for j=indexy
    A=Z(indexx+j,3);
    PYX(count)=0.01*sum(A.*mylog2(A));
    count=count+1;
end

count=1;
for j=indexx
    B=Z(indexy+j,3);
    PY(count)=0.01*sum(B.*Pin);
    count=count+1;
end

hy=0.01*sum(-PY(PY>0).*mylog2(PY(PY>0)));
hyx=-0.01*sum(Pin.*PYX');
%calculate MI
MI=hy-hyx
toc
memory