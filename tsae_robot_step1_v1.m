% -----------------------------------
% TSAE Robot Competation: Step 1
% AE KMITL
% -----------------------------------
clc; clear; close all; format compact

% Basic Geometry
w  = 40;  h  = 40;
a  = 10;  b  = 20;  c = 20; 
W  = 50;  H  = 50;
Nx =  5;  Ny =  5;
px = W/Nx; py = H/Ny;

% Sketch base, table and frame 
base = [-w/2 -h/2;
         w/2 -h/2;
         w/2  h/2;
        -w/2  h/2;
        -w/2 -h/2];

table = [0 -H/2;
         W -H/2;
         W  H/2;
         0  H/2;
         0 -H/2] + [w/2+a+b 0];

frame = [ -b -H/2-c;
         W+b -H/2-c;
         W+b  H/2+c;
          -b  H/2+c;
          -b -H/2-c] + [w/2+a+b 0];

figure; hold on; grid on; axis equal; 
plot(base(:,1),base(:,2))
plot(table(:,1),table(:,2))
plot(frame(:,1),frame(:,2))

% Plot the grid
for j = 1:Ny
    for i = 1:Nx
        xPos = (2*i -1)*px/2  + w/2 + a + b;
        yPos = (2*j - Ny - 1)*py/2;
        plot(xPos, yPos, 'ro'); 
    end
end

% Input and plot the target
I = input('Col I: ');
J = input('Row J: ');

x = (2*I - 1)*px/2 + w/2 + a + b;
y = (2*J - Ny - 1)*py/2;
R = sqrt(x^2 + y^2)
phi1 = atan2d(y,x);
theta1 = phi1+90

arm = [0 0;
       x y];
plot(arm(:,1),arm(:,2))
