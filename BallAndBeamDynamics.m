function [state_dot] = BallAndBeamDynamics(t, state, parameters)
    F = 200*(state(1)-state(2))+ 70*(state(3)-state(4));
    [W, RHS] = BallAndBeamODEMatrices(state, F, parameters);
    state_dot = [state(3:4); W\RHS];
end

