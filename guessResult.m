function [ guess ] = guessResult( testInputs, weights, biases, activation)
% function [ guess ] = guessResult( testInputs, weights, biases, activation)
%GUESSRESULT This function returns the index of the most activated neuron
%in the output layer.
% Inputs: testInputs: a matrix of 1 or more test pictures (an input
% represents a column if values)
% weights, biases: the parameters for the already trained neural network.
% activation: the function used for activation (ex: sigmoid, tanh)
% Outputs: guess: the index of the most activated output neuron.

vals = feedForward(testInputs, weights, biases, activation);
output = vals{end};

[~, n_tests] = size(output);

guess = zeros(n_tests,1);

for i = 1:n_tests
    [a, ~] = find(output(:,i) == max(output(:,i)));
    if length(a) == 1
        guess(i) = a -1;
    end
end
end

