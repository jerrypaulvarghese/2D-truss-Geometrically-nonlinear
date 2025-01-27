function K = stiffness_matrix(E, A, L, dN_dx, u_current)
    xi_gauss = [-sqrt(1/3), sqrt(1/3)];
    w_gauss = [1, 1];
    K = zeros(length(dN_dx));

    % Green-Lagrangian strain modification
    for i = 1:length(xi_gauss)
        xi = xi_gauss(i);
        w = w_gauss(i);
        B = double(subs(dN_dx, xi));

        % Compute Green-Lagrangian strain
        du_dx = B' * u_current; % Gradient of displacement
        strain = 0.5 * (du_dx' * du_dx + du_dx); % Green-Lagrangian strain

        % Update stiffness considering nonlinearity
        K = K + (E * A * L / 2) * (1 + strain) * (B' * B) * w;
    end
end
