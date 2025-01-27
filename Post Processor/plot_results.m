function plot_results(time, reaction_force, u, v, a, L)
    figure;
    subplot(4, 1, 1);
    plot(time, reaction_force, 'b-', 'LineWidth', 1.5);
    xlabel('Time (s)'); ylabel('Reaction Force (N)');
    title('Reaction Force Over Time'); grid on;

    subplot(4, 1, 2);
    plot(time, u(2, :), 'r-', 'LineWidth', 1.5);
    xlabel('Time (s)'); ylabel('Displacement (m)');
    title('Tip Displacement'); grid on;

    subplot(4, 1, 3);
    plot(time, v(2, :), 'g-', 'LineWidth', 1.5);
    xlabel('Time (s)'); ylabel('Velocity (m/s)');
    title('Tip Velocity'); grid on;

    subplot(4, 1, 4);
    plot(time, a(2, :), 'b-', 'LineWidth', 1.5);
    xlabel('Time (s)'); ylabel('Acceleration (m/s^2)');
    title('Tip Acceleration'); grid on;
end
