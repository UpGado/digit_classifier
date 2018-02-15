function [weights, biases] = initializeNetwork(NETWORK_SIZE)
% function [weights, biases] = initializeNetwork(NETWORK_SIZE)
% Initialize a network with the specified dimensions, using Gaussian
% randomly distributed weights and biases.
% Inputs: NETWORK_SIZE: a row vector containing number of neuron in each
% layer (including input)
% Output: weights, biases: random parameters for the neural network
l = length(NETWORK_SIZE);

% Start from second layer (because first layer is input and does not have
% any calculations)
for j = 2:l
    h = NETWORK_SIZE(j-1);
    i = NETWORK_SIZE(j);
    %TODO: How to preallocate cells?
    if j ~= l
        weights{1,j-1} = randn(h,i);
    else
        weights{1,j-1} = 1 * randn(h,i);
    end
    biases{1,j-1} = randn(1,i);
end
return