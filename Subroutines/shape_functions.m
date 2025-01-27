function [N, dN_dx] = shape_functions(L_e)
    syms xi;
    N = [(1 - xi)/2; (1 + xi)/2];
    dN_dxi = [-0.5; 0.5];
    J = L_e / 2; % Jacobian for element length
    dN_dx = dN_dxi / J;
end
