clear all
close all
clc

% Parameters and initial states
tf = 15;
state = [1; pi/6;0; 0];
parameters = [1; 1; 0.25; 9.81];

% Simulation
try

    %%%%%% MODIFY THE CODE AS YOU SEE FIT

    [tsim,xsim] = ode45(@(t,x)BallAndBeamDynamics(t, x, parameters),[0,tf],state);

catch message
    display('Your simulation failed with the following message:')
    display(message.message)
    display(' ')

    % Assign dummy time and states if simulation failed
    tf = 0.1;
    tsim = [0,tf];
    xsim = 0;
end

%% 3D animation
DoublePlot = true;
scale = 0.25;
FS = 30;
ball_radius = 0.25;

% Create Objects
% Rail
Lrail = 2;
a = ball_radius;
vert{1} = [-Lrail,-a, 0;
           -Lrail, a, 0;
            Lrail, a, 0;
            Lrail,-a, 0];
fac{1} = [1,2,3,4];
% Sphere
[X,Y,Z] = sphere(20);
[fac{2},vert{2},c] = surf2patch(X,Y,Z);

% Animation
tic
t_disp = 0;
SimSpeed = 1;
while t_disp < tf/SimSpeed
    % Interpolate state
     x_disp   = interp1(tsim,xsim,SimSpeed*t_disp)';

    % Unwrap state. MODIFY
    x = x_disp(1);
    theta = x_disp(2); % beam angle
    pos = 1*[x*cos(theta); x*sin(theta)] + ball_radius*[-sin(theta);cos(theta)];
    pos = [pos(1);0;pos(2)]; % ball position

    figid = figure(1);clf;hold on
    if DoublePlot
        subplot(1,2,1);hold on
        DrawBallAndBeam(pos, theta, vert, fac, xsim, ball_radius);
        campos(scale*[10    10     20])
        camtarget(scale*[0,0,1.5])
        camva(30)
        camproj('perspective')
        subplot(1,2,2);hold on
    end
    DrawBallAndBeam(pos, theta, vert, fac, xsim, ball_radius);
    campos(0.4*scale*[1    70     20])
    camtarget(scale*[0,0,1.5])
    camva(30)
    camproj('perspective')
    drawnow

    if t_disp == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    t_disp = toc;
end
