% Calculate Mutual Information for three particles
% bin size 0.05
% input distribution range (0,0)->(2,2)
% observation range (-2,-2)->(4,4)

clear all
tic  % time counter
load('.\data\savedist_3d_4_05.txt') %loading data
Z=savedist_3d_4_05;
clear savedist_3d_4_05;
% surf([-2:0.1:2],[-2:0.1:2],reshape(Z(:,3),41,41))

% creating P({y}|{x}) matrix for all input time combination
% for example 1st row of this matrix (B) gives P(y|(0,0))
% Last row of matrix B give P(y|(1,1))

[x,y]=meshgrid([0:0.05:2]);
y=reshape(y,[],1);
x=reshape(x,[],1);
Pin=inDist3(x,y,0.5); %inDist function calculate input distribution
Pin=Pin';

%rule to fetch element column-wise
indexy=[];
for k=1:41
a=[1+161*(k-1):41+161*(k-1)];
indexy=[indexy,a]; % indexy give us all input combinations (all {x})
end
indexy=fliplr(indexy);

%rule to fetch element row-wise
indexx=[];
    for i=0:120
        z=[i*161:i*161+120];
        indexx=[indexx,z];
    end

% get input distribution for [(0,0)->(1,1)]

count=1;
for j=indexy
    A=Z(indexx+j,3);
    PYX(count)=0.05*0.05*sum(A.*mylog2(A));
    count=count+1;
end

count=1;
for j=indexx
    B=Z(indexy+j,3);
    PY(count)=0.05*0.05*sum(B.*Pin);
    count=count+1;
end

hy=0.05*0.05*sum(-PY(PY>0).*mylog2(PY(PY>0)));
hyx=-0.05*0.05*sum(Pin.*PYX');
%calculate MI
MI=hy-hyx
toc
memory
