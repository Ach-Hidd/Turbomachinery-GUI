function [sta,rot,X,U] = turbine(phi, psi, R)

% phi = 0.54;
% psi = 2.0;
% R = 0.0;

% assume axial velocities to be 1, 
% then velocities in theta direction are simply 
% ctheta = cx*tan(anlges)
cx = 1.0;
U = cx/phi;     % rotational velocity

% system of linear equations
A = [1 1;1 -1];                 % coefficient matrix
b = [(1-2*R)/phi;(psi+1)/phi];  % RHS (right hand side)
X = A\b;                        % solve system to get tan(alfa2)=X(1) and tan(beta3)=X(2)

alfa2=atan(X(1)  )*180.0/pi;
beta2=atan(X(1)-U)*180.0/pi;

alfa3=atan(X(2)+U)*180.0/pi;
beta3=atan(X(2)  )*180.0/pi;




% bezier 2nd order for stator and rotor blades
t=(0:0.05:1)'; F=[(1-t).^2 2*t.*(1-t) t.^2];

% points for plotting stator and rotor blades
% note: tangential velocities are 

ProfTh = 1.0;   % profile thickness

% camber line stator
stator = [U+X(2) 0; 0 -1; -X(1) -2];                bezSta   = F*stator; 
% stator profile pressure side (PS)
statorPS = [U+X(2) 0; 0-ProfTh/2 -1; -X(1) -2];     bezStaPS = F*statorPS; 
% stator profile suction side (SS)
statorSS = [U+X(2) 0; 0+ProfTh/2 -1; -X(1) -2];     bezStaSS = F*statorSS;

sta = [bezStaSS; bezStaPS(end:-1:1,:)];


% camber line rotor
rotor = [0 -3.; -X(1)+U -4; -X(1)+U-X(2) -5];               bezRot   = F*rotor;
% rotor profile pressure side (PS)
rotorPS = [0 -3; -X(1)+U-ProfTh/2 -4; -X(1)+U-X(2) -5];     bezRotPS = F*rotorPS;
% rotor profile suction side (SS)
rotorSS = [0 -3; -X(1)+U+ProfTh/2 -4; -X(1)+U-X(2) -5];     bezRotSS = F*rotorSS;


rot = [bezRotSS; bezRotPS(end:-1:1,:)];


