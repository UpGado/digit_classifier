function [result] = feedForward(inputs, weights, biases, activation)
% function [result] = feedForward(inputs, weights, biases, activation)
% Inputs: inputs: the inputs data to the neural net (images)
% weights, biases: the parameters for the neural network
% activation: the squashing function to use in each neuron
% Outputs: result: cell array that contains each layers output, before and
% after the activation function is applied.

% Compute 1st layer from inputs
[~, num_neurons] = size(weights{1});
for i = 1:num_neurons
    % Fetch weights for this neuron
    w = transpose(weights{1}(:,i));
    % Multiply input by its respective weight and add bias
    neuron_val = w * inputs;
    result{1}(i,:) = neuron_val + biases{1}(i);
end
% Apply activation function and save into next cell
result{2} = activation(result{1});

% Do the same for the output layer, usning the hidden layer's output as
% its input
for j = 2:length(weights)
    [~, num_neurons] = size(weights{j});
    for i = 1:num_neurons
        w = transpose(weights{j}(:,i));
        neuron_val = w * result{j};
        result{j+1}(i,:) = neuron_val + biases{j}(i);
    end
    result{j+2} = activation(result{j+1});
end
end
