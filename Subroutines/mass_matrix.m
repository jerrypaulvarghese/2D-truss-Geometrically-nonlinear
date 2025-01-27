function M = mass_matrix(rho, A, L, N)
    xi_gauss = [-sqrt(1/3), sqrt(1/3)];
    w_gauss = [1, 1];
    M = zeros(length(N));
    for i = 1:length(xi_gauss)
        xi = xi_gauss(i); w = w_gauss(i);
        N_xi = double(subs(N, xi));
        M = M + (rho * A * L / 2) * (N_xi * N_xi') * w;
    end
end
