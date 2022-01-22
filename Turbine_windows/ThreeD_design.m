


% this file is only used to demonstrate how 'surf' can be used to plot 
% 3d blades 


clear all 

nb = 10;

LF = linspace(2,1,nb);
DR = linspace(0,0.5,nb);


[sta1,rot1,A,U] = turbine(0.25, LF(1),DR(1));
n = size(sta1,1);

Xs = sta1(:,1);
Ys = sta1(:,2);
Zs = 10*ones(n,1);

Xr = rot1(:,1);
Yr = rot1(:,2);
Zr = 10*ones(n,1);



    
for i=2:10
    [sta1,rot1,A,U] = turbine(0.25, LF(i),DR(i));

%     sta1 = [sta1,10*ones(n,1)];
    Xs = [Xs,sta1(:,1)];
    Ys = [Ys,sta1(:,2)];
    Zs = [Zs,10+10*(i-1)/9*ones(n,1)];
    
    Xr = [Xr,rot1(:,1)];
    Yr = [Yr,rot1(:,2)];
    Zr = [Zr,10+10*(i-1)/9*ones(n,1)];
end

% hold off
% surf(Xs,Ys,Zs); hold on
% surf(Xr,Yr,Zr)

    hold off

for i=0:10
    th = 20*(i-1)*pi/180;

    Xn = Xs.*cos(th) - Zs.*sin(th);
    Zn = Xs.*sin(th) + Zs.*cos(th);

    surf(Xn,Ys*5,Zn); hold on
    surf(Xn,Ys*5,Zn)
    
    
    Xn = Xr.*cos(th) - Zr.*sin(th);
    Zn = Xr.*sin(th) + Zr.*cos(th);

    
    surf(Xn,Yr*5,Zn); hold on
    surf(Xn,Yr*5,Zn)
end

th = linspace(0,2*pi,40);
% X = 

axis equal;




