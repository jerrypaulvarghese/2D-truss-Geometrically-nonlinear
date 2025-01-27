function animate_deformation(u, L_e)
    % ANIMATE_DEFORMATION Animates the dynamic deformation of a 1D truss element
    % and marks L_e on the x-axis.
    %
    % Inputs:
    %   u    - Displacement matrix (2 x num_steps)
    %   L_e  - Length of the truss element
    %
    % Example usage:
    %   animate_deformation(u, L_e);

    % Number of time steps
    num_steps = size(u, 2);

    % Define undeformed configuration
    x_undeformed = [0, L_e];

    % Create figure and set axis properties
    figure; hold on; grid on; axis equal;
    xlim([-0.1 * L_e, 3.5 * L_e]); % Adjust x-axis limits
    ylim([-0.1 * L_e, 0.1 * L_e]); % Adjust y-axis limits
    title('Dynamic Deformation of 1D Truss Element');
    xlabel('X Coordinate (m)');
    ylabel('Y Coordinate (m)');

    % Plot undeformed position
    plot([L_e, L_e], [-0.1 * L_e, 0.1 * L_e], 'k--', 'LineWidth', 1.5); % Mark L_e with a dashed line
    text(L_e, 0.11 * L_e, sprintf('L_e = %.2f m', L_e), 'HorizontalAlignment', 'center', 'FontSize', 10);

    % Plot the initial deformed configuration
    deformed_plot = plot(x_undeformed, [0, 0], 'r-', 'LineWidth', 2);

    % Animate the deformation
    for t = 1:num_steps
        % Compute deformed configuration
        x_deformed = x_undeformed + u(:, t)';

        % Update the plot
        set(deformed_plot, 'XData', x_deformed, 'YData', [0, 0]);

        % Pause for animation effect
        pause(0.05);
    end

    % Hold the final frame
    hold off;
end
