function [W,RHS] = PendulumODEMatrices(in1,F,in3)
%PENDULUMODEMATRICES
%    [W,RHS] = PENDULUMODEMATRICES(IN1,F,IN3)

%    This function was generated by the Symbolic Math Toolbox version 7.2.
%    11-Feb-2020 15:53:27

L = in3(3,:);
M = in3(2,:);
dtheta1 = in1(5,:);
dtheta2 = in1(6,:);
dx = in1(4,:);
g = in3(4,:);
m = in3(1,:);
theta1 = in1(2,:);
theta2 = in1(3,:);
t2 = cos(theta1);
t3 = L.*M.*t2.*2.0;
t4 = L.^2;
t5 = cos(theta2);
t6 = L.*M.*t5;
t7 = theta1-theta2;
t8 = cos(t7);
t9 = M.*t4.*t8;
W = reshape([M.*2.0+m,t3,t6,t3,M.*t4.*2.0,t9,t6,t9,M.*t4],[3,3]);
if nargout > 1
    t10 = sin(theta1);
    t11 = sin(theta2);
    t12 = sin(t7);
    t13 = L.*dtheta1.*dtheta2.*t12;
    RHS = [F;L.*M.*(t13-g.*t10.*2.0+dtheta1.*dx.*t10.*2.0);-L.*M.*(t13+g.*t11-dtheta2.*dx.*t11)];
end