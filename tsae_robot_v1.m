% -----------------------------------
% TSAE Robot Competation
% AE KMITL
% -----------------------------------
clc; clear all; close all

% Define parameters
L1 = 30
L2 = 40
L3 = 10
H  = 5
R  = 60 % โดยการวัด / ควรมาจากผลลัพธ์ของ stage 1

% Calculate angles
D  = sqrt(R^2 + H^2);
q3 = acos((L1^2 + L2^2 - D^2) / (2*L1*L2)) /pi*180;

alpha = atan2(R, H) /pi*180;
beta  = acos((D^2 + L1^2 - L2^2) / (2*D*L1)) /pi*180;
q2    = alpha + beta;

q4 = 360 - q2 - q3;

% Report angles
theta = [q2, q3, q4]

% Verify the solution
R = L1*cosd(q2-90) + L2*cosd(q4-90)
H = L2*sind(q4-90) - L1*sind(q2-90)

% Plot the result
% ใช้เป็น input ของงานในภายหลัง
P0 = [0, 0];
P1 = [L1*cosd(q2), L1*sind(q2)];
P2 = P1 + [L2*cosd(q3+q2), L2*sind(q3+q2)];
P3 = P2 + [L3*cosd(q4+q3+q2), L3*sind(q4+q3+q2)];
P  = [P0; P1; P2; P3]

plot(P(:,1), P(:,2), '-o')
grid on; axis equal
