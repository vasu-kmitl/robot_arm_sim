% -----------------------------------
% TSAE Robot Competation
% AE KMITL
% -----------------------------------
clc; clear; close all; format compact

% Basic Geometry
B  = 5;  G  = 10;
L2 = 70; L3 = 60;

% fprintf('B\tL2\tL3\tG\n')
% fprintf('%.1f\t%.1f\t%.1f\t%.1f\n',B,L2,L3,G)

X = [33 43 53 63 73]
Y = [10 20];

Y = [-fliplr(Y) 0 Y]
dX = X(2)-X(1);

% Plot the origin and grid 
figure; hold on; grid on; axis equal; 
xlim([-dX max(X)+dX]);
xticks([0 X]); yticks(Y);

plot(0, 0, 'ro');
for j = 1:5
    for i = 1:5
        plot(X(i), Y(j), 'ro'); 
    end
end

% Input and plot the target
x = input('x: ');
y = input('y: ');

R = sqrt(x^2 + y^2);
phi1 = atan2d(y,x);
theta1 = phi1+90;

arm = [0 0;
       x y];
plot(arm(:,1),arm(:,2))

figure

D  = sqrt(B^2 + R^2);

% Calculate angles
theta3 = acosd((L2^2 + L3^2 - D^2) / (2*L2*L3));

alpha = atan2d(R, B);
beta = asind(L3*sind(theta3)/D);
theta2 = alpha + beta;

theta4 = 360 - theta2 - theta3;

fprintf('R\tD\talpha\tbeta\n')
fprintf('%.1f\t%.1f\t%.1f\t%.1f\n\n',R,D,alpha,beta)

fprintf('theta1\ttheta2\ttheta3\ttheta4\n')
fprintf('%.1f\t%.1f\t%.1f\t%.1f\n',theta1,theta2,theta3,theta4)

% Verify the solution
% R_chk = L2*cosd(theta2-90) + L3*cosd(theta4-90)
% B_chk = L3*sind(theta4-90) - L2*sind(theta2-90)

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
P  = [P0; P1; P2; P3];

plot(P(:,1), P(:,2), 'r-o')
grid on; axis equal
xticks(round([0 P2(1)],1))
