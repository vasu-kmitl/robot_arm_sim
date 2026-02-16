% -----------------------------------
% TSAE Robot Competation
% AE KMITL
% -----------------------------------
clc; clear; close all; format compact

% Basic Geometry
w  = 40;  h  = 40;
a  = 0;  b  = 5;  c = 5; 
W  = 50;  H  = 50;
Nx =  5;  Ny =  5;
px = W/Nx; py = H/Ny;

B  = 5;
L2 = 50;
L3 = 60;
G  = 10;

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
plot(0, 0, 'ro');

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
% target = str2double(split(input('Row I, Col J: ','s'),','));
% I = target(1); J = target(2);

x = (2*I - 1)*px/2 + w/2 + a + b;
y = (2*J - Ny - 1)*py/2;
R = sqrt(x^2 + y^2)
phi1 = atan2d(y,x);
theta1 = phi1+90

arm = [0 0;
       x y];
plot(arm(:,1),arm(:,2))

figure

D  = sqrt(B^2 + R^2);
disp('R B  L2  L3  G  D :')
disp([R B, L2, L3, G, D])

% Calculate angles
theta3 = acosd((L2^2 + L3^2 - D^2) / (2*L2*L3));

alpha = atan2d(R, B);
for i=1:3
    switch i
        case 1, beta = atan2d(L3*sind(180-theta3), L2+L3*cosd(180-theta3));
        case 2, beta = asind(L3*sind(theta3)/D);  % คำนวณมือง่ายแต่อาจมีข้อจำกัด
        case 3, beta = acosd((D^2 + L2^2 - L3^2) / (2*L2*D));
    end
    
    theta2 = alpha + beta;
    
    theta4 = 360 - theta2 - theta3;
    
    disp('theta2  theta3  theta4 :')
    disp([theta2, theta3, theta4])
    
    % Verify the solution
    R_chk = L2*cosd(theta2-90) + L3*cosd(theta4-90)
    B_chk = L3*sind(theta4-90) - L2*sind(theta2-90)
    
    % Plot the result
    % ใช้เป็น input ของงานในภายหลัง
    
    % Convert angles into plotting angles
    q2 = theta2 - 90;
    q3 = q2 + theta3 + 180;
    q4 = q3 + theta4 + 180;
    
    P0 = [0, 0];
    P1 = [L2*cosd(q2), L2*sind(q2)];
    P2 = P1 + [L3*cosd(q3), L3*sind(q3)];
    P3 = P2 + [ G*cosd(q4),  G*sind(q4)];
    P  = [P0; P1; P2; P3]
    
    subplot(3,1,i)
    plot(P(:,1), P(:,2), 'r-o')
    grid on; axis equal 
end
