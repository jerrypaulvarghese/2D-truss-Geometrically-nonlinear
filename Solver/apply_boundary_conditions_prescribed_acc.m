function [K_bc, M_bc] = apply_boundary_conditions_prescribed_acc(K, M, prescribedNode)
    K_bc = K; M_bc = M;
    % Apply high stiffness at prescribed node
    K_bc(prescribedNode, :) = 0; K_bc(:, prescribedNode) = 0; K_bc(prescribedNode, prescribedNode) = 1e10;
    M_bc(prescribedNode, :) = 0; M_bc(:, prescribedNode) = 0;
end
