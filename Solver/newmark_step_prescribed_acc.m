function [u_new, v_new, a_new] = newmark_step_prescribed_acc(K, M, u_old, v_old, a_old, prescribed_acc, beta, gamma, dt)
    % Predictor phase
    u_pred = u_old + dt * v_old + (0.5 - beta) * dt^2 * a_old;
    v_pred = v_old + (1 - gamma) * dt * a_old;

    % Apply prescribed acceleration at Node 2
    a_new = a_old;
    a_new(2) = prescribed_acc; % Directly set acceleration at Node 2

    % Corrector phase
    u_new = u_pred + beta * dt^2 * a_new;
    v_new = v_pred + gamma * dt * a_new;
end
