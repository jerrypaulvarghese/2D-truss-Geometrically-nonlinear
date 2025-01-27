clear; close all; clc;

% Add paths for modular functions (adjust folder names as needed)
addpath('./Post Processor/', './Solver/', './Subroutines/');

% --- Default Parameters ---
E = 1e10; % Young's modulus (Pa)
rho = 7850; % Density (kg/m^3)
A = 6.57 / rho; % Cross-sectional area (m^2)
L_e = 3.0443; % Element length (m)
lumped_mass = 10; % Lumped mass at the tip (kg)
nSteps = 500; dt = 0.01; % Time-stepping
A_acc = 19.6; % Acceleration amplitude (m/s^2)
T = 2.4777; % Period (s)
omega = 2 * pi / T; % Angular frequency

% --- Display Parameters to User ---
params_message = sprintf([ ...
    'Geometrically non-linear 2d Truss element:\n\n' ...
    'Material Properties:\n' ...
    '  - Young''s Modulus (E): %.2e Pa\n' ...
    '  - Density (rho): %.2f kg/m^3\n' ...
    '  - Cross-sectional Area (A): %.2e m^2\n\n' ...
    'Geometry and Lumped Mass:\n' ...
    '  - Element Length (L_e): %.4f m\n' ...
    '  - Lumped Mass: %.2f kg\n\n' ...
    'Time-Stepping Parameters:\n' ...
    '  - Number of Steps: %d\n' ...
    '  - Time Step (dt): %.4f s\n\n' ...
    'Sinusoidal Acceleration:\n' ...
    '  - Acceleration Amplitude (A_acc): %.2f m/s^2\n' ...
    '  - Period (T): %.4f s\n'], ...
    E, rho, A, L_e, lumped_mass, nSteps, dt, A_acc, T);

choice = questdlg(params_message, ...
    'Run Simulation?', ...
    'Run', 'Cancel', 'Run');

if strcmp(choice, 'Cancel')
    disp('Simulation canceled by user.');
    return;
end

% --- Main Computation ---
% Initialize variables
u = zeros(2, nSteps);
v = zeros(2, nSteps);
a = zeros(2, nSteps);

% Compute Matrices
[N, dN_dx] = shape_functions(L_e);
M = mass_matrix(rho, A, L_e, N);
K = stiffness_matrix(E, A, L_e, dN_dx, u(:, 1));

% Add lumped mass to the tip
M(2, 2) = M(2, 2) + lumped_mass;

% Save Original Stiffness Matrix
K_orig = K;

% Apply Boundary Conditions
[K, M] = apply_boundary_conditions_prescribed_acc(K, M, 2);

% Newmark Integration
beta = 0.25; gamma = 0.5;
time = (0:nSteps) * dt;

for n = 1:nSteps
    % Calculate time
    t = n * dt;

    % Apply sinusoidal acceleration at Node 2 (free node)
    prescribed_acc = A_acc * cos(omega * t);

    % Update stiffness matrix with current displacement
    K = stiffness_matrix(E, A, L_e, dN_dx, u(:, n));

    % Solve for system response at all nodes
    [u(:, n+1), v(:, n+1), a(:, n+1)] = newmark_step_prescribed_acc(K, M, u(:, n), v(:, n), a(:, n), ...
                                                                    prescribed_acc, beta, gamma, dt);
end

% --- Post-Processing ---
reaction_force = K_orig(1, :) * u + M(1, :) * a;

% Plot results
plot_results(time, reaction_force, u, v, a, L_e);

% Animate deformation
animate_deformation(u, L_e);
