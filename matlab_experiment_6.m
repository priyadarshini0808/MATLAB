% M-file: mag_field.m
% This script calculates and visualizes the net magnetic field 
% produced by a three-phase stator.

clc; clear; close all;

% Set up basic conditions
bmax = 1;          % Normalize max magnetic flux density to 1
freq = 60;         % Frequency in Hz
w = 2 * pi * freq; % Angular velocity in rad/s
t = 0:1/6000:1/60; % Time vector (small increments for smooth animation)

% Generate the three-phase magnetic fields
Baa = sin(w*t) .* (cos(0) + 1j*sin(0));
Bbb = sin(w*t - 2*pi/3) .* (cos(2*pi/3) + 1j*sin(2*pi/3));
Bcc = sin(w*t + 2*pi/3) .* (cos(-2*pi/3) + 1j*sin(-2*pi/3));

% Calculate net magnetic field
Bnet = Baa + Bbb + Bcc;

% Generate a reference circle for visualization
circle = 1.5 * (cos(w*t) + 1j * sin(w*t));

% Animation loop to visualize the rotating field
for i = 1:length(t)
    clf; % Clear previous figure

    % Plot reference circle (black)
    plot(real(circle), imag(circle), 'k'); 
    hold on;

    % Plot individual phase magnetic fields
    plot([0 real(Baa(i))], [0 imag(Baa(i))], 'k', 'LineWidth', 2); % Phase A
    plot([0 real(Bbb(i))], [0 imag(Bbb(i))], 'b', 'LineWidth', 2); % Phase B
    plot([0 real(Bcc(i))], [0 imag(Bcc(i))], 'm', 'LineWidth', 2); % Phase C

    % Plot net magnetic field (red)
    plot([0 real(Bnet(i))], [0 imag(Bnet(i))], 'r', 'LineWidth', 3);

    % Formatting
    axis square;
    axis([-2 2 -2 2]);
    grid on;
    xlabel('Real Axis');
    ylabel('Imaginary Axis');
    title('Rotating Magnetic Field');
    
    drawnow; % Update the plot dynamically
    hold off;
end
