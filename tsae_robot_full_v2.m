% -----------------------------------
% TSAE Robot Competation
% AE KMITL
% -----------------------------------
clc; clear; close all; format compact

% Basic Geometry
w  = 40;  h  = 40;
a  = 0;  b  = 5;  c = 5; 
B  = 5;
L2 = 70;
L3 = 60;
G  = 10;
XX = [33 43 53 63 73];
YY = [10 20];
X = XX
Y = [-fliplr(YY) 0 YY]

% Sketch base, table and frame 
base = [-w/2 -h/2;
         w/2 -h/2;
         w/2  h/2;
        -w/2  h/2;
        -w/2 -h/2];

figure; hold on; grid on; axis equal; 
plot(base(:,1),base(:,2))
plot(0, 0, 'ro');

% Plot the grid
for j = 1:5
    for i = 1:5
        xPos = X(i);
        yPos = Y(j);
        plot(xPos, yPos, 'ro'); 
    end
end

% Input and plot the target
x = input('x: ');
y = input('y: ');

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
