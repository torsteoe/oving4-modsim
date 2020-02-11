function [x_dot] = PendulumDynamics(t, state, parameters)
    F = -10*state(1) -state(4); %x and dx
    [W, RHS] = PendulumODEMatrices(state, F, parameters);
    x_dot = [state(4:6); inv(W)*RHS];
end